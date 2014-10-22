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
@synthesize operationQueue;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupAutoMigratingCoreDataStack];
    // 시작에 앞서 MagicalRecord setup 시켜준다.
    
    operationQueue = [[NSOperationQueue alloc]init];
    [operationQueue setMaxConcurrentOperationCount:1]; // 큐에서 도는 쓰레드는 1개
    [operationQueue setSuspended:YES];      // 큐를 멈추고
    [operationQueue cancelAllOperations];   // 큐를 비우고
    [operationQueue setSuspended:NO];       // 큐를 시작한다.
    // Queue의 생성과 하나씩 실행되게 설정
    // 설정후 큐의 작업을 모두 취소 시킨다.
    
    
//    application.applicationIconBadgeNumber = 5;
//    application.applicationIconBadgeNumber = [Entity_init badge];
    // 표시할 뱃지
    [application setApplicationIconBadgeNumber:[Entity_init badge]];

    return YES;
}

// 연습용 노티
- (void)presentNotification
{
    NSLog(@"로컬노티 확인");
    for (int i = 1; i <= 365; i++) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:i];
        localNotification.applicationIconBadgeNumber = i;
        localNotification.userInfo = [NSDictionary dictionaryWithObject:@"Test" forKey:@"key"];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

// application delegate method
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if(application.applicationState == UIApplicationStateActive){
        
        // Foreground에서 알림 수신
        NSLog(@"노티 짜잔 ");
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
    NSLog(@"앱이 쉴때");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    NSLog(@"앱이 포그라운드에서 백그라운드 되었을떄");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"앱이 백그라운드에서 포그라운드로 바뀔때");
    // 내려갔다가 올라왔을때 앱을 다시 실행 시키려는 이유
    // 1. 하루가 지났을땐 무조건 다시
//    [self applicationDidFinishLaunching:[UIApplication sharedApplication]];
}

// 앱이 활성화 될때 실행
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"앱이 활성화 될때");
}

// 앱 종료시
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"앱이 죽었을때");
}

@end
