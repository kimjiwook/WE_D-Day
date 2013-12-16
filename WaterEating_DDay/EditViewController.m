//
//  EditViewController.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 22..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize oneDayCheckSwitch;
@synthesize addTable;
@synthesize datePicker;
@synthesize dayLabel;
@synthesize subJectTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"새로운 D-Day"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] init]];
    [self.navigationItem.rightBarButtonItem setTitle:@"저장"];
    [self.navigationItem.rightBarButtonItem setAction:@selector(daySave:)];
    [self.navigationItem.rightBarButtonItem setTarget:self];
    // 이유는 잘 모르겠는데. addTarget: action 메소드가 없어서 두가지를 붙여놓음
    
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
}

- (IBAction)daySave:(id)sender
{
    EditDay *editDay = [EditDay MR_createEntity]; // Entitiy 생성

    NSDate *dateSelected = self.datePicker.date;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    // 정확한 날 수를 계산하기 위해 날짜정보에서 시간정보를 0시 0분 0초로 설정
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&dateSelected interval:Nil forDate:dateSelected];
    
    // Index 는 10 부터 시작을 하며, 10씩 증가를 한다.
    [editDay setIndex:[NSNumber numberWithInteger:([[EditDay MR_findAll] count] * 10)]];
    [editDay setDate:[Date_Conversion dateToString:dateSelected]]; // 선택한 날짜
    [editDay setTitle:[subJectTextField text]]; // 제목
    [editDay setPlusone:[NSNumber numberWithBool:oneDayCheckSwitch.on]]; // 시작일 +1일
    [editDay setBadge:[NSNumber numberWithBool:NO]]; // 뱃지 생성당시는 NO
    // 여기에선 Plusone 값 제대로 저장이됨
    NSLog(@"plusOne : %d , %@",oneDayCheckSwitch.on,[NSNumber numberWithBool:oneDayCheckSwitch.on]);
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];// 저장
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            return 175;
        }
    }
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  Nil;
    }else{
        dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
        dayLabel.text = @"D+0 일";
        [dayLabel setFont:[UIFont systemFontOfSize:20.0f]];
        [dayLabel setTextAlignment:NSTextAlignmentCenter];
        return dayLabel;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.section == 0) {
        UILabel *subJectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 50, 40)];
        [subJectLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [subJectLabel setTextAlignment:NSTextAlignmentLeft];
        [subJectLabel setText:@"제목"];
        [cell.contentView addSubview:subJectLabel];
        
        subJectTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, 240, 40)];
        
        [subJectTextField setDelegate:self];
        
        [subJectTextField setTextAlignment:NSTextAlignmentRight];
        [subJectTextField setFont:[UIFont systemFontOfSize:18.0f]];
        [subJectTextField setPlaceholder:@"제목을 넣어주세요."];
        [cell.contentView addSubview:subJectTextField];
    }
    else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            UILabel *startCheckLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 40)];
            [startCheckLabel setFont:[UIFont systemFontOfSize:18.0f]];
            [startCheckLabel setTextAlignment:NSTextAlignmentLeft];
            [startCheckLabel setText:@"시작일부터 1일"];
            [cell.contentView addSubview:startCheckLabel];
            
            oneDayCheckSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(251, 9, 49, 31)];
            [oneDayCheckSwitch setOn:false];
            [oneDayCheckSwitch addTarget:self action:@selector(onDayCheckAction:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:oneDayCheckSwitch];
            
        }else if(indexPath.row == 1) {
            datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
            [datePicker setDatePickerMode:UIDatePickerModeDate];
            [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"Korean"]];
            [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:datePicker];
        }
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
    // 64bit int 호환
    NSInteger result = [Date_Calendar stringDate:
                        [Date_Conversion dateToString: self.datePicker.date] plusOne:oneDayCheckSwitch.on];

    self.dayLabel.text = [Date_Calendar stringResult:result];

}

- (IBAction)onDayCheckAction:(id)sender
{
    [self dateChanged:nil];
}

// TextField Return시 내리기
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
