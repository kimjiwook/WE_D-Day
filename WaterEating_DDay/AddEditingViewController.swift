//
//  AddEditingViewController.swift
//  WaterEating_DDay
//
//  Created by kimjiwook on 2014. 10. 29..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//
// 2014년 11월 11일 오류 내용 확인 결과
// iOS 7 에서 네비게이션 부분 오류
// iOS 8 에서 textfield 오류
// test 주석.
import Foundation
import UIKit

class AddEditingViewContoller : UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var editDay:EditDay?
    
    @IBOutlet var addEditTable:UITableView!
    @IBOutlet var datePicker:UIDatePicker!
    @IBOutlet var dayLabel:UILabel!
    @IBOutlet var onDayCheckSwithch:UISwitch!
    @IBOutlet var subJectTextField:UITextField!
    
    func setting(editDayCopy:EditDay?) {
        self.navigationItem.title = "D-Day 추가"
        if (editDayCopy != nil) {
            editDay = editDayCopy
            self.navigationItem.title = "D-Day 수정"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: UIBarButtonItemStyle.Done, target: self, action: "daySave")
        
        addEditTable = UITableView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height), style: UITableViewStyle.Grouped)
        addEditTable.dataSource = self
        addEditTable.delegate = self
        
        addEditTable.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(addEditTable)
    }
    
    @IBAction func daySave() {
        // 값이 없거나, 공백만 있는 경우도 체크한다.
        var length = count(subJectTextField.text)
        // 길이가 0 이거나 문자열 공백인 경우
        if (length == 0 || subJectTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "") {
            var btnTitle:NSArray? = NSArray(objects: BTN_OK)
//            AlertViewCreate.alertTitle(TITLE_NOTI, message: MSG_NOTI_WARNING, create: btnTitle, set: self)
            var alert:UIAlertView! = UIAlertView(title: TITLE_NOTI, message: MSG_NOTI_WARNING, delegate: self, cancelButtonTitle: BTN_OK)
        } else {
            var dateSelected:NSDate? = self.datePicker.date
            var calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
            var interval: NSTimeInterval = 0
            // 정확한 날 수를 계산하기 위해 날짜정보에서 시간정보를 0시 0분 0초로 설정
            // Extra argument 'interval' in call
            
            calendar.rangeOfUnit(NSCalendarUnit.DayCalendarUnit, startDate: &dateSelected, interval: &interval, forDate: dateSelected!)
            
            if editDay == nil {
                editDay = EditDay.MR_createEntity() as? EditDay
                editDay?.index = NSNumber(integer: EditDay.MR_findAll().count * 10)
                editDay?.badge = NSNumber(bool: false) // 생성당시는 없음
            }
            
            editDay?.date = Date_Conversion.dateToString(dateSelected)
            editDay?.title = subJectTextField.text
            editDay?.plusone = NSNumber(bool: onDayCheckSwithch.on)
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
//    Table View Data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                return 175
            }
        }
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            dayLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, 30))
            dayLabel.text = "D+0 일"
            if editDay != nil {
                var result = Date_Calendar.stringDate(Date_Conversion.dateToString(self.datePicker.date), plusOne: onDayCheckSwithch.on)
                dayLabel.text = Date_Calendar.stringResult(result)
            }
            dayLabel.font = UIFont.systemFontOfSize(20)
            dayLabel.textAlignment = NSTextAlignment.Center
            
            return dayLabel
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell

        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        if indexPath.section == 0 {
            var subJectLabel:UILabel! = UILabel(frame: CGRectMake(10, 5, 50, 40))
            subJectLabel.font = UIFont.systemFontOfSize(18)
            subJectLabel.textAlignment = NSTextAlignment.Left
            subJectLabel.text = "제목"
            cell?.contentView.addSubview(subJectLabel)
            
            subJectTextField = UITextField(frame: CGRectMake(70, 5, self.view.bounds.size.width-70, 40))
            subJectTextField.delegate = self
            subJectTextField.font = UIFont.systemFontOfSize(18)
            subJectTextField.placeholder = "제목을 넣어주세요."
            
            if editDay != nil {
                subJectTextField.text = editDay?.title
            }
            cell?.contentView.addSubview(subJectTextField)
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                var startCheckLabel:UILabel = UILabel(frame: CGRectMake(10, 5, 200, 40))
                startCheckLabel.font = UIFont.systemFontOfSize(18)
                startCheckLabel.textAlignment = NSTextAlignment.Left
                startCheckLabel.text = "시작일로부터 1일"
                cell?.contentView.addSubview(startCheckLabel)
                
                onDayCheckSwithch = UISwitch(frame: CGRectMake(self.view.bounds.size.width-49-20, 9, 49, 31))
                onDayCheckSwithch.on = false
                onDayCheckSwithch.addTarget(self, action: "onDayCheckAction", forControlEvents: UIControlEvents.ValueChanged)
                if editDay != nil {
                    onDayCheckSwithch.on = editDay!.plusone.boolValue
                }
                cell?.contentView.addSubview(onDayCheckSwithch)
                
            } else if indexPath.row == 1 {
                datePicker = UIDatePicker(frame: CGRectMake(0, 0, self.view.bounds.width, 162))
                datePicker.datePickerMode = UIDatePickerMode.Date
                datePicker.locale = NSLocale(localeIdentifier: "Korean")
                datePicker.addTarget(self, action: "dateChanged", forControlEvents: UIControlEvents.ValueChanged)
                if editDay != nil {
                    datePicker.date = Date_Conversion.stringToDate(editDay?.date)
                }
                cell?.contentView.addSubview(datePicker)
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dateChanged() {
        var result = Date_Calendar.stringDate(Date_Conversion.dateToString(self.datePicker.date), plusOne: onDayCheckSwithch.on)
        self.dayLabel.text = Date_Calendar.stringResult(result)
    }
    
    @IBAction func onDayCheckAction() {
        self.dateChanged()
    }
}