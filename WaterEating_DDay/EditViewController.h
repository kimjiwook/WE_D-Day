//
//  EditViewController.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 22..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditDay.h"

@interface EditViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITableView *addTable;

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker; // 오늘 날짜 (date)
@property (nonatomic, strong) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UISwitch *oneDayCheckSwitch; // 시작일 +1일 (Bool)
@property (strong, nonatomic) IBOutlet UITextField *subJectTextField; // 제목 (String)

- (IBAction)dateChanged:(id)sender;
- (IBAction)onDayCheckAction:(id)sender;
- (IBAction)daySave:(id)sender;

@end
