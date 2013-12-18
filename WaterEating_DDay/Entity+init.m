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
        return result;
        
    } else {
        return 0;
    }
}

// Badge를 예약한다. (매일매일 정시에 예약한다.)
+ (void) badgeReseve
{
    EditDay *editDay = [self mainBadge]; // 뱃지인 EditDay 가져오기
    
    if (editDay != nil) {
        for (int i = 1; i <= 365; i++) {
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            
            // Today (yyyy-MM-dd)
            NSDate *dateNow = [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
            
            // 계산을 진행할때 D+ 일일 경우에는 -1 을
            // D - 일 경우에는 0을 빼준다.
            // 날짜 변환에서 발생하는 오류
            NSDateComponents *components = [[NSDateComponents alloc] init];
            
//            if (day < 0) {
//                // D- 계산법
//                [components setDay:day-0];
//            }else{
//                // D+ 계산법
//                [components setDay:day-1];
//            }
            [components setDay:i];
            
            NSCalendar *calendar1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDate *daysDate = [calendar1 dateByAddingComponents:components toDate:dateNow options:0];
            
            NSLog(@"days 오늘 다음 날짜 : %@", daysDate);
            
            
            // Select Date (yyyy-MM-dd)
            NSDate *stringToDate = [[NSDate alloc] init];
            stringToDate = [dateFormat dateFromString:editDay.date];
            
            // 64bit int 호환
            NSInteger result = 0;
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            
            result = [[calendar components:NSDayCalendarUnit fromDate:stringToDate toDate:dateNow options:0] day];
            
            if (editDay.plusone) { result += 1; }
            
            
        }
    }
}

@end
