//
//  AddViewController.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 22..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITableView *addTable;

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UISwitch *oneDayCheckSwitch;
@property (strong, nonatomic) IBOutlet UITextField *subJectTextField;

- (IBAction)dateChanged:(id)sender;
- (IBAction)onDayCheckAction:(id)sender;

@end
