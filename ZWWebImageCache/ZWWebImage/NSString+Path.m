//
//  NSString+Path.m
//
//  Created by  on 16/6/10.
//  Copyright © 2016年 郑亚伟. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)appendDocumentDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendCacheDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    //NSLog(@"%@",self.lastPathComponent);
   // return [dir stringByAppendingPathComponent:self.lastPathComponent];
    //NSLog(@"%@",[dir stringByAppendingPathComponent:self.lastPathComponent]);
    //这里要用self.lastPathComponent否则中间的路径文件夹可能无法创建，读取文件也会失败
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendTempDir {
    NSString *dir = NSTemporaryDirectory();
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

@end
