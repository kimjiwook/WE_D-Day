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

@property (nonatomic, retain) NSNumber * badge;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * plusone;
@property (nonatomic, retain) NSString * title;

@end
