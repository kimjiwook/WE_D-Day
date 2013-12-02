//
//  Date+Calendar.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 29..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date_Calendar : NSObject

// 시분초를 없애는 작업
+ (NSDate *) date_yyyy_mm_dd :(NSDate *)date;

// DDay 만들기
+ (NSInteger) startDate :(NSDate *)startDate addOneDays :(Boolean)oneDays;

// D+234, D-23 형식의 String 반환 작업
+ (NSString *) stringResult : (NSInteger) result;

// +100일, +200일 등등 만들기
+ (NSString *) stringDate :(NSDate *)startDate calendar :(NSInteger)day;

// +100일, +200일 등등 Date반환형
+ (NSDate *) date :(NSDate *)startDate calendar :(NSInteger)day;
@end
