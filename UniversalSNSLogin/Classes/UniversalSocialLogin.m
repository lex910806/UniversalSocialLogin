//
//  UniversalSocialLogin.m
//  UniversalSocialLogin
//
//  Created by JiHoon on 2018. 5. 15..
//  Copyright © 2018년 JiHoon. All rights reserved.
//

#import "UniversalSocialLogin.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Firebase/Firebase.h>
#define SAVED_SOCIAL_TYPE @"SAVED_SOCIAL_TYPE"
@implementation UniversalSocialLogin
@synthesize loginManager;

+(UniversalSocialLogin *)sharedInstance {
    static UniversalSocialLogin * shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[UniversalSocialLogin alloc] init];
    });
    return shared;
}

+(SocialLoginManager *)makeManagerWith:(SocialType) type {
    SocialLoginManager *manager = [[UniversalSocialLogin sharedInstance] loginManager];
    if(manager) {
        [[UniversalSocialLogin sharedInstance] setLoginManager:nil];
    }
    [[UniversalSocialLogin sharedInstance] setSocial:type];
    
    if (type != NotDefine) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject: [NSNumber numberWithInteger:type] forKey: SAVED_SOCIAL_TYPE];
    }
    
    manager = [[SocialLoginManager alloc] initWithSocial:type];
    [[UniversalSocialLogin sharedInstance] setLoginManager:manager];
    return manager;
}

+(void)setSecureKeyWith:(NSDictionary *)dic {
    UniversalSocialLogin *shared = [UniversalSocialLogin sharedInstance];
    shared.secureKeys = [dic copy];
}
-(void) configure:(UIApplication *)application with:(NSDictionary *)launchOptions {
    
    [FIRApp configure];
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *type = [prefs objectForKey:SAVED_SOCIAL_TYPE];
    
    SocialLoginManager *manager;
    if(type != nil) {
        manager = [UniversalSocialLogin makeManagerWith:[type integerValue]];
        if(manager != nil) {
            [manager autoRefreshToken];
            [[UniversalSocialLogin sharedInstance] setLoginManager:manager];
        }
    }
}
-(void)didEnterBackground {
    if (social != NotDefine) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject: [NSNumber numberWithInteger:social] forKey: SAVED_SOCIAL_TYPE];
    }
}
-(void) setSocial:(SocialType)type{
    social = type;
}
- (SocialType)socialType {
    return social;
}

@end
