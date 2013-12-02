//
//  DetailViewController.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 2..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditDay.h"

@interface DetailViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) EditDay *editDay;
@property (nonatomic, strong) IBOutlet UITableView *detailTable;

- (void)setting : (EditDay *) editDayCopy;

@end
