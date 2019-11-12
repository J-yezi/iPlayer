//
//  FFmpegUtil.h
//  iPlayer
//
//  Created by 叶浩 on 2019/11/5.
//  Copyright © 2019 叶浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFmpegModel : NSObject

@property(assign, nonatomic) int frameWidth;
@property(assign, nonatomic) int frameHeight;

- (instancetype)initWith:(NSString *)path;
- (UIImage *)cover;

@end

NS_ASSUME_NONNULL_END
