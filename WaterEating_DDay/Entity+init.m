//
//  Entity+init.m
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 17..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import "Entity+init.h"
#import "EditDay.h"

@implementation Entity_init

// Entities 의 뱃지를 전부 취소해준다.
+ (void) badgeinit
{
    NSMutableArray *array = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"index" ascending:YES]];
    
    for (EditDay *edit in array) {
        edit.badge = [NSNumber numberWithBool:FALSE];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];// 저장
    }
}

// Badge 여부를 판단 한가지를 꺼내와 리턴 없는경우는 Nil
+ (EditDay *) mainBadge
{
    NSMutableArray *array = [NSMutableArray arrayWithArray: [EditDay MR_findAllSortedBy:@"badge" ascending:YES]];
    
    for (EditDay *edit in array) {
        if ((Boolean)edit.badge) {
            return edit;
        }
    }
    return nil;
}

// Badge에 달릴 값을 만든다.
+ (NSInteger) badge
{
    EditDay *editDay = [Entity_init mainBadge];
    if (editDay != nil) {
        NSInteger result = [Date_Calendar stringDate:editDay.date plusOne:(Boolean)editDay.plusone];
        
        if (result < 0) {
            result = result * -1;
        }
        return result;
        
    } else {
        return 0;
    }
}
@end
