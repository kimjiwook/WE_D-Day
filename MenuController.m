//
//  MenuController.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2014. 1. 8..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

#import "MenuController.h"

#define GM_TAG        1001

@interface MenuController ()

@end

@implementation MenuController
@synthesize menu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setView:[[JCUIViewTransparent alloc] initWithFrame:CGRectMake(320-44, 50, 44, 44*3)]];
        [self.view setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Initialise

- (id)init
{
    self = [super init];
    if (self) {
        JCGridMenuRow *pocket = [[JCGridMenuRow alloc]
                                 initWithImages:@"menu_dpuls"
                                 selected:@"menu_dpuls_alpha"
                                 highlighted:@"menu_dpuls_alpha"
                                 disabled:@"menu_dpuls"];
        JCGridMenuRow *twitter = [[JCGridMenuRow alloc]
                                  initWithImages:@"menu_minus"
                                  selected:@"menu_minus_alpha"
                                  highlighted:@"menu_minus_alpha"
                                  disabled:@"menu_minus"];
        JCGridMenuRow *facebook = [[JCGridMenuRow alloc]
                                   initWithImages:@"menu_year"
                                   selected:@"menu_year_alpha"
                                   highlighted:@"menu_year_alpha"
                                   disabled:@"menu_year"];
        
        NSArray *rows = [[NSArray alloc] initWithObjects:pocket, twitter, facebook, nil];
        menu = [[JCGridMenuController alloc] initWithFrame:CGRectMake(320-44, 50, 44, (44*[rows count])+[rows count]) rows:rows tag:GM_TAG];
        [menu setDelegate:self];
        [self.view addSubview:menu.view];
    }
    return self;
}


#pragma mark - Open and Close

- (void)open
{
    [menu open];
}

- (void)close
{
    [menu close];
}



#pragma mark - JCGridMenuController Delegate

- (void)jcGridMenuRowSelected:(NSInteger)indexTag indexRow:(NSInteger)indexRow isExpand:(BOOL)isExpand
{
    
    if (isExpand) {
        NSLog(@"jcGridMenuRowSelected %i %i isExpand", indexTag, indexRow);
    } else {
        NSLog(@"jcGridMenuRowSelected %i %i !isExpand", indexTag, indexRow);
    }
    
    if (indexTag==GM_TAG) {
    }
    
}

- (void)jcGridMenuColumnSelected:(NSInteger)indexTag indexRow:(NSInteger)indexRow indexColumn:(NSInteger)indexColumn
{
    NSLog(@"jcGridMenuColumnSelected %i %i %i", indexTag, indexRow, indexColumn);
    
    if (indexTag==GM_TAG) {
    }
    
}

@end
