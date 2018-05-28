//
//  NaverLogin.m
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 15..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import "NaverLoginManager.h"
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>
@interface NaverLoginManager()<NaverThirdPartyLoginConnectionDelegate> {
    NaverThirdPartyLoginConnection *naverConnection;
}
@end
@implementation NaverLoginManager
-(instancetype)init {
    self = [super init];
    if (self) {
        naverConnection = [NaverThirdPartyLoginConnection getSharedInstance];
        UniversalSocialLogin *shared = [UniversalSocialLogin sharedInstance];
        if(shared.secureKeys != nil) {
            NSString *appScheme = [shared.secureKeys objectForKey: NAVER_SERVICEAPPSCHEME];
            if(appScheme != nil && ![appScheme isEqualToString:@""]) {
                [naverConnection setServiceUrlScheme:appScheme];
            }
            NSString *consumerKey = [shared.secureKeys objectForKey:NAVER_CONSUMERKEY];
            if(consumerKey != nil && ![consumerKey isEqualToString:@""]) {
                [naverConnection setConsumerKey:consumerKey];
            }
            NSString *consumerSecret = [shared.secureKeys objectForKey:NAVER_CONSUMERSECRET];
            if(consumerSecret != nil && ![consumerSecret isEqualToString:@""]) {
                [naverConnection setConsumerSecret:consumerSecret];
            }
            NSString *serviceAppName = [shared.secureKeys objectForKey:NAVER_SERVICEAPPNAME];
            if(serviceAppName != nil && ![serviceAppName isEqualToString:@""]) {
                [naverConnection setAppName:serviceAppName];
            }
        }
        [naverConnection setDelegate:self];
    }
    return self;
    
}
-(void)requestUserProfile {
    if([naverConnection isValidAccessTokenExpireTimeNow] == NO) {
        
    }
    NSString *urlString = @"https://openapi.naver.com/v1/nid/me";
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", naverConnection.accessToken];
    
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSString *decodingString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    if(error) {
        if([self.delegate respondsToSelector:@selector(getUserInfoFail:with:)]) {
            [self.delegate getUserInfoFail:Naver with:error];
            state = GetUserInfoFailure;
        }
    } else {
        if([self.delegate respondsToSelector:@selector(getUserInfoSuccess:with:)]) {
            [self.delegate getUserInfoSuccess:Naver with:decodingString];
            state = GetUserInfoSuccess;
        }
    }
}

-(void)userInfo {
    
}

-(void)requestLogin {
    if(naverConnection.isValidAccessTokenExpireTimeNow == NO) {
        if(naverConnection.accessToken) {
            [naverConnection requestAccessTokenWithRefreshToken];
        } else {
            [naverConnection requestThirdPartyLogin];
        }
    }
}

-(void) requestLogout {
    [naverConnection resetToken];
    state = Logout;
}
- (void)requestDeleteUser {
    [naverConnection requestDeleteToken];
    state = Delete;
}
- (void)autoRefreshToken {
    [naverConnection requestAccessTokenWithRefreshToken];
}
/**
 * NaverThirdPartyLoginConnectionDelegate 구현부
 */
- (void)oauth20ConnectionDidOpenInAppBrowserForOAuth:(NSURLRequest *)request {
    
}
- (void)oauth20ConnectionDidFinishRequestACTokenWithAuthCode {
    if([self.delegate respondsToSelector:@selector(loginSuccess:with:)]) {
        [self.delegate loginSuccess:Naver with:@"네이버 로그인 성공"];
        state = LoginSuccess;
    }
}
- (void)oauth20ConnectionDidFinishRequestACTokenWithRefreshToken {
    if([self.delegate respondsToSelector:@selector(loginSuccess:with:)]) {
        [self.delegate loginSuccess:Naver with:@"네이버 로그인 성공"];
        state = LoginSuccess;
    }
}
- (void)oauth20ConnectionDidFinishDeleteToken {
    
}
- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailWithError:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(loginFail:with:)]) {
        [self.delegate loginFail:Naver with:error];
        state = LoginFailure;
    }
}

- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailAuthorizationWithRecieveType:(THIRDPARTYLOGIN_RECEIVE_TYPE)recieveType {
    
}
- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFinishAuthorizationWithResult:(THIRDPARTYLOGIN_RECEIVE_TYPE)recieveType {
    
}
@end
