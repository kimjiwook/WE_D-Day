//
//  DateUtilsTests.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 16..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Date+Calendar.h"

@interface DateUtilsTests : XCTestCase

@end

@implementation DateUtilsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    NSLog(@"resultDate : %ld",[Date_Calendar stringDate:@"2012-05-31" plusOne:1]);
}

@end
