//
//  AddViewController.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 22..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"D-Day 추가"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] init]];
    [self.navigationItem.rightBarButtonItem setTitle:@"저장"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dateChanged:(id)sender
{
    // Today
    NSDate *dateNow = [NSDate date];
    // Select Day
    NSDate *dateSelected = self.datePicker.date;
    // 64bit int 호환
    NSInteger result = 0;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // 정확한 날 수를 계산하기 위해 날짜정보에서 시간정보를 0시 0분 0초로 설정
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&dateNow interval:Nil forDate:dateNow];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&dateSelected interval:Nil forDate:dateSelected];
    
    result = [[calendar components:NSDayCalendarUnit fromDate:dateSelected toDate:dateNow options:0] day];
    
    self.dayLabel.text = [NSString stringWithFormat:@"%ld 일",result];
    
}

@end
