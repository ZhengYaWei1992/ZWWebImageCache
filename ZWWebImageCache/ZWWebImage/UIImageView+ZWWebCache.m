//
//  UIImageView+ZWWebCache.m
//  ZWWebImage
//
//  Created by 郑亚伟 on 2017/3/9.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "UIImageView+ZWWebCache.h"
#import "ZWDownloderOperationManager.h"
#import <objc/runtime.h>


@interface UIImageView ()
//当前的显示图片的地址
@property(nonatomic,copy)NSString *currentURLString;

@end


@implementation UIImageView (ZWWebCache)


- (void)zw_setImageWithUrlString:(NSString *)urlString{
    //防止连续设置图片，UIImageView上的图片频繁切换
    //判断当前点击的图片地址和上一次图片的地址是否一样，如果不一样取消上一次操作
    if (![urlString isEqualToString:self.currentURLString]) {
        //取消上一次操作
        //[self.operationCache[self.currentURLString] cancel];
        [[ZWDownloderOperationManager sharedManager]cancelOperation:self.currentURLString];
    }
    //记录上一次的图片地址
    self.currentURLString = urlString;
    //下载图片
    [[ZWDownloderOperationManager sharedManager]downloadWithURLString:urlString finishedBlock:^(UIImage *image) {
        self.image = image;
    }];
}

- (void)zw_setImageWithUrlString:(NSString *)urlString withPlaceHolderImageName:(NSString *)placeholderStr{
    self.image = [UIImage imageNamed:placeholderStr];
    [self zw_setImageWithUrlString:urlString];
}

- (void)setCurrentURLString:(NSString *)currentURLString{
    objc_setAssociatedObject(self, @"currentURLString", currentURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)currentURLString{
    return  objc_getAssociatedObject(self, @"currentURLString");
}

@end
