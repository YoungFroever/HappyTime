//
//  ImageModel.m
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/8.
//  Copyright © 2016年 young. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(instancetype)modelWithImgDictionary:(NSDictionary *)dic{
    ImageModel * nl = [[ImageModel alloc]init];
//    nl.ref = dic[@"ref"];
//    nl.pixel = dic[@"pixel"];
//    nl.src = dic[@"src"];
    
    [nl setValuesForKeysWithDictionary:dic];
    return nl;
}

@end
