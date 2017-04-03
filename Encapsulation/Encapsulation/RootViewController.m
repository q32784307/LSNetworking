//
//  RootViewController.m
//  Encapsulation
//
//  Created by 李帅 on 16/3/24.
//  Copyright © 2016年 漠然丶情到深处. All rights reserved.
//

#import "RootViewController.h"
#import "PublicClass.h"
#import "RightViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"封装";
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"返回";
        self.navigationItem.backBarButtonItem = backItem;
        
        //添加
        UIBarButtonItem *rightSharBt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(shardBtA)];
        NSArray *buttonItem = @[rightSharBt];
        self.navigationItem.rightBarButtonItems = buttonItem;
    }
    return self;
}

- (void)shardBtA {
    RightViewController *RightVC = [[RightViewController alloc]init];
    [self.navigationController pushViewController:RightVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIButton *getRequest = [[UIButton alloc]initWithFrame:CGRectMake(75, 100, 150, 50)];
    getRequest.backgroundColor = [UIColor orangeColor];
    [getRequest setTitle:@"get 请求" forState: UIControlStateNormal];
    [getRequest addTarget:self action:@selector(getRequestButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getRequest];
    
    UIButton *getRequestHeader = [[UIButton alloc]initWithFrame:CGRectMake(75, 170, 150, 50)];
    getRequestHeader.backgroundColor = [UIColor orangeColor];
    [getRequestHeader setTitle:@"get 请求自定义请求头" forState:UIControlStateNormal];
    [getRequestHeader addTarget:self action:@selector(getRequestHeaderButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getRequestHeader];
    
    UIButton *postRequest = [[UIButton alloc]initWithFrame:CGRectMake(75, 240, 150, 50)];
    postRequest.backgroundColor = [UIColor orangeColor];
    [postRequest setTitle:@"post 请求" forState: UIControlStateNormal];
    [postRequest addTarget:self action:@selector(postRequestButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postRequest];
    
    UIButton *postImaegRequest = [[UIButton alloc]initWithFrame:CGRectMake(75, 310, 150, 50)];
    postImaegRequest.backgroundColor = [UIColor orangeColor];
    [postImaegRequest setTitle:@"单图上传" forState: UIControlStateNormal];
    [postImaegRequest addTarget:self action:@selector(postImageRequestButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postImaegRequest];
    
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(75, 400, 200, 50)];
    labelOne.text = @"这是labelOne的高度自适应这是labelOne的高度自适应这是labelOne的高度自适应这是labelOne的高度自适应";
    labelOne.backgroundColor = [UIColor redColor];
    labelOne.font = [UIFont systemFontOfSize:20];
    labelOne.numberOfLines = 0;
    CGFloat height = [PublicClass getHeightByWidth:labelOne.frame.size.width title:labelOne.text font:labelOne.font];
    labelOne.frame = CGRectMake(75, 400, 200, height);
    [self.view addSubview:labelOne];
}

- (void)getRequestButton
{
    
}

- (void)getRequestHeaderButton {
     NSString *url = [NSString stringWithFormat:@""];
    if ([PublicClass isNetWorkConnectionAvailable]) {
        
        [PublicClass getRequestWithHTTPHeader:@"Basic MTM4MjE1NTk3NjM6MTExMTEx" Url:url parmater:nil isOpenHUD:YES SuccessBlock:^(NSData *data) {
            
            NSDictionary *getResultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",getResultDic);
            
        } FailureBlock:^(NSError *error) {
            
        }];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请检查网络" delegate: self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        [alertView show];
    }
}

- (void)postRequestButton
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSDictionary *contentDic = @{@"blood_hPress":@"220",@"blood_lPress":@"140",@"pulse":@"80",@"measure_time":@"2016-01-07 11:27",@"remark":@"啊干活就撒娇啊收购价是"};
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [dic setObject:jsonString forKey:@"content"];
    NSString *url = [NSString stringWithFormat:@""];
    if ([PublicClass isNetWorkConnectionAvailable]) {
        [PublicClass postRequestWithHTTPHeader:nil Url:url parmater:nil isOpenHUD:YES SuccessBlock:^(NSData *data) {
            NSDictionary *postResultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",postResultDic);
        } FailureBlock:^(NSError *error) {
            
        }];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请检查网络" delegate: self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        [alertView show];
    }
}

- (void)postImageRequestButton
{
    NSString *url = [NSString stringWithFormat:@""];
    NSData *data;
    if ([PublicClass isNetWorkConnectionAvailable]) {
        [PublicClass postRequestWithHTTPHeader:nil ImageUploadRequestWithUrl:url parmater:nil isOpenHUD:YES fileData:data fileName:@"user_picture" SuccessBlock:^(NSData *data) {
            NSDictionary *postResultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",postResultDic);
        } FailureBlock:^(NSError *error) {
            
        }];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请检查网络" delegate: self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        [alertView show];
    }
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
