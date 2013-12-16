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
    
    
    
//    NSMutableArray *tableData = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"index" ascending:YES]];
    
//    EditDay *edit = [tableData objectAtIndex:0];
    
//    edit.badge = [NSNumber numberWithBool:TRUE];
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    // 특정 위치 뱃지 TRUE 로 바꾸기

    NSMutableArray *tableData = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"badge" ascending:YES]];
    
    EditDay *editDay = [tableData objectAtIndex:0];
    
    NSInteger result = [Date_Calendar startDate:editDay.date
                                     addOneDays:(BOOL)editDay.startdate];
    
    if (result < 0) {
        result = result * -1;
    }
    
    application.applicationIconBadgeNumber = result;
    // 뱃지 표시하기

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSMutableArray *tableData = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"badge" ascending:YES]];
    
    EditDay *editDay = [tableData objectAtIndex:0];
    
    NSInteger result = [Date_Calendar startDate:editDay.date
                                     addOneDays:(BOOL)editDay.startdate];
    
    if (result < 0) {
        result = result * -1;
    }
    
    application.applicationIconBadgeNumber = result;
    // 뱃지 표시하기
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
