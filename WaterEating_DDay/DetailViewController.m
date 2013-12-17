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

- (void)setting : (EditDay *) editDayCopy
{
    editDay = editDayCopy;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:editDay.title];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] init]];
    [self.navigationItem.rightBarButtonItem setTitle:@"뱃지알림"];
    [self.navigationItem.rightBarButtonItem setAction:@selector(badgeSetting:)];
    [self.navigationItem.rightBarButtonItem setTarget:self];
    // 이유는 잘 모르겠는데. addTarget: action 메소드가 없어서 두가지를 붙여놓음
    
    detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    [detailTable setDataSource:self];
    [detailTable setDelegate:self];
    
    [detailTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:detailTable];
    [self awesomeMenuCreate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 뱃지알림 설정
- (IBAction)badgeSetting:(id)sender
{
    NSArray *btnTitle = [[NSArray alloc] initWithObjects:BTN_OK,BTN_CANCEL, nil];
    if ((Boolean)editDay.badge) {
        // 뱃지 등록이 되어있는경우 '취소' 함
        [AlertViewCreate alertTitle:TITLE_NOTI Message:MSG_NOTI_CANCEL Create:btnTitle set:self];
    }else{
        // 뱃지 등록이 안되어있는경우 '등록' 함 (다른 일정의 뱃지가 있는경우 전부 삭제함
        [AlertViewCreate alertTitle:TITLE_NOTI Message:MSG_NOTI_OK Create:btnTitle set:self];
    }
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([alertView.message isEqualToString:MSG_NOTI_OK]) {
            [Entity_init badgeinit];
            editDay.badge = [NSNumber numberWithBool:TRUE];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];// 저장
            
            UIApplication *application = [UIApplication sharedApplication];
            application.applicationIconBadgeNumber = 0;
            application.applicationIconBadgeNumber = [Entity_init badge];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([alertView.message isEqualToString:MSG_NOTI_CANCEL]){
            [Entity_init badgeinit];
        }
    }
}

// Path button UI
// 이걸로 DetailView 보여지는 형식 변경
- (void)awesomeMenuCreate
{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *d_puls = [UIImage imageNamed:@"D_puls.png"];
    UIImage *d_minus = [UIImage imageNamed:@"D_minus.png"];
    UIImage *year = [UIImage imageNamed:@"Year.png"];
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:d_puls
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:d_minus
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:year
                                                    highlightedContentImage:nil];
    
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.frame startItem:startItem optionMenus:menus];
    menu.delegate = self;
    
	menu.menuWholeAngle = M_PI_2;
	menu.farRadius = 110.0f;
	menu.endRadius = 100.0f;
	menu.nearRadius = 90.0f;
    menu.animationDuration = 0.3f;
    menu.startPoint = CGPointMake(40.0, self.view.frame.size.height-40.0);
    
    [self.view addSubview:menu];
}

/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇ GET RESPONSE OF MENU ⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    // 0 = D+ //1 = D- //2 = Y (년도별 표시)
    tableViewType = idx;
    [detailTable reloadData];
}
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableViewType == 0) {
        return 51;
    }else if (tableViewType == 1){
        // D- 일때만 제대로 계산한다.
        
        NSInteger d_minus = [Date_Calendar stringDate:editDay.date plusOne:(Boolean)editDay.plusone];
        
        if (d_minus < 0)
        {
            d_minus = (d_minus*-1)/100;
            NSLog(@"값은 : %ld", d_minus);
        }
        
        return d_minus+1;
        
    }else if (tableViewType == 2){
        return 31;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        if (v.tag == 1000 || v.tag == 1100 || v.tag == 1200 || v.tag == 2000 || v.tag == 3000) {
            [v removeFromSuperview];
        }
    }
    
    if (indexPath.row == 0)
    {
        UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 165)];
        
        // 64bit int 호환
        NSInteger result = [Date_Calendar stringDate:editDay.date plusOne:(Boolean)editDay.plusone];
        
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
        
        if ((Boolean)editDay.badge) {
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
            UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
            [date setText:[NSString stringWithFormat:@"%ld 일",indexPath.row * 100]];
            [date setTag:2000];
            
            [cell.contentView addSubview:date];
            
            //Right
            UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 40)];
            [days setText:[Date_Calendar stringDate:editDay.date howdays:indexPath.row*100]];
            [days setTextAlignment:NSTextAlignmentRight];
            [days setTag:3000];
            
            [cell.contentView addSubview:days];
            
        }else if (tableViewType == 1){
            // D- 계산법
            // Left
            NSInteger d_minus = [Date_Calendar stringDate:editDay.date plusOne:(Boolean)editDay.plusone];
            d_minus = (d_minus)/100;
            
            UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
            [date setText:[NSString stringWithFormat:@"D%ld 일",(d_minus*100) + ((indexPath.row-1)*100)]];
            [date setTag:2000];
            
            [cell.contentView addSubview:date];
            
            //Right
            UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 40)];
            [days setText:[Date_Calendar stringDate:editDay.date howdays:(d_minus*100) + ((indexPath.row-1)*100)]];
            [days setTextAlignment:NSTextAlignmentRight];
            [days setTag:3000];
            
            [cell.contentView addSubview:days];
            
        }else if (tableViewType == 2){
            // 1주년씩 계산법
            // Left
            UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
            [date setText:[NSString stringWithFormat:@"%ld 주년",indexPath.row]];
            [date setTag:2000];
            
            [cell.contentView addSubview:date];
            
            //Right
            UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 40)];
            [days setText:[Date_Calendar stringDate:editDay.date howdays:indexPath.row*365]];
            [days setTextAlignment:NSTextAlignmentRight];
            [days setTag:3000];
            
            [cell.contentView addSubview:days];
        }
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

#pragma mark - Table view delegate

// Table view Cell Select Action
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 해제
}

@end