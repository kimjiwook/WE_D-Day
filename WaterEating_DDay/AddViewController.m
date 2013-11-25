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
@synthesize oneDayCheckSwitch;
@synthesize addTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"D-Day 추가"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] init]];
    [self.navigationItem.rightBarButtonItem setTitle:@"저장"];
    
    // Storyboard 에서 작성시 err 발생함..
    addTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    [addTable setDataSource:self];
    [addTable setDelegate:self];
    
    // TableView DataSource, Delegate Setting
    [addTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:addTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            return 100;
        }
    }
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    return cell;
}

#pragma mark - Table view delegate

// Table view Cell Select Action
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 해제
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
    if (oneDayCheckSwitch.on)
    { result += 1; }
    
    if (result >= 0) {
        // D+ 일 경우
        self.dayLabel.text = [NSString stringWithFormat:@"D+%ld 일",result];
    }else{
        // D- 일 경우
        self.dayLabel.text = [NSString stringWithFormat:@"D%ld 일",result];
    }
}

- (IBAction)onDayCheckAction:(id)sender
{
    [self dateChanged:nil];
}

@end
