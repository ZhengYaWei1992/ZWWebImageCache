//
//  UIImageView+ZWWebCache.h
//  ZWWebImage
//
//  Created by 郑亚伟 on 2017/3/9.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import <UIKit/UIKit.h>


//分类中不能增加成员变量，可以利用运行时关联对象增加属性，
@interface UIImageView (ZWWebCache)

//设置图片
- (void)zw_setImageWithUrlString:(NSString *)urlString;

//设置图片，带有占位图
- (void)zw_setImageWithUrlString:(NSString *)urlString withPlaceHolderImageName:(NSString *)placeholderStr;

@end
