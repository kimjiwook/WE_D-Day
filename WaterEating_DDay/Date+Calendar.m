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
    
    // 아래와 같이 해야 내가 원하는 날짜가 나옴
    // DateFormat 을 둘다 맞춰야지 된다.
    NSLog(@"Today : %@, Select Date : %@",
          [dateFormat stringFromDate:dateNow],
          [dateFormat stringFromDate:stringToDate]);
    
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
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *daysDate = [calendar dateByAddingComponents:components toDate:[Date_Conversion stringToDate:date] options:0];
    
    NSLog(@"date CC %@", [Date_Conversion stringToDate:date]);
    NSLog(@"input date %@",date);
    NSLog(@"daysDate CC %@",daysDate);
    NSLog(@"daysDate %@",[Date_Conversion dateToString:daysDate]);

    return [Date_Conversion dateToString:daysDate];
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