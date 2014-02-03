//
//  WE_DDay_Tests.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 18..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Date+Conversion.h"
#import "Date+Calendar.h"

@interface WE_DDay_Tests : XCTestCase

@end

@implementation WE_DDay_Tests

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
    int sample = [Date_Calendar stringDate:@"2012-10-10" plusOne:YES];
    
    NSLog(@"%d",sample);
    
    XCTAssertTrue(sample >= 0, @"오늘 날짜와 예전 날짜 비교");
}

@end
