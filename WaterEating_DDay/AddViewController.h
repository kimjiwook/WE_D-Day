//
//  AddViewController.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 22..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UILabel *dayLabel;

- (IBAction)dateChanged:(id)sender;

@end
