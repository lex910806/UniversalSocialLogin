//
//  GoogleLoginManager.m
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 16..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import "GoogleLoginManager.h"

@interface GoogleLoginManager() <GIDSignInDelegate,GIDSignInUIDelegate>{
    GIDSignIn *googleConnection;
    GIDGoogleUser *userInfo;
    NSError *error;
}
@end
@implementation GoogleLoginManager
-(instancetype)init {
    self = [super init];
    if (self) {
        googleConnection = [GIDSignIn sharedInstance];
        googleConnection.clientID = [FIRApp defaultApp].options.clientID;
        googleConnection.delegate = self;
        googleConnection.uiDelegate = self;
    }
    return self;
    
}

-(void)requestUserProfile {
    if(userInfo) {
        if([self.delegate respondsToSelector:@selector(getUserInfoSuccess:with:)]) {
            [self.delegate getUserInfoSuccess:Google with:userInfo];
        }
    } else {
        if([self.delegate respondsToSelector:@selector(getUserInfoFail:with:)]) {
            [self.delegate getUserInfoFail:Google with:error];
        }
    }
}
-(void)requestLogin {
    [googleConnection signIn];
}
-(void)autoRefreshToken {
    if([googleConnection hasAuthInKeychain]) {
        [googleConnection signInSilently];
    }
}
-(void)requestLogout {
    [googleConnection signOut];
}
-(void)requestDeleteUser {
    [googleConnection disconnect];
}
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    userInfo = user;
    if([self.delegate respondsToSelector:@selector(loginSuccess:with:)]) {
        [self.delegate loginSuccess:Google with:@"구글 로그인 성공"];
    }
    //    self->error = error;
}
- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(loginFail:with:)]) {
        [self.delegate loginFail:Google with:error];
        NSLog(@"Google 로그인 실패");
    }
    //    self->error = error;
}
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    
}

@end
