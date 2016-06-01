//
//  DetailViewController.m
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/7.
//  Copyright © 2016年 young. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking.h>
#import "NewsList.h"
#import "VideoModel.h"
#import "ImageModel.h"
#import "ImageDetailViewController.h"
@interface DetailViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic, strong)UITextView * text;
@property(nonatomic, strong)UIWebView * web;
@property(nonatomic, strong)NewsList * detailModel;
@property(nonatomic, strong)NSMutableArray * imageArr;
@property(nonatomic, strong)NSMutableArray * videoArr;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArr = [NSMutableArray array];
    self.videoArr = [NSMutableArray array];
    
    self.web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.web.delegate = self;
    [self createNetConnect];
    [self.view addSubview:self.web];
    
}
-(void)createNetConnect{
    NSString * url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.artId];
   
    NSLog(@"url==%@",url);
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.detailModel = [NewsList modelWithDictionary:responseObject[self.artId]];
        [self showBasicWeb];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error.description);
    }];
    
}
-(void)showBasicWeb{
    NSMutableString * html = [NSMutableString string];
    [html appendString:@"<!DOCTYPE HTML>"];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:[self bodyStr]];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    NSLog(@"%@",html);
    [self.web loadHTMLString:html baseURL:nil];
}
-(NSString *)bodyStr{
    
    /*
     目标1:首页实现缓存
     目标2:点击图片可以调到图片浏览模式,放大缩小等手势
     目标3.弄明白各个符号是什么意思,做到100%吻合
     目标4.可以播放视频
     目标5.可以播放音频
     */
    /*
     特殊符号:
     <!--IMG#0--> 图片 img数组
     <!--@@PKVOTEID=51240--> (pk vote id = 51259)投票ID votes数组里面包括字典,字典下面有数组voteitem下面又有投票双方和内容,投票数字..
     <!--REWARD#0--> 打赏 rewards数组, 应该是个label形式的,给出了作者和描述,头像等等
     <!--link0-->  link数组 和打赏一样类似一个label形式的,给出了图片,标题和描述和链接 点击后类似于h5样式的网页,多是答题性质的, href里面的链接用电脑打不出内容,用手机可以得到完整的答题流程,其原理是传入了大量的js(包括题目和答案)和图片等,不知道怎么组合起来的, 题目js http://yxzdy.m.163.com/cdn/kxdtq28/res/questions.js ,打开文字乱码,有正确答案
     <!--VIDEO#0--> 视频数组,里面可以有音频,点击后进入一个小型的音乐播放器界面,有快进后退等,如果url_mp4后缀为mp3,进入音乐播放器页,如果后缀为mp4,竖屏进入视频播放..
     正式版的下面还有一个分享到朋友圈
     热门跟帖
     输入跟帖(录音,文字..)
     */
    
    NSMutableString * body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    [body appendFormat:@"<div class=\"author\">%@<div>",self.detailModel.ec];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
//    图片html字符串替换 BK4HTLPL00964LQ9
    for (NSInteger i = 0; i < self.detailModel.img.count; i++) {
        NSMutableString * imgHtml = [NSMutableString string];
        [imgHtml appendString:@"<div class = \"img-parent\">"];
        ImageModel * imageModel = [ImageModel modelWithImgDictionary:self.detailModel.img[i]];
        NSArray * pixel = [imageModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";

        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,imageModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:imageModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];

    }
//    视频图片html字符串替换
    for (NSInteger i = 0; i < self.detailModel.video.count; i++) {
        NSMutableString * videoHtml = [NSMutableString string];
        [videoHtml appendString:@"<div class = \"video-parent\">"];
        VideoModel * videoModel = [VideoModel modelWithVideoDictionary:self.detailModel.video[i]];
//        NSString * videoPic = videoModel.cover;
//        加<p>在html中不警告
//        [videoHtml appendFormat:@"<video src=\"%@\" controls=\"controls\"></video>",videoModel.url_mp4];
        [videoHtml appendFormat:@"<img src=\"%@\"",videoModel.cover];
        [body replaceOccurrencesOfString:videoModel.ref withString:videoHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
        }
      return body;
}
#pragma mark - ******************** 将发出通知时调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"sx:src="];
    if (range.location != NSNotFound) {
        NSInteger begin = range.location + range.length;
        NSString *src = [url substringFromIndex:begin];
        NSLog(@"src==%@",src);
//        保存图像方法
//        [self savePictureToAlbum:src];
//        跳转图像详情
        [self ImageDetail:src];
        
        return NO;
    }
    return YES;
}
-(void)ImageDetail:(NSString *)src{
    ImageDetailViewController * iv = [[ImageDetailViewController alloc]init];
    iv.imageStr = src;
    [self.navigationController pushViewController:iv animated:YES];
    
}
#pragma mark - ******************** 保存到相册方法
- (void)savePictureToAlbum:(NSString *)src
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
//        保存到相册方法
        NSURLCache *cache =[NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:src]];
        NSData *imgData = [cache cachedResponseForRequest:request].data;
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
