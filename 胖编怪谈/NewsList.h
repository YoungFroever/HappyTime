//
//  NewsList.h
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/7.
//  Copyright © 2016年 young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsList : NSObject
@property(nonatomic, strong)NSString * ltitle;

/** 每期必有 */
@property(nonatomic, strong)NSString * digest;

/** 文章id */
@property(nonatomic, strong)NSString * docid;

/** 新闻标题 */
@property(nonatomic, strong)NSString * title;

/** 新闻发布时间 */
@property(nonatomic, strong)NSString * ptime;

/** 作者 */
@property(nonatomic, strong)NSString * ec;

/** 文章主体 */
@property(nonatomic, strong)NSString * body;

/** 文字配图 */
@property(nonatomic, strong)NSArray * img;

/** 视频数组 */
@property(nonatomic, strong)NSArray * video;


+(instancetype)modelWithDictionary:(NSDictionary *)mainDic;
@end
