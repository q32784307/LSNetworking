//
//  NSString+Validation.h
//  WanhuHealth
//
//  Created by 李帅 on 15/6/23.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Validation)

// 验证手机号
- (BOOL)validateMobile:(NSString* )mobileNumber;

// 验证身份证号
- (BOOL)validateIdentityCard:(NSString *)identityCard;

// 根据身份证判断性别
- (NSString *)sexStringIdentifyCard:(NSString *)cardNumber;

// 根据身份证获取生日
- (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;

//验证身份证是否有效
- (BOOL)checkIdentityCardNo:(NSString*)cardNo;


@end

