//
//  KakaoLogin.m
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 16..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import "KakaoLoginManager.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>
@interface KakaoLoginManager() {
    KOSession *kakaoConnection;
}
@end
@implementation KakaoLoginManager
-(instancetype)init {
    self = [super init];
    if (self) {
        kakaoConnection = [KOSession sharedSession];
        UniversalSocialLogin *shared = [UniversalSocialLogin sharedInstance];
        if(shared.secureKeys != nil) {
            NSString *securityKey = [shared.secureKeys objectForKey: KAKAO_SECURITY];
            if(securityKey != nil && ![securityKey isEqualToString:@""]) {
                [kakaoConnection setClientSecret: securityKey];
            }
        }
    }
    return self;
}
- (void)autoRefreshToken {
    [KOSession sharedSession].automaticPeriodicRefresh = YES;
}
-(void)requestDeleteUser {
    [self requestLogout];
    state = Delete;
}
-(void)requestLogout {
    [KOSessionTask unlinkTaskWithCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"카카오 연결 해제 성공");
        } else {
            NSLog(@"카카오 연결 해제 실패");
        }
    }];
    state = Logout;
}
-(void)requestUserProfile {
    [KOSessionTask userMeTaskWithCompletion:^(NSError *error, KOUserMe *me) {
        if(error) {
            if([self.delegate respondsToSelector:@selector(getUserInfoFail:with:)]) {
                [self.delegate getUserInfoFail:Kakao with:error];
                self->state = GetUserInfoFailure;
            }
        } else {
            if([self.delegate respondsToSelector:@selector(getUserInfoSuccess:with:)]) {
                [self.delegate getUserInfoSuccess:Kakao with:me];
                self->state = GetUserInfoSuccess;
            }
        }
    }];
}
-(void)requestLogin {
    if(kakaoConnection.isOpen == YES) {
        if([self.delegate respondsToSelector:@selector(loginSuccess:with:)]) {
            [self.delegate loginSuccess:Kakao with:@"카카오 로그인 성공"];
            state = LoginSuccess;
        }
    } else {
        [kakaoConnection openWithCompletionHandler:^(NSError *error) {
            if (!self->kakaoConnection.isOpen) {
                switch (error.code) {
                    case KOErrorCancelled:
                        break;
                    default:
                        if([self.delegate respondsToSelector:@selector(loginFail:with:)]) {
                            [self.delegate loginFail:Kakao with:error];
                            self->state = LoginFailure;
                        }
                        break;
                }
            } else {
                if([self.delegate respondsToSelector:@selector(loginSuccess:with:)]) {
                    [self.delegate loginSuccess:Kakao with:@"카카오 로그인 성공"];
                    self->state = LoginSuccess;
                }
            }
        }];
    }
}
@end
