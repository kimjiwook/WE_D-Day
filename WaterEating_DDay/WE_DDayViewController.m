//
//  WE_DDayViewController.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 21..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "WE_DDayViewController.h"
#import "EditDay.h"

@interface WE_DDayViewController ()

@end

@implementation WE_DDayViewController
@synthesize ddayTable;
@synthesize tableData;
@synthesize adView;
@synthesize badgeImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    self.tableData = [NSMutableArray arrayWithArray:[EditDay MR_findAll]];
    self.tableData = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"index" ascending:YES]];
    // index로 정렬해서 뿌려줌
    
    [ddayTable setDataSource:self];
    [ddayTable setDelegate:self];
    // TableView DataSource, Delegate Setting
    [ddayTable setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:[ddayTable frame]];
    NSLog(@"%f",self.view.bounds.size.height);
    if(self.view.bounds.size.height == 568){
        image.image = [UIImage imageNamed:@"WE_DDay_1136.png"];
    }else{
        image.image = [UIImage imageNamed:@"WE_DDay_960.png"];
    }
    
    [ddayTable setBackgroundColor:[UIColor clearColor]];
    [ddayTable setBackgroundView:image];
    
    self.navigationItem.title = @"D-Day";

    [self createAdPost];
}

- (void)createAdPost
{
    adView = [MobileAdView sharedMobileAdView];
    [adView setFrame:CGRectMake(0, (self.view.frame.size.height-50), 320, 50)];
    [adView setSuperViewController:self];
    [adView setChannelId:@"mios_609d1408867643cbb33f3ccc006dfacd"];
    [adView setIsTest:NO];
    
    adView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleWidth;
    
    [adView setDelegate:self];
    [adView start];
    
    [self.view addSubview:adView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self viewDidLoad];
// 반투명 처리가 해결이 안됨
    [self.ddayTable reloadData];
    [adView start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [adView stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    NSArray *viewsToRemove = [cell.contentView subviews];
    for (UIView *v in viewsToRemove)
    {
        [v removeFromSuperview];
    }
    
    [cell setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.5f]];
    
    EditDay *editDay = [self.tableData objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:editDay.title];
    [cell.textLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [cell.textLabel setTag:1000+indexPath.row];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];

    NSInteger result = [Date_Calendar stringDate:editDay.date plusOne:[editDay.plusone boolValue]];
    
    [cell.detailTextLabel setText:[Date_Calendar stringResult:result]];
    [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
    [cell.detailTextLabel setTextAlignment:NSTextAlignmentRight];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [cell.detailTextLabel setTextColor:[UIColor blackColor]];
    [cell.detailTextLabel setTag:2000+indexPath.row];
    
    if ([editDay.badge boolValue]) {
        badgeImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-25, 0, 25, 25)];
        UIImage *image = [UIImage imageNamed:@"noti.png"];
        badgeImage.image = image;
        [badgeImage setTag:3000];
        [cell.contentView addSubview:badgeImage];
    }
    return cell;
}

#pragma mark - Table view delegate
// Table view Cell Select Action
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 해제
    
    EditDay *editDay = [self.tableData objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    [detailViewController setting:editDay]; // 값 복사하기
    
    [self.navigationController pushViewController:detailViewController animated:YES]; // PushView
}


// Table view edit Cell move Action
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    NSInteger fromRow = sourceIndexPath.row;
    NSInteger toRow = destinationIndexPath.row;
    
    id object = [self.tableData objectAtIndex:fromRow];
    
    // TableView Data 위치 변경
    [self.tableData removeObjectAtIndex:fromRow];
    [self.tableData insertObject:object atIndex:toRow];
    
    // 데이터를 가져와 Index 만 바꿔준다.
    for (int i = 0; i < self.tableData.count; i++)
    {
        EditDay *editDay = [self.tableData objectAtIndex:i];
        
        editDay.index = [NSNumber numberWithInteger:i * 10];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

// Table view editing..
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Cell Delete Action
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //CoreData row Delete...
        EditDay *editDay = [self.tableData objectAtIndex:indexPath.row];
        [editDay MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        // TableView Cell Delete...
        [tableData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = [Entity_init badge];
    }
}

// Table Delete Button Rename...
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"삭제";
}

// Table view edit mode
- (IBAction)editButtonAction:(id)sender
{
    [ddayTable setEditing:!ddayTable.editing animated:YES];
    if (ddayTable.editing) {
        [self.navigationItem.leftBarButtonItem setTitle:@"완료"];
        [self.navigationItem.rightBarButtonItem setEnabled:false];
        [badgeImage setFrame:CGRectMake(self.view.bounds.size.width-25-38, 0, 25, 25)];
    }else{
        [self.navigationItem.leftBarButtonItem setTitle:@"편집"];
        [self.navigationItem.rightBarButtonItem setEnabled:true];
        [badgeImage setFrame:CGRectMake(self.view.bounds.size.width-25, 0, 25, 25)];
    }
}

// Table view add mode
- (IBAction)addButtonAction:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Edit" bundle:nil];
    editViewController = [storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    //    [self presentViewController:addViewController animated:YES completion:Nil]; //ModalView
    [self.navigationController pushViewController:editViewController animated:YES]; // PushView
}

@end