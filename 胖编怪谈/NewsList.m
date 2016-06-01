//
//  NewsList.m
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/7.
//  Copyright © 2016年 young. All rights reserved.
//

#import "NewsList.h"
#import "ImageModel.h"
@implementation NewsList

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(instancetype)modelWithDictionary:(NSDictionary *)mainDic{
    NewsList * detail = [[NewsList alloc]init];
//    detail.title = dic[@"title"];
//    detail.ptime = dic[@"ptime"];
//    detail.body = dic[@"body"];
    
    NSArray * imageArray = mainDic[@"img"];
    NSMutableArray * temArr = [NSMutableArray arrayWithCapacity:imageArray.count];
//    把image的模型存放到list的image数组里
    for (NSDictionary * imageDic in imageArray) {
        ImageModel * imgModel = [ImageModel modelWithImgDictionary:imageDic];
        [temArr addObject:imgModel];
    }
    detail.img = temArr;
//    NSLog(@"%@",detail.img);
    [detail setValuesForKeysWithDictionary:mainDic];
    return detail;
}
@end
