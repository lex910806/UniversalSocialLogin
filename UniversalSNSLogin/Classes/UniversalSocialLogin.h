//
//  UniversalSocialLogin.h
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 15..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialLoginManager.h"

@interface UniversalSocialLogin : NSObject
{
    SocialLoginManager __strong *loginManager;
    SocialType social;
}
@property (nonatomic,strong) SocialLoginManager *loginManager;
+(UniversalSocialLogin *)sharedInstance;
+(SocialLoginManager *)makeManagerWith:(SocialType) type;
-(void) configure:(UIApplication *)application with:(NSDictionary *)launchOptions;
-(void) didEnterBackground;
-(SocialType) socialType;
@end

