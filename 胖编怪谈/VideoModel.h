//
//  VideoModel.h
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/8.
//  Copyright © 2016年 young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

/** 视频位置 */
@property(nonatomic, strong)NSString * ref;

/** 视频封面图片 */
@property(nonatomic, strong)NSString * cover;

/** 音频地址 */
@property(nonatomic, strong)NSString * url_m3u8;

/** 视频地址 */
@property(nonatomic, strong)NSString * url_mp4;

+(instancetype)modelWithVideoDictionary:(NSDictionary *)dic;

@end
