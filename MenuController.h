//
//  MenuController.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2014. 1. 8..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCGridMenuController.h"

@interface MenuController : UIViewController <JCGridMenuControllerDelegate>

@property (nonatomic, strong) JCGridMenuController *menu;

- (id)init;
- (void)open;
- (void)close;
@end
