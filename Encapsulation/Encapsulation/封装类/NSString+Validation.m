//
//  NSString+Validation.m
//  WanhuHealth
//
//  Created by 李帅 on 15/6/23.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

#pragma mark - 验证手机号
- (BOOL)validateMobile:(NSString* )mobileNumber {
    if ([mobileNumber length] == 0) {
        return NO;
    }
    NSString *regex = @"^((145|147)|(15[^4])|(17[6-8])|((13|18)[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileNumber];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

#pragma mark - 验证身份证格式
- (BOOL)validateIdentityCard:(NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

#pragma mark - 根据身份证判断性别
- (NSString *)sexStringIdentifyCard:(NSString *)cardNumber {
    NSString *result = nil;
    BOOL isAllNumber = YES;
    if ([cardNumber length] < 17) {
        return result;
    }
    //截取第17位为性别识别符
    NSString *fontNumber = [cardNumber substringWithRange:NSMakeRange(16, 1)];
    //检测是否是数字
    if ([fontNumber integerValue] %2 == 1) {
        result = @"男";
    }else if ([fontNumber integerValue] %2 == 0){
        result = @"女";
    }
    return result;
}

#pragma mark - 根据身份证获取生日
- (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr {
    
    return nil;
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p != '\0') {
        if(!(*p >= '0' && *p <= '9')){
            isAllNumber = NO;
            p++;
        }
        if(!isAllNumber){
            return result;
            
            year = [numberStr substringWithRange:NSMakeRange(6, 4)];
            month = [numberStr substringWithRange:NSMakeRange(10, 2)];
            day = [numberStr substringWithRange:NSMakeRange(12,2)];
            
            [result appendString:year];
            [result appendString:month];
            [result appendString:day];
            return result;
        }
    }
}

#pragma mark - 身份证识别
- (BOOL)checkIdentityCardNo:(NSString*)cardNo {
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray *codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary *checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner *scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i = 0; i < 17; i++) {
        sumValue += [[cardNo substringWithRange:NSMakeRange(i , 1)] intValue] * [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString *strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString:[[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}


@end

