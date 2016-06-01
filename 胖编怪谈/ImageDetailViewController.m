//
//  ImageDetailViewController.m
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/14.
//  Copyright © 2016年 young. All rights reserved.
//

#import "ImageDetailViewController.h"

@interface ImageDetailViewController ()

@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    CGRect frame = self.view.bounds;
    frame.origin.y = 64;
    frame.size.height -= 64;

    self.view.backgroundColor = [UIColor whiteColor];
    NSURL * url = [NSURL URLWithString:self.imageStr];
    NSData * data = [NSData dataWithContentsOfURL:url];
    UIImage * image = [UIImage imageWithData:data];
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, image.size.height)];
    iv.contentMode = UIViewContentModeCenter;
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.userInteractionEnabled = YES;
    iv.image = image;
    [self.view addSubview:iv];
    
    UIGestureRecognizer * gest = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(hello)];
    [iv addGestureRecognizer:gest];
}
-(void)hello{
    NSLog(@"hello");
}
#pragma mark - ******************** 保存到相册方法
- (void)savePictureToAlbum:(NSString *)src
{ NSLog(@"save");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
