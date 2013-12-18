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
        if ((Boolean)edit.badge) {
            return edit;
        }
    }
    return nil;
}

// Badge에 달릴 값을 만든다.
+ (NSInteger) badge
{
    EditDay *editDay = [Entity_init mainBadge];
    if (editDay != nil) {
        NSInteger result = [Date_Calendar stringDate:editDay.date plusOne:(Boolean)editDay.plusone];
        
        if (result < 0) {
            result = result * -1;
        }
        
        [Entity_init badgeReseve];
        
        return result;
        
    } else {
        return 0;
    }
}

// Badge를 예약한다. (매일매일 정시에 예약한다.)
+ (void) badgeReseve
{
    //GCD & Block 코딩 으로 메인큐에 쓰레드를 보내서 처리한다.
    dispatch_queue_t badge = dispatch_queue_create("badge", NULL);
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    
    NSInteger __block result = 0;
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // 등록된 노티를 전부 삭제한다.
    
    EditDay *editDay = [Entity_init mainBadge]; // 뱃지인 EditDay 가져오기
    
    if (editDay != nil) {
        for (int i = 1; i <= 30; i++) {
//            dispatch_async(badge, ^{
//                dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
            
                
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                
                // Today (yyyy-MM-dd)
                NSDate *dateNow = [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
                
                // 하루를 더해서 내일 날짜 구하기 + i 하루씩 계속~~
                NSDateComponents *components = [[NSDateComponents alloc] init];
                
                [components setDay:i];
                
                NSCalendar *calendar1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDate *daysDate = [calendar1 dateByAddingComponents:components toDate:dateNow options:0];
                
                NSLog(@"days 오늘 다음 날짜 : %@", daysDate);
                
                // Select Date (yyyy-MM-dd)
                NSDate *stringToDate = [[NSDate alloc] init];
                stringToDate = [dateFormat dateFromString:editDay.date];
                
                // 64bit int 호환
                
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                
                result = [[calendar components:NSDayCalendarUnit fromDate:stringToDate toDate:daysDate options:0] day];
                
                if (editDay.plusone) { result += 1; }
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                    localNotification.fireDate = daysDate;
                    localNotification.applicationIconBadgeNumber = result;
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                    
                    NSLog(@"푸시 알림 예약 값 등록완료 : %ld",(long)result);
                    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:result];
                    
//                    dispatch_semaphore_signal(signal);
//                });
//            });
//            // 여기까지 GCD & Block 코딩
        }
    }
    
}

@end
