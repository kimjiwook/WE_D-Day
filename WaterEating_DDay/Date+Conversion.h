//
//  Date+Conversion.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 16..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date_Conversion : NSObject

// Date To String...
+ (NSString *) dateToString : (NSDate *)date;

// string To Date ...
+ (NSDate *) stringToDate : (NSString *)date;

@end
