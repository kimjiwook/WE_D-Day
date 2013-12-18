//
//  Entity+init.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 17..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditDay.h"

@interface Entity_init : NSObject

// Entities 의 뱃지를 전부 취소해준다.
+ (void) badgeinit;

// Badge 여부를 판단 한가지를 꺼내와 리턴 없는경우는 Nil
+ (EditDay *) mainBadge;

// Badge에 달릴 값을 만든다.
+ (NSInteger) badge;

// Badge를 예약한다. (매일매일 정시에 예약한다.)
+ (void) badgeReseve;

@end