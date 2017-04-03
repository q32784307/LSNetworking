//
//  UserModel.m
//  Encapsulation
//
//  Created by 丶离人梦 on 2017/1/17.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import "UserModel.h"
#import "PublicClass.h"

@implementation UserModel

- (void)getRequest {
    NSString *url = [NSString stringWithFormat:@"http://d.api.wanhuhealth.com/patientapp/v1/patientusers"];
    if ([PublicClass isNetWorkConnectionAvailable]) {
        [PublicClass getRequestWithHTTPHeader:@"Basic MTM4MjE1NTk3NjM6MTExMTEx" Url:url parmater:nil isOpenHUD:YES SuccessBlock:^(NSData *data) {
            NSDictionary *getResultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            [self.delegate Request:getResultDic];
        } FailureBlock:^(NSError *error) {
            
        }];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请检查网络" delegate: self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        [alertView show];
    }
}

@end
