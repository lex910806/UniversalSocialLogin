//
//  UniversalSocialLogin.h
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 15..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialLoginManager.h"

#define NAVER_SERVICEAPPSCHEME  @"naverServiceScheme"
#define NAVER_CONSUMERKEY       @"naverConsumerkey"
#define NAVER_CONSUMERSECRET    @"naverConsumerSecret"
#define NAVER_SERVICEAPPNAME    @"naverServiceAppName"

#define KAKAO_SECURITY          @"kakaoSecurity"

@interface UniversalSocialLogin : NSObject
{
    SocialLoginManager __strong *loginManager;
    SocialType social;
}
@property (nonatomic, strong) NSDictionary *secureKeys;
@property (nonatomic, strong) SocialLoginManager *loginManager;
+(UniversalSocialLogin *)sharedInstance;
+(SocialLoginManager *)makeManagerWith:(SocialType) type;
-(void) configure:(UIApplication *)application with:(NSDictionary *)launchOptions;
-(void) didEnterBackground;
-(SocialType) socialType;
@end

