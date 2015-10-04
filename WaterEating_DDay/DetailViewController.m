//
//  DetailViewController.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 2..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize editDay;
@synthesize detailTable;

// ViewDidLoad 이전에 시작됨.
- (void)setting : (EditDay *) editDayCopy {
    editDay = editDayCopy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:editDay.title];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] init]];
    [self.navigationItem.rightBarButtonItem setTitle:@"뱃지알림"];
    [self.navigationItem.rightBarButtonItem setAction:@selector(badgeSetting:)];
    [self.navigationItem.rightBarButtonItem setTarget:self];
    // 이유는 잘 모르겠는데. addTarget: action 메소드가 없어서 두가지를 붙여놓음
    
    totalRowCount = 30;
    
    detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    [detailTable setDataSource:self];
    [detailTable setDelegate:self];
    
    [detailTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:detailTable];
    [self createRNGridMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 뱃지알림 설정
- (IBAction)badgeSetting:(id)sender {
    NSArray *btnTitle = [[NSArray alloc] initWithObjects:BTN_OK,BTN_CANCEL, nil];
    if ([editDay.badge boolValue]) {
        // 뱃지 등록이 되어있는경우 '취소' 함
        [AlertViewCreate alertTitle:TITLE_NOTI Message:MSG_NOTI_CANCEL Create:btnTitle set:self];
    }else{
        // 뱃지 등록이 안되어있는경우 '등록' 함 (다른 일정의 뱃지가 있는경우 전부 삭제함
        [AlertViewCreate alertTitle:TITLE_NOTI Message:MSG_NOTI_OK Create:btnTitle set:self];
    }
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if ([alertView.message isEqualToString:MSG_NOTI_OK]) {
            [Entity_init badgeinit];
            [editDay setBadge:[NSNumber numberWithBool:YES]];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];// 저장
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = [Entity_init badge];
            
        }else if ([alertView.message isEqualToString:MSG_NOTI_CANCEL]){
            [Entity_init badgeinit];
            [UIApplication sharedApplication].applicationIconBadgeNumber = [Entity_init badge];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createRNGridMenu {
    UIButton *gridMenu = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height-10-55, 55, 55)];
    [gridMenu setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [gridMenu addTarget:self action:@selector(actionRNGridMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gridMenu];
}

- (IBAction)actionRNGridMenu:(id)sender {
    [self showList];
}

#pragma mark - GridMenu DataSource
- (void)showList {
    NSInteger numberOfOptions = 3;
    NSArray *options = @[
                         @"D+Day",
                         @"D-Day",
                         @"Year",
                         ];
    RNGridMenu *av = [[RNGridMenu alloc] initWithTitles:[options subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    //    av.itemTextAlignment = NSTextAlignmentLeft;
    av.itemFont = [UIFont boldSystemFontOfSize:18];
    av.itemSize = CGSizeMake(150, 55);
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

#pragma mark - GridMenu에서 선택된 값에 따라 Type 변경 및 TableView Reload
- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    // 0 = D+ //1 = D- //2 = Y (년도별 표시)
    tableViewType = itemIndex;
    [detailTable reloadData];
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableViewType == 0 || tableViewType == 1 || tableViewType == 2) {
        return totalRowCount;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 175;
    }
    return 50;
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
        if (v.tag == 1000 || v.tag == 1100 || v.tag == 1200 || v.tag == 1300 ||v.tag == 2000 || v.tag == 3000) {
            [v removeFromSuperview];
        }
    }
    
    NSInteger result = [Date_Calendar stringDate:editDay.date plusOne:[editDay.plusone boolValue]];
    
    if (indexPath.row == 0)
    {
        UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 165)];
        
        // 지난 날에 회색 처리 하기 위해 result 를 if 밖으로 제외
        [days setText:[Date_Calendar stringResult:result]];
        [days setTextAlignment:NSTextAlignmentRight];
        [days setFont:[UIFont systemFontOfSize:55.0f]];
        [days setTag:1000];
        
        [cell.contentView addSubview:days];
        
        // 날짜 표시
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 30)];
        
        [date setText:editDay.date];
        [date setTextAlignment:NSTextAlignmentLeft];
        [date setFont:[UIFont systemFontOfSize:22.0f]];
        [date setTag:1100];
        
        [cell.contentView addSubview:date];
        
        // ... 이미지 표시
        UIImageView *detail_edit = [[UIImageView alloc] initWithFrame:CGRectMake(280, 160, 40, 10)];
        [detail_edit setImage:[UIImage imageNamed:@"detail_edit.png"]];
        [detail_edit setTag:1300];
        [cell.contentView addSubview:detail_edit];
        
        if ([editDay.badge boolValue]) {
            UIImageView *badgeImage = [[UIImageView alloc] initWithFrame:CGRectMake(295, 0, 25, 25)];
            UIImage *image = [UIImage imageNamed:@"noti.png"];
            badgeImage.image = image;
            [badgeImage setTag:1200];
            [cell.contentView addSubview:badgeImage];
        }
        
    }else{
        if (tableViewType == 0) {
            // D+ 계산법
            // Left
            UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 40)];
            [date setText:[NSString stringWithFormat:@"%ld 일",indexPath.row * 100]];
            [date setTag:2000];
            
            [cell.contentView addSubview:date];
            
            //Right
            UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 100, 40)];
            [days setText:[Date_Calendar stringDate:editDay.date howdays:indexPath.row*100]];
            [days setTextAlignment:NSTextAlignmentRight];
            [days setTag:3000];
            
            [cell.contentView addSubview:days];
            
            if (result > indexPath.row*100) {
                [date setTextColor:[UIColor grayColor]];
                [days setTextColor:[UIColor grayColor]];
            }
            
        }else if (tableViewType == 1){
            // D- 계산법
            // Left
            NSInteger d_minus = [Date_Calendar stringDate:editDay.date plusOne:[editDay.plusone boolValue]];
            d_minus = (d_minus)/100;
            
            UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 40)];
            [date setText:[NSString stringWithFormat:@"D%ld 일",(d_minus*100) + ((indexPath.row-1)*100)]];
            [date setTag:2000];
            
            [cell.contentView addSubview:date];
            
            //Right
            UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 100, 40)];
            [days setText:[Date_Calendar stringDate:editDay.date howdays:(d_minus*100) + ((indexPath.row-1)*100)]];
            [days setTextAlignment:NSTextAlignmentRight];
            [days setTag:3000];
            
            [cell.contentView addSubview:days];
            
        }else if (tableViewType == 2){
            // 1주년씩 계산법
            // Left
            UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 40)];
            
            NSInteger yearDate = [Date_Calendar startDate:[Date_Conversion stringToDate:editDay.date] endDate:[Date_Calendar date:editDay.date addYear:indexPath.row] plusOne:[editDay.plusone boolValue]];
            
            [date setText:[NSString stringWithFormat:@"%ld 주년(%ld일)",(long)indexPath.row, (long)yearDate]];
            [date setTag:2000];
            
            [cell.contentView addSubview:date];
            
            //Right
            UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 100, 40)];
            [days setText:[Date_Conversion dateToString:[Date_Calendar date:editDay.date addYear:indexPath.row]]];
            [days setTextAlignment:NSTextAlignmentRight];
            [days setTag:3000];
            
            [cell.contentView addSubview:days];
            
            if (result > yearDate) {
                [date setTextColor:[UIColor grayColor]];
                [days setTextColor:[UIColor grayColor]];
            }
            
        }
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (totalRowCount == indexPath.row+1) {
        // 페이지 10개씩 추가해 주기.
        totalRowCount += 20;
        [self.detailTable reloadData];
    }
}

#pragma mark - Table view delegate

// Table view Cell Select Action
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 해제
    if (indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AddEdit" bundle:nil];
        addEditViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddEditViewController"];
        [addEditViewController setting:editDay];
        //    [self presentViewController:addViewController animated:YES completion:Nil]; //ModalView
        [self.navigationController pushViewController:addEditViewController animated:YES]; // PushView
    }
}

@end