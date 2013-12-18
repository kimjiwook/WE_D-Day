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
    
    self.navigationItem.title = @"D-Day";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self viewDidLoad];
    [ddayTable reloadData];
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
    return [self.tableData count];
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
        if (v.tag == 1000 || v.tag == 2000 || v.tag == 3000) {
            [v removeFromSuperview];
        }
    }
    
    EditDay *editDay = [self.tableData objectAtIndex:indexPath.row];
    
    // 제목 만들기
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 180, 30)];
    [title setText:editDay.title];
    [title setFont:[UIFont systemFontOfSize:18.0f]];
    [title setTag:1000];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:title];
    
    // d-Day 만들기
    UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(190, 10, 125, 30)];
    // 64bit int 호환
    NSInteger result = [Date_Calendar stringDate:editDay.date plusOne:(Boolean)editDay.plusone];
    // plusOne 은 Boolean type으로 넘겨주어야 정상처리 됨.
    NSLog(@"DDay Bool : %hhu",(Boolean)editDay.plusone);
    
    [days setText:[Date_Calendar stringResult:result]];
    [days setBackgroundColor:[UIColor clearColor]];
    [days setTextAlignment:NSTextAlignmentRight];
    [days setFont:[UIFont systemFontOfSize:18.0f]];
    [days setTag:2000];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:days];
    
    NSLog(@"index %@, title %@",editDay.index , editDay.title);
    
    if ((Boolean)editDay.badge) {
        UIImageView *badgeImage = [[UIImageView alloc] initWithFrame:CGRectMake(295, 0, 25, 25)];
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

// Table view edit mode
- (IBAction)editButtonAction:(id)sender
{
    [ddayTable setEditing:!ddayTable.editing animated:YES];
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
