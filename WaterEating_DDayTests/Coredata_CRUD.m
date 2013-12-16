//
//  Coredata_CRUD.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 5..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EditDay.h"

@interface Coredata_CRUD : XCTestCase

@end

@implementation Coredata_CRUD

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    
    [EditDay MR_truncateAll];
    // Entity 전체 삭제
    
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)test_Create
{
    EditDay *editDay = [EditDay MR_createEntity]; // Entitiy 생성
    
    NSDate *dateSelected = [Date_Calendar date_yyyy_mm_dd:[NSDate date]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    // 정확한 날 수를 계산하기 위해 날짜정보에서 시간정보를 0시 0분 0초로 설정
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&dateSelected interval:Nil forDate:dateSelected];
    
    // Index 는 10 부터 시작을 하며, 10씩 증가를 한다.
    [editDay setIndex:[NSNumber numberWithInteger:([[EditDay MR_findAll] count] * 10)]];
    [editDay setDate:@"2013-12-16"]; // 오늘 날짜로 테스트
    [editDay setTitle:@"Test Title"]; // 제목
    [editDay setPlusone:[NSNumber numberWithBool:TRUE]]; // 시작일 +1일
    [editDay setBadge:FALSE]; // 뱃지 생성당시는 NO
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];// 저장
    
    
    NSMutableArray *tableData = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"index" ascending:YES]];
    // index로 정렬해서 뿌려줌
    
    EditDay *assertEditDay = [tableData objectAtIndex:([editDay.index integerValue]/10)-1];
    
    NSString *dateSelectedEquls = [Date_Calendar dateToString:[NSDate date]];
    
    XCTAssertEqualObjects(assertEditDay.date, dateSelectedEquls, @"C_date false");
    XCTAssertEqualObjects(assertEditDay.title, @"Test Title", @"C_title false");
    XCTAssertTrue([assertEditDay.plusone boolValue], @"C_startdate false");
    XCTAssertFalse([assertEditDay.badge boolValue], @"C_badge true");
    
    NSLog(@"%@",assertEditDay.date);
    NSLog(@"%@",assertEditDay.title);
    NSLog(@"%@,%c",assertEditDay.plusone,[assertEditDay.plusone boolValue]);
    NSLog(@"%@,%c",assertEditDay.badge,[assertEditDay.badge boolValue]);
}

@end
