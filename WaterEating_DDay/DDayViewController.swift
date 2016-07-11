//
//  DDayViewController.swift
//  WaterEating_DDay
//
//  Created by kimjiwook on 2014. 10. 21..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
// 2014년 11월 11일 기본 페이지만 오류 내역 변경

import UIKit
//import GoogleMobileAds

class DDayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var ddayTable: UITableView!
//    @IBOutlet var bannerView: GADBannerView!
    var tableData:NSMutableArray?
    var badgeImage:UIImageView?

    // MARK: initData 데이터 초기화 및 시작함수
    func initData() {
        // Table Data. (CoreData 에서 FindAll, orderBy index 를 통해서 Array 형식으로 가져옴.)
        tableData = NSMutableArray(array: EditDay.MR_findAllSortedBy("index", ascending:true))
        
        ddayTable.dataSource = self
        ddayTable.delegate = self
        ddayTable.backgroundColor = UIColor.clearColor()
        self.ddayTable.reloadData()
        
        self.navigationItem.title = "D-Day"
        // AdMob 시작.
//        self.getAdMob()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.initData()
    }
    
    // MARK: Google get AdMob
//    func getAdMob() {
//
//        self.bannerView.adUnitID = "ca-app-pub-9328601818114664/7165501839"
//        self.bannerView.rootViewController = self
//        let request:GADRequest = GADRequest()
//        request.testDevices = ["Simulator"]
//        self.bannerView.loadRequest(request)
//    }
    
    // MARK: TableView Delegate And DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.ddayTable.dequeueReusableCellWithIdentifier("CellTwo")!
     
        let viewToRemove:NSArray! = cell.contentView.subviews
        var v:UIView?
        for v in viewToRemove {
            if v.tag == 3000 {
                v.removeFromSuperview()
            }
        }
        
        let editDay:EditDay = self.tableData?.objectAtIndex(indexPath.row) as! EditDay
        
        cell.textLabel!.text = editDay.title
        cell.textLabel!.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel!.tag = 1000+indexPath.row
        cell.backgroundColor = UIColor.clearColor()
        
        let result = Date_Calendar.stringDate(editDay.date, plusOne: editDay.plusone.boolValue)
        
        cell.detailTextLabel?.text = Date_Calendar.stringResult(result)
        cell.detailTextLabel?.backgroundColor = UIColor.clearColor()
        cell.detailTextLabel?.textAlignment = NSTextAlignment.Right
        cell.detailTextLabel?.font = UIFont.systemFontOfSize(20.0)
        cell.detailTextLabel?.textColor = UIColor.blackColor()
        cell.detailTextLabel?.tag = 2000+indexPath.row
        
        if (editDay.badge.boolValue) {
            badgeImage = UIImageView(frame: CGRectMake(self.view.bounds.size.width-25, 0, 25, 25))
            let image:UIImage = UIImage(named: "noti.png")!
            badgeImage?.image = image
            badgeImage?.tag = 3000
            cell.contentView.addSubview(badgeImage!)
        }
        return cell
    }
    
// Table view delegate
    
    // Table view Cell Select Action
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)

        // Object-c 코드
//        let editDay:EditDay = self.tableData?.objectAtIndex(indexPath.row) as! EditDay
//        let storyboard:UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
//        let detailViewController:DetailViewController = storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
//        detailViewController.setting(editDay)
//        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        // Swift 변경
        let editDay:EditDay = self.tableData?.objectAtIndex(indexPath.row) as! EditDay
        let storyboard:UIStoryboard = UIStoryboard(name: "DDay_Detail_Storyboard", bundle: nil)
        let dday_Detail_ViewController:DDay_Detail_ViewController = storyboard.instantiateViewControllerWithIdentifier("DDay_Detail_ViewController") as! DDay_Detail_ViewController
        dday_Detail_ViewController.setting(editDay)
        self.navigationController?.pushViewController(dday_Detail_ViewController, animated: true);
    }
    
    // Table view edit Cell move Action
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let fromRow = sourceIndexPath.row
        let toRow = destinationIndexPath.row
        
        let object:NSObject = self.tableData?.objectAtIndex(fromRow) as! NSObject
        
        self.tableData?.removeObjectAtIndex(fromRow)
        self.tableData?.insertObject(object, atIndex: toRow)
        
        for (var i = 0; i < self.tableData?.count; i++){
            let editDay:EditDay = self.tableData?.objectAtIndex(i) as! EditDay
            editDay.index = NSNumber(integer: i * 10)
        }
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    // Table view editing..
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // CoreData row Delete...
            let editDay:EditDay = self.tableData?.objectAtIndex(indexPath.row) as! EditDay
            editDay.MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            
            // TableView Cell Delete...
            self.tableData?.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Left)
            
            UIApplication.sharedApplication().applicationIconBadgeNumber = Entity_init.badge()
        }
    }
    
    // Table Delete Button Rename...
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "삭제"
    }

    // Table view edit mode
    @IBAction func editButtonAction(sender: AnyObject) {
        ddayTable.setEditing(!ddayTable.editing, animated: true)
        if ddayTable.editing {
            self.navigationItem.leftBarButtonItem?.title = "완료"
            self.navigationItem.rightBarButtonItem?.enabled = false
            badgeImage?.frame = CGRectMake(self.view.bounds.size.width-25-38, 0, 25, 25)
        } else {
            self.navigationItem.leftBarButtonItem?.title = "편집"
            self.navigationItem.rightBarButtonItem?.enabled = true
            badgeImage?.frame = CGRectMake(self.view.bounds.size.width-25, 0, 25, 25)
        }
    }
    
    // Table view add mode
    @IBAction func addButtonAction(sender: AnyObject) {
        let storyboard:UIStoryboard = UIStoryboard(name: "AddEdit", bundle: nil)
        let addEditViewController:AddEditViewController = storyboard.instantiateViewControllerWithIdentifier("AddEditViewController") as! AddEditViewController
        addEditViewController.setting(nil)
        self.navigationController?.pushViewController(addEditViewController, animated: true)
        
        // 아래 Swift 작성된 페이지에서 오류 발견 급하게 업로드를 위하여
        // 첫 페이지만 작성후 진행
        
//        let storyboard:UIStoryboard = UIStoryboard(name: "AddEditing", bundle: nil)
//        let addEditingViewController:AddEditingViewContoller = storyboard.instantiateViewControllerWithIdentifier("AddEditingViewContoller") as AddEditingViewContoller
//        addEditingViewController.setting(nil)
//        self.navigationController?.pushViewController(addEditingViewController, animated: true)
    }
}