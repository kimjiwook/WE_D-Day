//
//  Date+Calendar.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 29..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date_Calendar : NSObject

// D+234, D-23 형식의 String 반환 작업
+ (NSString *) stringResult : (NSInteger) result;

// DDay Create
// ex) D+143, D-54..
+ (NSInteger) stringDate : (NSString *) date plusOne : (BOOL)plusOne;

// +100일 (2013-09-07) Create...
+ (NSString *) stringDate:(NSString *)date howdays:(NSInteger)day;
@end
