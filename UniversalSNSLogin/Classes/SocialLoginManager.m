//
//  SocialLoginManager.m
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 16..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import "SocialLoginManager.h"
#import "NaverLoginManager.h"
#import "KakaoLoginManager.h"
#import "GoogleLoginManager.h"
#import "FacebookLoginManager.h"
@implementation SocialLoginManager
@synthesize delegate;
-(instancetype)initWithSocial:(SocialType)socialType {
    if(self) {
        self = [self initalizer:socialType];
    }
    return self;
}

-(instancetype) initalizer:(SocialType)type {
    switch (type) {
        case Naver:
            return [[NaverLoginManager alloc] init];
        case Kakao:
            return [[KakaoLoginManager alloc] init];
        case Google:
            return [[GoogleLoginManager alloc] init];
        case Facebook:
            return [[FacebookLoginManager alloc] init];
        default:
            return nil;
    }
}
-(void)didEnterBackground {
    
}
-(void)autoRefreshToken {
    
}
- (void)requestDeleteUser {
    
}
- (void)requestLogout {
    
}
- (void)requestUserProfile{
    
}
- (void)requestLogin {
    
}

- (SocialLoginState)state {
    return state;
}
@end
