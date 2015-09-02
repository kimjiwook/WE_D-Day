//
//  DetailViewController.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 2..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditDay.h"
#import "RNGridMenu.h"
#import "AddEditViewController.h"

@interface DetailViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, RNGridMenuDelegate>
{
    NSInteger tableViewType;
    NSInteger totalRowCount;
    AddEditViewController *addEditViewController;
}
@property (nonatomic, readonly) EditDay *editDay;
@property (nonatomic, strong) IBOutlet UITableView *detailTable;
@property (nonatomic, strong) UITableViewController *sample;

- (void)setting : (EditDay *) editDayCopy;

@end