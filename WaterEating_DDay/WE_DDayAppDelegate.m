//
//  WE_DDayAppDelegate.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 21..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "WE_DDayAppDelegate.h"
#import "EditDay.h"

@implementation WE_DDayAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupAutoMigratingCoreDataStack];
    // 시작에 앞서 MagicalRecord setup 시켜준다.
    
    application.applicationIconBadgeNumber = 0;
    // 뱃지 표시하기
    
    application.applicationIconBadgeNumber = [Entity_init badge];
    // 표시할 뱃지

    return YES;
}

// 백그라운드로 내려갈때
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

// 앱 종료시
- (void)applicationWillTerminate:(UIApplication *)application
{
   
}

@end
