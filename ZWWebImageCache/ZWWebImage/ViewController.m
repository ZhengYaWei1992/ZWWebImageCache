//
//  ViewController.m
//  ZWWebImage
//
//  Created by 郑亚伟 on 2017/3/9.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+ZWWebCache.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//图片地址数组
@property(nonatomic,strong)NSArray *urlStringArr;

@property(nonatomic,strong)UIView *containerView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _urlStringArr = [NSArray arrayWithObjects:
                     @"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160503/14622764778932thumbnail.jpg",
                     @"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160426/14616659617000.jpg",
                     @"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160519/14636463273461.JPEG",
                     @"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160519/14636417251850.jpg",
                     @"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160519/14636417276611.jpg",
                     @"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160519/14636417292422.jpg",
                     nil];
    
    
    _containerView = [[UIView alloc] init];
    _containerView.bounds = CGRectMake(0, 0, 340, 340);
    _containerView.backgroundColor = [UIColor lightGrayColor];
    _containerView.center = self.view.center;
    [self.view addSubview:_containerView];
    
    NSInteger column = 0;
    NSInteger row = 0;
    CGFloat ivX = 0;
    CGFloat ivY = 0;
    CGFloat ivW = 100;
    CGFloat padding = 10;
    for (NSUInteger i=0; i <self.urlStringArr.count; i++) {
        UIImageView *iv = [UIImageView new];
        //不带占位图
        //[iv zw_setImageWithUrlString:self.urlStringArr[i]];
        //带有占位图
        [iv zw_setImageWithUrlString:self.urlStringArr[i] withPlaceHolderImageName:@"placeholder"];
        iv.tag = i;
        iv.userInteractionEnabled = YES;
        column = i % 3;
        row = i /3;
        ivX = padding + (ivW + padding) * column;
        ivY = padding + (ivW + padding) * row;
        iv.frame = CGRectMake(ivX, ivY, ivW, ivW);
        [_containerView addSubview:iv];
    }

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //int index = arc4random_uniform((u_int32_t)self.urlStringArr.count);
    
    //[self.imageView zw_setImageWithUrlString:self.urlStringArr[index]];
    //设置图片带有占位图
    //[self.imageView zw_setImageWithUrlString:self.urlStringArr[index] withPlaceHolderImageName:@"人物写真17.jpg"];
}

@end
