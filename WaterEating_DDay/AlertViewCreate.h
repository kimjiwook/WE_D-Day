//
//  AlertViewCreate.h
//  MPWCA
//
//  Created by Kim J.W on 13. 1. 10..
//  Copyright (c) 2013년 Kim Ji Wook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertViewCreate : NSObject
+ (void) alertTitle : (NSString*)title Message:(NSString*)message Create:(NSArray*)othertitle set:(id)delegate;
// AlertView를 하나의 클래스에서 만듬

@end
