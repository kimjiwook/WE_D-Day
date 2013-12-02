//
//  Date+Calendar.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 29..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "Date+Calendar.h"

@implementation Date_Calendar

// DDay 만들기
+ (NSInteger) startDate :(NSDate *)startDate addOneDays :(Boolean)oneDays
{
    // Today
    NSDate *dateNow = [self date_yyyy_mm_dd:[NSDate date]];
    // Select Day
    NSDate *dateSelected = [self date_yyyy_mm_dd:startDate];
    // 64bit int 호환
    NSInteger result = 0;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    result = [[calendar components:NSDayCalendarUnit fromDate:dateSelected toDate:dateNow options:0] day];
    if (oneDays) { result += 1; }
    
    return result;
}

// 시분초를 없애는 작업
+ (NSDate *) date_yyyy_mm_dd :(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&date interval:Nil forDate:date];
    
    return date;
}

// D+234, D-23 형식의 String 반환 작업
+ (NSString *) stringResult : (NSInteger) result
{
    if (result >= 0) {
        // D+ 일 경우
        return [NSString stringWithFormat:@"D+%ld 일",(long)result];
    }else{
        // D- 일 경우
        return [NSString stringWithFormat:@"D%ld 일",(long)result];
    }
}

@end
