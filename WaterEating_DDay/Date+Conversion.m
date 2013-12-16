//
//  Date+Conversion.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 16..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "Date+Conversion.h"

@implementation Date_Conversion

// date To String ...
+ (NSString *) dateToString : (NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormat stringFromDate:date];
}

// string To Date ...
+ (NSDate *) stringToDate : (NSString *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormat dateFromString:date];
}
@end
