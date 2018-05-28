//
//  FacebookLoginManager.m
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 17..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import "FacebookLoginManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface FacebookLoginManager() {
    FBSDKLoginManager *facebookConnection;
    //    FBSDKAccessToken *facebookConnection;
}
@end
@implementation FacebookLoginManager
-(instancetype)init {
    self = [super init];
    if (self) {
        facebookConnection = [[FBSDKLoginManager alloc] init];
    }
    return self;
}
-(void)autoRefreshToken {
    if([FBSDKAccessToken currentAccessToken] != nil) {
        [FBSDKAccessToken refreshCurrentAccessToken:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if(error) {
                NSLog(@"%@",error);
            } else {
                NSLog(@"%@",result);
            }
        }];
    }
}
-(void)requestLogout {
    [FBSDKAccessToken setCurrentAccessToken:nil];
}
-(void)requestDeleteUser {
    if([FBSDKAccessToken currentAccessToken] != nil) {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me/permissions" parameters:nil HTTPMethod:@"DELETE"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if(error) {
                NSLog(@"%@",error);
            } else {
                NSNumber *success = [result objectForKey:@"success"];
                if(success != nil && [success boolValue] == YES) {
                    [FBSDKAccessToken setCurrentAccessToken:nil];
                    NSLog(@"Facebook 유저 삭제 성공");
                }
            }
        }];
    }
}
-(void)requestUserProfile {
    if([FBSDKAccessToken currentAccessToken] != nil) {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,email,picture"}];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if(error == nil) {
                if([self.delegate respondsToSelector:@selector(getUserInfoSuccess:with:)]) {
                    [self.delegate getUserInfoSuccess:Facebook with:result];
                }
            } else {
                if([self.delegate respondsToSelector:@selector(getUserInfoFail:with:)]) {
                    [self.delegate getUserInfoFail:Facebook with:error];
                }
            }
        }];
    }
}

-(void)requestLogin {
    if(![FBSDKAccessToken currentAccessToken] || ![FBSDKAccessToken currentAccessTokenIsActive]) {
        [facebookConnection logInWithReadPermissions:@[@"public_profile",@"email"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if(error == nil) {
                if([self.delegate respondsToSelector:@selector(loginSuccess:with:)]) {
                    [self.delegate loginSuccess:Facebook with:result];
                }
            } else {
                if([self.delegate respondsToSelector:@selector(loginFail:with:)]) {
                    [self.delegate loginFail:Facebook with:error];
                }
            }
        }];
    }
}
@end
