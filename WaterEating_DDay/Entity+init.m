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
@end
