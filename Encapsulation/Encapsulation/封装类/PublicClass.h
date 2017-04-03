//
//  PublicClass.h
//  Encapsulation
//
//  Created by 李帅 on 16/3/24.
//  Copyright © 2016年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PublicClass : NSObject


/***************************************** 此封装类基于 AFNetworking 版本3.0+（老版本2.6.3）*****************************************/

#pragma mark - Get 网络请求(自定义请求头，安全起见)
/**
 * @brief                                         网络请求 Get
 * @param header                                  传入的header请求头
 * @param url                                     传入的url(NSString)
 * @param dic
 * @param successblock                            请求获取数据成功
 * @param failureBlock                            请求获取数据失败
 */
+ (void)getRequestWithHTTPHeader:(NSString *)header  Url:(NSString *)url parmater:(NSDictionary *)dic isOpenHUD:(BOOL)isOpenHUD SuccessBlock:(void (^)(NSData *data))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

#pragma mark - Put 网络请求
/**
 *  @brief                                        网络请求 Put
 * @param header                                  传入的header请求头
 *  @param url                                    传入的url(NSString)
 *  @param dic                                    传入的参数(NSDictionary)
 *  @param successblock                           请求获取数据成功
 *  @param failureBlock                           请求获取数据失败
 */
+ (void)putRequestWithHTTPHeader:(NSString *)header Url:(NSString *)url parmater:(NSDictionary *)dic isOpenHUD:(BOOL)isOpenHUD SuccessBlock:(void (^)(NSData *data))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

#pragma mark - Post 网络请求
/**
 * @brief                                         网络请求 Post
 * @param header                                  传入的header请求头
 * @param url                                     传入的url(NSString)
 * @param dic                                     传入的参数(NSDictionary)
 * @param successblock                            请求获取数据成功
 * @param failureBlock                            请求获取数据失败
 */
+ (void)postRequestWithHTTPHeader:(NSString *)header Url:(NSString *)url parmater:(NSDictionary *)dic isOpenHUD:(BOOL)isOpenHUD SuccessBlock:(void (^)(NSData *data))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

#pragma mark - Post 单图片上传
/**
 * @brief                                         网络请求 Post (单图片上传)
 * @param header                                  传入的header请求头
 * @param url                                     传入的url(NSString)
 * @param dic                                     传入的参数(NSDictionary)
 * @param fileData                                传入图片的数据流(NSData)
 * @param fileName                                传入图片的名字(NSString  与后台一致)
 * @param successblock                            请求获取数据成功
 * @param failureBlock                            请求获取数据失败
 */
+ (void)postRequestWithHTTPHeader:(NSString *)header ImageUploadRequestWithUrl:(NSString *)url parmater:(NSDictionary *)dic isOpenHUD:(BOOL)isOpenHUD fileData:(NSData *)fileData fileName:(NSString *)fileName SuccessBlock:(void (^)(NSData *data))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

#pragma mark - 网络检测
+ (BOOL)isNetWorkConnectionAvailable;

/************************************************* 此封装类基于 UILabel 自适应 *************************************************/

#pragma mark - UILabel 自适应高度
/**
 * @brief                                         UILabel 自适应高度
 * @param width                                   控件的宽度
 * @param title                                   控件上显示的内容
 * @param font                                    控件上显示的内容的字体大小
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

#pragma mark - UILabel 自适应宽度
/**
 * @brief                                         UILabel 自适应宽度
 * @param title                                   控件上显示的内容
 * @param font                                    控件上显示的内容的字体大小
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

/***************************************************************************************************************************/

#pragma mark - 点击图片放大
/**
 *	@brief	                                      浏览头像(放大)
 *	@param 	avatarImageView 	                  头像所在的imageView
 */
+ (void)showImage:(UIImageView *)avatarImageView;

@end
