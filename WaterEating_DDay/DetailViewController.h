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
#import "EditViewController.h"

@interface DetailViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, RNGridMenuDelegate>
{
    NSInteger tableViewType;
    EditViewController *editViewController;
}
@property (nonatomic, readonly) EditDay *editDay;
@property (nonatomic, strong) IBOutlet UITableView *detailTable;

- (void)setting : (EditDay *) editDayCopy;

@end
