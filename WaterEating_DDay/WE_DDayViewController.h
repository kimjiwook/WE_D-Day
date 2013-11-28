//
//  WE_DDayViewController.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 21..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@interface WE_DDayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *tableData;
    EditViewController *editViewController;
    
}
@property (nonatomic, strong) IBOutlet UITableView *ddayTable;


- (IBAction)editButtonAction:(id)sender;
- (IBAction)addButtonAction:(id)sender;
@end
