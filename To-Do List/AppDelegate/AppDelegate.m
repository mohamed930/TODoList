//
//  AppDelegate.m
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    IQKeyboardManager.sharedManager.enable = YES;
    
    return YES;
}


@end
