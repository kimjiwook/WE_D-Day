//
//  EditDay.h
//  WaterEating_DDay
//
//  Created by JWMAC on 2013. 11. 29..
//  Copyright (c) 2013년 KimJiWook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EditDay : NSManagedObject

@property (nonatomic, retain) NSNumber * badge;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * startdate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * index;

@end
