//
//  AlertViewCreate.m
//  MPWCA
//
//  Created by Kim J.W on 13. 1. 10..
//  Copyright (c) 2013년 Kim Ji Wook. All rights reserved.
//

#import "AlertViewCreate.h"

@implementation AlertViewCreate

#pragma mark - alertViewCreateset (AlertView 생성)
// 기능 : AlertView를 생성하여 띄워준다.
// 인자 : 타이틀, 메시지, 버튼이름, delegate를 받는다.
// 리턴 : none
+ (void) alertTitle : (NSString*)title Message:(NSString*)message Create:(NSArray*)othertitle set:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    
    for (NSString *title in othertitle) {
        [alert addButtonWithTitle: title];
    }

    NSLog(@"alertView 호출");
    [self performSelectorOnMainThread:@selector(alertViewShow:) withObject:alert waitUntilDone:YES];
}

#pragma mark - alertViewShow (AlertView 뿌리기)
// 기능 : AlertView Show를 별도로 뺀 이유는 메인쓰레드에서 사용 되어야하기때문에 별도로 뺏다
+ (void) alertViewShow : (UIAlertView *)alert
{
    [alert show];
}

@end
