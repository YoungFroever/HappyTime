//
//  VideoModel.m
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/8.
//  Copyright © 2016年 young. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(instancetype)modelWithVideoDictionary:(NSDictionary *)dic{
    VideoModel * nl = [[VideoModel alloc]init];
    [nl setValuesForKeysWithDictionary:dic];
    return nl;
}

@end
