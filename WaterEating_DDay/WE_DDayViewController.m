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
    
    tableData = [[NSMutableArray alloc] initWithArray:[self topLevelItems]];
    
    [ddayTable setDataSource:self];
    [ddayTable setDelegate:self];
    // TableView DataSource, Delegate Setting
    [ddayTable setBackgroundColor:[UIColor clearColor]];

    
    self.navigationItem.title = @"D-Day";    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSArray *)topLevelItems {
    NSMutableArray *items = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        [items addObject:[NSString stringWithFormat:@"제목은 %d", i + 1]];
    }
    
    return items;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
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
    [title setText:[tableData objectAtIndex:indexPath.row]];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor whiteColor]];
    [title setFont:[UIFont systemFontOfSize:14.0f]];
    [title setTag:1000];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:title];
    
    return cell;
}

#pragma mark - Table view delegate

// Table view Cell Select Action
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 해제
}


// Table view edit Cell move Action
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

// Table view editing..
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Cell Delete Action
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

// Table view edit mode
- (IBAction)editButtonAction:(id)sender
{
    [ddayTable setEditing:!ddayTable.editing];
}

// Table view add mode
- (IBAction)addButtonAction:(id)sender
{
    
}

@end
