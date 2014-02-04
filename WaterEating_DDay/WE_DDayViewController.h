//
//  WE_DDayViewController.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 21..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"
#import "DetailViewController.h"
#import "MobileAdView.h"

@interface WE_DDayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MobileAdViewDelegate>
{
    EditViewController *editViewController;
    DetailViewController *detailViewController;
}
@property (nonatomic, strong) IBOutlet UITableView *ddayTable;

@property (nonatomic, strong) NSMutableArray *tableData;

@property (nonatomic, assign) MobileAdView *adView;

- (IBAction)editButtonAction:(id)sender;
- (IBAction)addButtonAction:(id)sender;
@end
