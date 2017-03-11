//
//  HMDownloderOperationManager.h
//  ZWWebImage
//
//  Created by 郑亚伟 on 2017/3/9.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWDownloderOperationManager : NSObject
//单列
+ (instancetype)sharedManager;
//下载图片
- (void)downloadWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *image))finishedBlock;

//取消操作
- (void)cancelOperation:(NSString *)urlString;


@end
