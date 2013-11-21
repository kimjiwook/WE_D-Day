//
//  WE_DDayViewController.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 21..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "WE_DDayViewController.h"

@interface WE_DDayViewController ()

@end

@implementation WE_DDayViewController
@synthesize ddayTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ddayTable setDataSource:self];
    [ddayTable setDelegate:self];
    // TableView DataSource, Delegate Setting
    
    self.navigationItem.title = @"D-Day";    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSArray *viewsToRemove = [cell.contentView subviews];
    for (UIView *v in viewsToRemove)
    {
        if (v.tag == 1000) {
            [v removeFromSuperview];
        }
        
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 30)];
    [title setText:[NSString stringWithFormat:@"제목란 : %d",indexPath.row+1]];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont systemFontOfSize:14.0f]];
    [title setTag:1000];
    
    [cell.contentView addSubview:title];
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 해제
}

- (IBAction)editButtonAction:(id)sender
{
    
}

@end
