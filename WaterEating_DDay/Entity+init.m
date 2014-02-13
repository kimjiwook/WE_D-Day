//
//  Entity+init.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 17..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "Entity+init.h"
#import "EditDay.h"

@implementation Entity_init

// Entities 의 뱃지를 전부 취소해준다.
+ (void) badgeinit
{
    NSMutableArray *array = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"index" ascending:YES]];
    
    for (EditDay *edit in array) {
        edit.badge = [NSNumber numberWithBool:FALSE];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];// 저장
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // 등록된 노티를 전부 삭제한다.
}

// Badge 여부를 판단 한가지를 꺼내와 리턴 없는경우는 Nil
+ (EditDay *) mainBadge
{
    NSMutableArray *array = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"badge" ascending:YES]];
    
    for (EditDay *edit in array) {
        if ([edit.badge boolValue]) {
            return edit;
        }
    }
    return nil;
}

// Badge에 달릴 값을 만든다.
/*! text..
 \param param1 text..
 \param param2 text..
 \retusns result
 */
+ (NSInteger) badge
{
    EditDay *editDay = [Entity_init mainBadge];
    if (editDay != nil) {
        NSInteger result = [Date_Calendar stringDate:editDay.date plusOne:[editDay.plusone boolValue]];
        
        if (result < 0) {
            result = result * -1;
        }
        
        [Entity_init badgeReseve];
        
        return result;
        
    } else {
        return 0;
    }
}
/*! text..
 \param param1 text..
 \param param2 text..
 \retusns result
 */

// Badge를 예약한다. (매일매일 정시에 예약한다.)
/*! 이것은 나의 메소드
 \param 그딴거없음 2013년 마지막인데 코드짜고있는 기분 알아?!
 \returns 몰라 ㅋㅋㅋ
 */
+ (void) badgeReseve
{
    
    NSInteger __block result = 0;
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // 등록된 노티를 전부 삭제한다.
    
    EditDay *editDay = [Entity_init mainBadge]; // 뱃지인 EditDay 가져오기
    
    if (editDay != nil) {
        WE_DDayAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        [appDelegate.operationQueue setSuspended:YES];
        [appDelegate.operationQueue cancelAllOperations];   // 큐를 비우고
        [appDelegate.operationQueue setSuspended:NO];       // 큐를 시작한다.
        
        for (int i = 1; i <= 365; i++) {
            [appDelegate.operationQueue addOperationWithBlock:^{
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                
                // Today (yyyy-MM-dd)
                NSDate *dateNow = [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
        
                // 하루를 더해서 내일 날짜 구하기 + i 하루씩 계속~~
                NSDateComponents *components = [[NSDateComponents alloc] init];
                
                [components setDay:i];
                
                NSCalendar *calendar1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDate *daysDate = [calendar1 dateByAddingComponents:components toDate:dateNow options:0];
                
//                NSLog(@"days 오늘 다음 날짜 : %@", daysDate);
                
                // Select Date (yyyy-MM-dd)
                NSDate *stringToDate = [[NSDate alloc] init];
                stringToDate = [dateFormat dateFromString:editDay.date];
                
                // 64bit int 호환
                
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                
                result = [[calendar components:NSDayCalendarUnit fromDate:stringToDate toDate:daysDate options:0] day];
                
                if (editDay.plusone) { result += 1; }
                
                UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                localNotification.fireDate = daysDate;
                localNotification.applicationIconBadgeNumber = result;
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//                NSLog(@"푸시 알림 예약 값 등록완료 : %ld",(long)result);
            }];
        }
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:result];
    }
}

@end