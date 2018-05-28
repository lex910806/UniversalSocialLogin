//
//  SocialLoginManager.h
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 16..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, SocialType) {
    NotDefine,
    Kakao,
    Naver,
    Google,
    Facebook
};

typedef NS_ENUM(NSUInteger, SocialLoginState) {
    Pending,
    LoginSuccess,
    LoginFailure,
    GetUserInfoSuccess,
    GetUserInfoFailure,
    Logout,
    Delete
};
@protocol SocialLoginDelegate;
@interface SocialLoginManager : NSObject
{
    id<SocialLoginDelegate> __weak delegate;
    SocialLoginState state;
}
@property (nonatomic,weak) id<SocialLoginDelegate> delegate;
/**
 * 객체 생성, 로그인 요청, 유저정보 요청, 로그아웃 요청, 유저 권한 삭제
 */
- (instancetype)initWithSocial:(SocialType)socialType;
- (void) autoRefreshToken;
- (void) requestLogin;
- (void) requestUserProfile;
- (void) requestLogout;
- (void) requestDeleteUser;

- (SocialLoginState) state;
@end

@protocol SocialLoginDelegate <NSObject>
-(void)loginSuccess:(SocialType)type with:(id) data;
-(void)loginFail:(SocialType)type with:(NSError *)error;
-(void)getUserInfoSuccess:(SocialType)type with:(id) data;
-(void)getUserInfoFail:(SocialType)type with:(NSError *)error;
@end
