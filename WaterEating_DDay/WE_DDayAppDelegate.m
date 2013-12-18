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
    
    [self presentNotification];
    // 노티

    return YES;
}

- (void)presentNotification
{
    NSLog(@"로컬노티 확인");
    for (int i = 1; i <= 365; i++) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:i];
        localNotification.applicationIconBadgeNumber = [Entity_init badge]+i;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

// application delegate method
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if(application.applicationState == UIApplicationStateActive){
        
        // Foreground에서 알림 수신
        NSLog(@"노티 짜잔");
    }
    
    if(application.applicationState == UIApplicationStateInactive){
        
        // Background에서 알림 액션에 의한 수신
        // notification.userInfo 이용하여 처리
        NSLog(@"백그라운드 노티 짜잔");
    }
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
