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
    [self.navigationItem.rightBarButtonItem setTitle:@"편집"];
    //    [self.navigationItem.rightBarButtonItem setAction:@selector(daySave:)];
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

// Path button UI
// 이걸로 DetailView 보여지는 형식 변경
- (void)awesomeMenuCreate
{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
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
    if (idx == 0) {
        
    }else if(idx == 1){
        
    }else if(idx == 2){
        
    }else{
        NSLog(@"is not menu");
    }
}
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 51;
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
        if (v.tag == 1000 || v.tag == 2000 || v.tag == 3000) {
            [v removeFromSuperview];
        }
    }
    
    if (indexPath.row == 0)
    {
        UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 165)];
        
        // 64bit int 호환
        NSInteger result = [Date_Calendar startDate:editDay.date
                                         addOneDays:(BOOL)editDay.startdate];
        
        [days setText:[Date_Calendar stringResult:result]];
        [days setTextAlignment:NSTextAlignmentRight];
        [days setFont:[UIFont systemFontOfSize:55.0f]];
        [days setTag:1000];
        
        [cell.contentView addSubview:days];
        
    }else{
        
        // Left
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
        [date setText:[NSString stringWithFormat:@"%d 일",indexPath.row * 100]];
        [date setTag:2000];
        
        [cell.contentView addSubview:date];
        
        //Right
        UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 40)];
        [days setText:[Date_Calendar stringDate:editDay.date calendar:indexPath.row*100]];
        [days setTextAlignment:NSTextAlignmentRight];
        [days setTag:3000];
        
        [cell.contentView addSubview:days];
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
