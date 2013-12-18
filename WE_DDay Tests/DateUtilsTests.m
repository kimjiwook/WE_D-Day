//
//  DateUtilsTests.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 16..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Date+Calendar.h"
#import "Entity+init.h"

@interface DateUtilsTests : XCTestCase
@property (nonatomic, strong) EditDay *editDay;
@end

@implementation DateUtilsTests
@synthesize editDay;
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
    
    NSDate *dateSelected = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    // 정확한 날 수를 계산하기 위해 날짜정보에서 시간정보를 0시 0분 0초로 설정
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&dateSelected interval:Nil forDate:dateSelected];
    
    // Index 는 10 부터 시작을 하며, 10씩 증가를 한다.
    [editDay setIndex:[NSNumber numberWithInteger:([[EditDay MR_findAll] count] * 10)]];
    [editDay setDate:@"2012-05-31"]; // 오늘 날짜로 테스트
    [editDay setTitle:@"Test Title"]; // 제목
    [editDay setPlusone:[NSNumber numberWithBool:TRUE]]; // 시작일 +1일
    [editDay setBadge:[NSNumber numberWithBool:TRUE]]; // 뱃지 생성당시는 NO
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];// 저장
    
    [Entity_init badgeReseve];
}

@end
