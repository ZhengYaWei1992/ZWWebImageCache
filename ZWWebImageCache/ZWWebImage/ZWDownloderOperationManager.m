//
//  HMDownloderOperationManager.m
//  ZWWebImage
//
//  Created by 郑亚伟 on 2017/3/9.
//  Copyright © 2017年 zhengyawei. All rights reserved.
/*
 该类主要负责:
 1、管理全局下载
 2、管理全局缓存
 */


#import "ZWDownloderOperationManager.h"
#import "ZWDownloadOperation.h"
#import "NSString+Path.h"

@interface  ZWDownloderOperationManager()

//全局队列
@property(nonatomic,strong)NSOperationQueue *queue;
//下载操作缓存池   这里不能改为NSCache，因为收到内存警告后NSCache移除所有对象，之后NSCache中就无法继续添加数据了
@property(nonatomic,strong)NSMutableDictionary *operationCache;
//图片缓存池(内存缓存)  从字典改为NSCache
@property(nonatomic,strong)NSCache *imageCache;

@end

@implementation ZWDownloderOperationManager

+ (instancetype)sharedManager{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (void)downloadWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *image))finishedBlock{
    //断言
    NSAssert(finishedBlock != nil, @"finishedBlock不能为空");
    
    //如果下载操作已经存在，直接返回。避免重复下载
    if (self.operationCache[urlString]) {
        return;
    }
    
    //判断图片是否有缓存（内存和磁盘缓存）
    if ([self checkImageCache:urlString]) {
        //如果有缓存，就要回调设置图像
        finishedBlock([self.imageCache objectForKey:urlString]);
        return;
    }
    
    ZWDownloadOperation *op = [ZWDownloadOperation downloaderOperationWithURLString:urlString finishedBlock:^(UIImage *image) {
        //回调
        finishedBlock(image);
        
        //缓存图片(内存缓存)
        //self.imageCache[urlString] = image;
        [self.imageCache setObject:image forKey:urlString];
        //下载完成，移除缓存的操作
        [self.operationCache removeObjectForKey:urlString];
    }];
    [self.queue addOperation:op];
    //缓存下载操作
    self.operationCache[urlString] = op;
}

//取消操作
- (void)cancelOperation:(NSString *)urlString{
    //避免第一次urlString为空，然后调用[self.operationCache removeObjectForKey:urlString]导致崩溃的问题
    if (urlString == nil) {
        return;
    }
    [self.operationCache[urlString] cancel];
    //从缓存池移除操作
    [self.operationCache removeObjectForKey:urlString];
}

//检查是否有缓存（内存缓存和磁盘缓存）
- (BOOL) checkImageCache:(NSString *)urlString{
    //1、检查内存缓存
    if ([self.imageCache objectForKey:urlString]) {
        NSLog(@"从内存中加载");
        return YES;
    }
    
    //2、检查沙盒缓存
    UIImage *img = [UIImage imageWithContentsOfFile:[urlString appendCacheDir]];
    //NSLog(@"沙盒路径:%@",[urlString appendCacheDir]);
    if (img) {
        NSLog(@"从沙盒中加载 ");
        //如果沙盒有图片，要保存到内存中============
        //self.imageCache[urlString] = img;
        [self.imageCache setObject:img forKey:urlString];
        return YES;
    }
    
    return NO;
}
#pragma mark - 懒加载
- (NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc]init];
        //设置最大并发数，不设置所有都会同时开始执行，任务过多不利于性能，一般不要超过8左右
        _queue.maxConcurrentOperationCount = 4;
    }
    return _queue;
}
- (NSMutableDictionary *)operationCache{
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}
- (NSCache *)imageCache{
    if (_imageCache == nil) {
        _imageCache = [[NSCache alloc]init];
        //设置最多缓存100张图片
        _imageCache.countLimit = 100;
    }
    return _imageCache;
}

@end
