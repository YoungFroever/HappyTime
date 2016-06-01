//
//  ImageModel.h
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/8.
//  Copyright © 2016年 young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

/** 图片位置 */
@property(nonatomic, copy)NSString * ref;

/** 图片链接 */
@property(nonatomic, copy)NSString * src;

/** 图片链接 */
@property(nonatomic, copy)NSString * pixel;

+(instancetype)modelWithImgDictionary:(NSDictionary *)dic;
@end
