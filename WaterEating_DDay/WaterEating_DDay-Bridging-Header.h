//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

// Utils
#import "AlertViewCreate.h"
#import "Date+Calendar.h"
#import "Date+Conversion.h"
#import "Entity+init.h"

// AppDelegate
#import "WE_DDayAppDelegate.h"

// Entities
#import "EditDay.h"

// Lib
#import "CoreData+MagicalRecord.h"
#import "RNGridMenu.h"

// Views
#import "AddEditViewController.h"

// Text...
#define TITLE_NOTI                      @"알림"

#define BTN_OK                          @"확인"
#define BTN_CANCEL                      @"취소"

#define MSG_NOTI_OK                     @"현재 일정을 뱃지 '등록'하시겠습니까?\r\n(뱃지는 한개만 등록할 수 있습니다.)"

#define MSG_NOTI_CANCEL                 @"현재 일정을 뱃지 '해제'하시겠습니까?\r\n"

#define MSG_NOTI_WARNING                @"제목을 넣어주세요."