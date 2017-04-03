//
//  PublicClass.m
//  Encapsulation
//
//  Created by 李帅 on 16/3/24.
//  Copyright © 2016年 漠然丶情到深处. All rights reserved.
//

#import "PublicClass.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "MD5.h"

static CGRect oldframe;

@implementation PublicClass


/***************************************** 此封装类基于 AFNetworking 版本3.0+（老版本2.6.3）*****************************************/


/**
 * @brief                                         网络请求 Get
 * @param url                                     传入的url(NSString)
 * @param dic
 * @param successblock                            请求获取数据成功
 * @param failureBlock                            请求数据获取失败
 */
+ (void)getRequestWithHTTPHeader:(NSString *)header Url:(NSString *)url parmater:(NSDictionary *)dic isOpenHUD:(BOOL)isOpenHUD SuccessBlock:(void (^)(NSData *data))successblock FailureBlock:(void (^)(NSError *error))failureBlock
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = 10.f;
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [session.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
    NSString *userAgent = [NSString stringWithFormat:@"iOS/PBM-Assistant/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    [session.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [session.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    if (isOpenHUD == YES)
    {
        [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    [session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successblock(responseObject);
        if (isOpenHUD == YES)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        if (isOpenHUD == YES)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
        }
        NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
        NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:codeStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [AlertView show];
    }];
}

/**
 *  @brief                                        网络请求 Put
 *  @param url                                    传入的url(NSString)
 *  @param dic                                    传入的参数(NSDictionary)
 *  @param successblock                           请求获取数据成功
 *  @param failureBlock                           请求获取数据失败
 */
+ (void)putRequestWithHTTPHeader:(NSString *)header Url:(NSString *)url parmater:(NSDictionary *)dic isOpenHUD:(BOOL)isOpenHUD SuccessBlock:(void (^)(NSData *data))successblock FailureBlock:(void (^)(NSError *error))failureBlock
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = 10.f;
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [session.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
    NSString *userAgent = [NSString stringWithFormat:@"iOS/PBM-Assistant/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    [session.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [session.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/css",@"text/html", nil]];if (isOpenHUD == YES)
    {
        [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    [session PUT:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successblock(responseObject);
        if (isOpenHUD == YES)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        if (isOpenHUD == YES)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
        }
        NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
        NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:codeStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [AlertView show];
    }];
}

/**
 * @brief                                         网络请求 Post
 * @param url                                     传入的url(NSString)
 * @param dic                                     传入的参数(NSDictionary)
 * @param successblock                            请求获取数据成功
 * @param failureBlock                            请求数据获取失败
 */
+ (void)postRequestWithHTTPHeader:(NSString *)header Url:(NSString *)url parmater:(NSDictionary *)dic isOpenHUD:(BOOL)isOpenHUD SuccessBlock:(void (^)(NSData *data))successblock FailureBlock:(void (^)(NSError *error))failureBlock
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = 10.f;
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [session.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
    NSString *userAgent = [NSString stringWithFormat:@"iOS/PBM-Assistant/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    [session.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [session.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/css",@"text/html", nil]];
    if (isOpenHUD == YES)
    {
        [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    [session POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successblock(responseObject);
        if (isOpenHUD == YES)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        if (isOpenHUD == YES)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
        }
        NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
        NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:codeStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [AlertView show];
    }];
}

/**
 * @brief                                         网络请求 Post (单图片上传)
 * @param url                                     传入的url(NSString)
 * @param dic                                     传入的参数(NSDictionary)
 * @param fileData                                传入图片的数据流(NSData)
 * @param fileName                                传入图片的名字(NSString  与后台一致)
 * @param successblock                            请求获取数据成功
 * @param failureBlock                            请求数据获取失败
 */
+ (void)postRequestWithHTTPHeader:(NSString *)header ImageUploadRequestWithUrl:(NSString *)url parmater:(NSDictionary *)dic isOpenHUD:(BOOL)isOpenHUD fileData:(NSData *)fileData fileName:(NSString *)fileName SuccessBlock:(void (^)(NSData *data))successblock FailureBlock:(void (^)(NSError *error))failureBlock
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = 10.f;
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [session.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
    NSString *userAgent = [NSString stringWithFormat:@"iOS/PBM-Assistant/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    [session.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [session.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/css",@"text/html", nil]];
    if (isOpenHUD == YES)
    {
        [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    [session POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:fileName fileName:@"pickure.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successblock(responseObject);
        if (isOpenHUD == YES)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        if (isOpenHUD == YES)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
        }
        NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
        NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:codeStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [AlertView show];
    }];
}

#pragma mark - 网络检测
+ (BOOL)isNetWorkConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            NSLog(@"无网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            NSLog(@"3G");
            break;
    }
    return isExistenceNetwork;
}

/************************************************* 此封装类基于 UILabel 自适应 *************************************************/

/**
 * @brief                                         UILabel 自适应高度
 * @param width                                   控件的宽度
 * @param title                                   控件上显示的内容
 * @param font                                    控件上显示的内容的字体大小
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

/**
 * @brief                                         UILabel 自适应宽度
 * @param title                                   控件上显示的内容
 * @param font                                    控件上显示的内容的字体大小
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

/***************************************************************************************************************************/

/**
 *	@brief	                                      浏览头像(放大)
 *	@param 	avatarImageView 	                  头像所在的imageView
 */
+ (void)showImage:(UIImageView *)avatarImageView {
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) / 2, [UIScreen mainScreen].bounds.size.width, image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width);
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)hideImage:(UITapGestureRecognizer *)tap {
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

/***************************************************************************************************************************/



@end
