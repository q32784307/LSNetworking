//
//  UserModel.h
//  Encapsulation
//
//  Created by 丶离人梦 on 2017/1/17.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class UserModel;

@protocol UserModelDelegate <NSObject>

@required

- (void)Request:(NSDictionary *)req;

@end

@interface UserModel : NSObject

- (void)getRequest;

@property(nonatomic,weak)id<UserModelDelegate>delegate;

@end
