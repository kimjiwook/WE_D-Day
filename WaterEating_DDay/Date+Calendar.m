//
//  Date+Calendar.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 29..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "Date+Calendar.h"

@implementation Date_Calendar

// DDay Create
// ex) D+143, D-54..
+ (NSInteger) stringDate : (NSString *) date plusOne : (BOOL)plusOne
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    // Today (yyyy-MM-dd)
    NSDate *dateNow = [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
    
    // Select Date (yyyy-MM-dd)
    NSDate *stringToDate = [[NSDate alloc] init];
    stringToDate = [dateFormat dateFromString:date];
    
    // 64bit int 호환
    NSInteger result = 0;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    result = [[calendar components:NSDayCalendarUnit fromDate:stringToDate toDate:dateNow options:0] day];
    
    if (plusOne) { result += 1; }
    
    return result;
}



// +100일 (2013-09-07) Create...
+ (NSString *) stringDate:(NSString *)date howdays:(NSInteger)day
{
    // 계산을 진행할때 D+ 일일 경우에는 -1 을
    // D - 일 경우에는 0을 빼준다.
    // 날짜 변환에서 발생하는 오류
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if (day < 0) {
        // D- 계산법
        [components setDay:day-0];
    }else{
        // D+ 계산법
        [components setDay:day-1];
    }

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *daysDate = [calendar dateByAddingComponents:components toDate:[Date_Conversion stringToDate:date] options:0];

    return [Date_Conversion dateToString:daysDate];
}


// 시작일 - 끝나는일 계산방식
+ (NSInteger) startDate:(NSDate *)startDate endDate:(NSDate *)endDate plusOne:(BOOL)plusOne
{
    NSInteger result = 0;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    result = [[calendar components:NSDayCalendarUnit fromDate:startDate toDate:endDate options:0] day];
    
    return result;
}

// 특정 일에 년도만 추가한다.
+ (NSDate *) date:(NSString *)date addYear:(int) yy
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[Date_Conversion stringToDate:date]];
    
    NSString *result = [NSString stringWithFormat:@"%04d-%02d-%02d",([comp year]+yy),[comp month], [comp day]];
    
    return [Date_Conversion stringToDate:result];
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