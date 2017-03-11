//
//  ZWDownloadOperation.h
//  ZWWebImage
//
//  Created by 郑亚伟 on 2017/3/9.
//  Copyright © 2017年 zhengyawei. All rights reserved.

//自定义操作：下载操作类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZWDownloadOperation : NSOperation

//下载图片的地址
@property(nonatomic,copy)NSString *urlString;
//执行完成任务之后的回调block
@property(nonatomic,copy)void (^finishedBlock)(UIImage *img);

+ (instancetype)downloaderOperationWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *image))finishedBlock;

@end
