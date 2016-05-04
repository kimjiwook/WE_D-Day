//
//  DDay_Detail_ViewController.swift
//  WaterEating_DDay
//
//  Created by kimjiwook on 2015. 9. 30..
//  Copyright © 2015년 KimJiWook. All rights reserved.
//
///////////////////////////////////////////////////////////////////////////////
//
// # iOS 9 업데이트 이후 글씨 포인트 변경으로 인하여. 오토레이아웃 변경할 겸 새로 작성.
// RNGridMenu 를 사용하여 ( D+ 별, D- 별, Year 별) 로 구분하는 메뉴가 생긴다.

import UIKit

class DDay_Detail_ViewController: UIViewController
, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, RNGridMenuDelegate
{

    @IBOutlet var tb_detailTableVIew: UITableView!
    // 테이블뷰의 타입(D+, D-, Year)
    var tableViewType:NSInteger = 0
    //  테이블뷰 Row 의 길이를 늘려주기위한 변수.
    var totalRowCount:NSInteger = 30
    var editDay:EditDay?
    
    //MARK: 초기 값을 전달 받기위한 함수.
    func setting(editDayCopy:EditDay) {
        editDay = editDayCopy
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("샘플값 찍어보기 \(editDay!.title), \(editDay!.badge.boolValue)")
        // Do any additional setup after loading the view.
    
        self.navigationItem.title = editDay!.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItem?.title = "뱃지알림"
        self.navigationItem.rightBarButtonItem?.action = Selector("badgeSetting")
        self.navigationItem.rightBarButtonItem?.target = self
        
        tb_detailTableVIew.dataSource = self
        tb_detailTableVIew.delegate = self
        self.createRNGridMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 뱃지를 등록하기 위한 함수.
    func badgeSetting() {
        let btnTitle:NSArray = ["\(BTN_OK)", "\(BTN_CANCEL)"]
        if(editDay!.badge.boolValue) {
            AlertViewCreate.alertTitle(TITLE_NOTI, message: MSG_NOTI_CANCEL, create: btnTitle as [AnyObject], set: self)
        } else {
            AlertViewCreate.alertTitle(TITLE_NOTI, message: MSG_NOTI_OK, create: btnTitle as [AnyObject], set: self)
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == 0) {
            if(MSG_NOTI_OK == alertView.message) {
                Entity_init.badgeinit()
                editDay!.badge = NSNumber(bool: true)
                
                // 저장
                NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                UIApplication.sharedApplication().applicationIconBadgeNumber = Entity_init.badge()
                
            } else if (MSG_NOTI_CANCEL == alertView.message) {
                Entity_init.badgeinit()
                UIApplication.sharedApplication().applicationIconBadgeNumber = Entity_init.badge()
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: 왼쪽 하단 GridMenu
    func createRNGridMenu() {
        let gridMenu:UIButton = UIButton(frame: CGRectMake(10, self.view.bounds.size.height-10-55, 55, 55))
        gridMenu.setImage(UIImage(named: "menu.png"), forState: UIControlState.Normal)
        gridMenu.addTarget(self, action: Selector("actionRNGridMenu"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(gridMenu)
    }
    
    func actionRNGridMenu() {
        let numberOfOptions:NSInteger = 3
        let options:NSArray = ["D+Day", "D-Day","Year"]
        let gMenu:RNGridMenu = RNGridMenu(titles: options .subarrayWithRange(NSMakeRange(0, numberOfOptions)))
        gMenu.delegate = self
        gMenu.itemFont = UIFont.boldSystemFontOfSize(18)
        gMenu.itemSize = CGSizeMake(150, 55)
        gMenu.showInViewController(self, center: CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2))
    }
    
    // MARK: GridMenu Delegate 값을 전달받음.
    func gridMenu(gridMenu: RNGridMenu!, willDismissWithSelectedItem item: RNGridMenuItem!, atIndex itemIndex: Int) {
        tableViewType = itemIndex
        tb_detailTableVIew.reloadData()
    }
    
    // MARK: TableView DataSource 들...
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableViewType <= 2) {
            return totalRowCount
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 175
        }
        return 50
    }
    /**
     * CellForRowAtIndexPath
     * 직접 셀을 그려주는 부분.
     * 현재 두가지의 Cell 타입으로 나뉘어 져있음.
     * 1. Top Cell 상단 정보의
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 지난 날에 회색처리 하기 위해 result 를 if 밖으로 제외 (공용 비교대상임.)
        let result:NSInteger = Date_Calendar.stringDate(editDay!.date, plusOne: editDay!.plusone.boolValue)
        if (indexPath.row == 0) {
            // 상단정보를 만들어주는 셀
            let cell:Detail_TopInfo_TableViewCell = tableView.dequeueReusableCellWithIdentifier("Detail_TopInfo_TableViewCell") as! Detail_TopInfo_TableViewCell
            cell.lb_startDate.text = editDay!.date
            cell.lb_ddayCount.text = Date_Calendar.stringResult(result)
            if(editDay!.badge.boolValue) {
                cell.img_noties.hidden = false
            }
            return cell
        } else {
            // 하단 일자별 정보 셀
            let cell:Detail_RowInfo_TableViewCell = tableView.dequeueReusableCellWithIdentifier("Detail_RowInfo_TableViewCell") as! Detail_RowInfo_TableViewCell
            // 디폴트 컬러.
            cell.lb_leftInfo.textColor = UIColor.blackColor()
            cell.lb_rightYYMMDD.textColor = UIColor.blackColor()
            
            if(tableViewType == 0) {
                // D+ 일자에 대한 정보.
                cell.lb_leftInfo.text = "\(indexPath.row*100) 일"
                cell.lb_rightYYMMDD.text = Date_Calendar.stringDate(editDay!.date, howdays: indexPath.row*100)
                
                if (result > indexPath.row*100) {
                    cell.lb_leftInfo.textColor = UIColor.grayColor()
                    cell.lb_rightYYMMDD.textColor = UIColor.grayColor()
                }
                
            } else if (tableViewType == 1) {
                // D- 일자에 대한 정보.
                var d_minus:NSInteger = Date_Calendar.stringDate(editDay!.date, plusOne:editDay!.plusone.boolValue)
                d_minus = (d_minus)/100
                
                cell.lb_leftInfo.text = "D\((d_minus*100)+(indexPath.row-1)*100) 일"
                cell.lb_rightYYMMDD.text = Date_Calendar.stringDate(editDay!.date, howdays: (d_minus*100)+(indexPath.row-1)*100)
                
            } else if (tableViewType == 2) {
                // Year 일자에 대한 정보.
                let yearDate:NSInteger =
                Date_Calendar.startDate(Date_Conversion.stringToDate(editDay!.date),
                    endDate: Date_Calendar.date(editDay!.date, addYear:Int32(indexPath.row)),
                    plusOne: editDay!.plusone.boolValue)
                
                cell.lb_leftInfo.text = "\(indexPath.row) 주년(\(yearDate)일)"
                cell.lb_rightYYMMDD.text = Date_Conversion.dateToString(Date_Calendar.date(editDay!.date, addYear: Int32(indexPath.row)))
                
                if (result > yearDate) {
                    cell.lb_leftInfo.textColor = UIColor.grayColor()
                    cell.lb_rightYYMMDD.textColor = UIColor.grayColor()
                }
                
            }
            return cell
        }
    }

    
    // 임시 TEST
    /**
     * WillDisPlayCell
     * 셀을 새로 그릴때 전체 카운트를 증가시켜 Cell 정보의 갯수를 늘려준다.
     */
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (totalRowCount == indexPath.row+1) {
            // 페이지 10개씩 추가해 주기
            totalRowCount += 20
            self.tb_detailTableVIew.reloadData()
        }
    }
    
    /**
     * DidSelectRowAtIndexPath
     * 첫번째 셀(Top 정보 셀) 을 선택시에
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (indexPath.row == 0) {
            let storyboard:UIStoryboard = UIStoryboard(name: "AddEdit", bundle: nil)
            let addEditViewController:AddEditViewController = storyboard.instantiateViewControllerWithIdentifier("AddEditViewController") as! AddEditViewController
            addEditViewController.setting(editDay!)
            self.navigationController?.pushViewController(addEditViewController, animated: true)
        }
    }
}
