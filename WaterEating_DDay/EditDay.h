//
//  EditDay.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 12. 16..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EditDay : NSManagedObject

@property (nonatomic) BOOL badge;
@property (nonatomic, retain) NSString * date;
@property (nonatomic) int64_t index;
@property (nonatomic) BOOL plusone;
@property (nonatomic, retain) NSString * title;

@end
