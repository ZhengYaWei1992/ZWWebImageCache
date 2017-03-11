//
//  NSString+Path.h
//
//  Created by  on 16/6/10.
//  Copyright © 2016年 郑亚伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

/// 给当前文件追加文档路径
- (NSString *)appendDocumentDir;

/// 给当前文件追加缓存路径
- (NSString *)appendCacheDir;

/// 给当前文件追加临时路径
- (NSString *)appendTempDir;

@end
