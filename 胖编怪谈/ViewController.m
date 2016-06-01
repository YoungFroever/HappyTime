//
//  ViewController.m
//  胖编怪谈
//
//  Created by htjc-yj on 16/4/7.
//  Copyright © 2016年 young. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "NewsList.h"
#import "VideoModel.h"
#import "ImageModel.h"
static NSString * iden = @"justIden";
//static NSString * url = @"http://c.m.163.com/nc/special/S1426235566308.html";
//轻松时刻
static NSString * url = @"http://c.m.163.com/nc/special/S1426236075742.html";
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic, strong)UITableView * netTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    self.netTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.netTable.dataSource = self;
    self.netTable.delegate = self;
    self.netTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self createNetConnect];
    [self.view addSubview:self.netTable];
}
-(void)createNetConnect{
    
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        NSDictionary * totalDic = responseObject[@"S1426235566308"];
        NSDictionary * totalDic = responseObject[@"S1426236075742"];
                    NSArray * topicsArr = totalDic[@"topics"];
                    NSDictionary * docsDic = topicsArr[0];
        
                    NSArray * arr = docsDic[@"docs"];
        
                    for (NSInteger i = 0; i < arr.count; i++) {
        
                        NewsList * nl = [NewsList modelWithDictionary:arr[i]];
                        [self.dataSource addObject:nl];
                    }
        NSLog(@"%lu",(unsigned long)self.dataSource.count);
        [self.netTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    NewsList * nl = [[NewsList alloc]init];
    nl = self.dataSource[indexPath.row];
    cell.textLabel.text = nl.digest;
//    NSLog(@"%@",nl.ltitle);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController * dvc = [[DetailViewController alloc]init];
    NewsList * nl = [[NewsList alloc]init];
    nl = self.dataSource[indexPath.row];
    dvc.artId = nl.docid;
    [self.navigationController pushViewController:dvc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
