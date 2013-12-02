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

+ (DetailViewController *) instance
{
    static DetailViewController *instance;
    
    if (!instance) {
        instance = [[DetailViewController alloc] init];
    }
    
    return instance;
}

- (void)setting : (EditDay *) editDayCopy
{
    editDay = editDayCopy;
    NSLog(@"%@", editDay.title);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", editDay.title);
    
    [self.navigationItem setTitle:editDay.title];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] init]];
    [self.navigationItem.rightBarButtonItem setTitle:@"편집"];
//    [self.navigationItem.rightBarButtonItem setAction:@selector(daySave:)];
    [self.navigationItem.rightBarButtonItem setTarget:self];
    // 이유는 잘 모르겠는데. addTarget: action 메소드가 없어서 두가지를 붙여놓음
    
    detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    [detailTable setDataSource:self];
    [detailTable setDelegate:self];
    
    [detailTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:detailTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
    
    [cell setBackgroundColor:[UIColor clearColor]];

    return cell;
}

@end
