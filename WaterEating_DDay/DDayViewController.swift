//
//  DDayViewController.swift
//  WaterEating_DDay
//
//  Created by kimjiwook on 2014. 10. 21..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation

class DDayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MobileAdViewDelegate {
    
    @IBOutlet var ddayTable: UITableView!
    var tableData:NSMutableArray?
    var badgeImage:UIImageView?
    var adView:MobileAdView!
    
    override func viewDidLoad() {
        
        tableData = NSMutableArray(array: EditDay.MR_findAllSortedBy("index", ascending:true))
        
        ddayTable.dataSource = self
        ddayTable.delegate = self
        ddayTable.backgroundColor = UIColor.clearColor()
        
        self.navigationItem.title = "D-Day"
        
        self.createAdpost()
    }
    
    func createAdpost() {
        adView = MobileAdView.sharedMobileAdView()
        adView.frame = CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)
        adView.superViewController = self
        adView.channelId = "mios_609d1408867643cbb33f3ccc006dfacd"
        adView.isTest = false
        
        adView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin
        | UIViewAutoresizing.FlexibleLeftMargin
        | UIViewAutoresizing.FlexibleWidth
        
        adView.delegate = self
        adView.start()
        
        self.view.addSubview(adView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDidLoad()
        self.ddayTable.reloadData()
        adView.start()
    }
    
    override func viewWillDisappear(animated: Bool) {
        adView.stop()
    }
    
// TableView
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
        var cell:UITableViewCell = self.ddayTable.dequeueReusableCellWithIdentifier("CellTwo") as UITableViewCell
     
        var viewToRemove:NSArray! = cell.contentView.subviews
        var v:UIView?
        for v in viewToRemove {
            if v.tag == 3000 {
                v.removeFromSuperview()
            }
        }
        
        var editDay:EditDay = self.tableData?.objectAtIndex(indexPath.row) as EditDay
        
        cell.textLabel.text = editDay.title
        cell.textLabel.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel.tag = 1000+indexPath.row
        cell.backgroundColor = UIColor.clearColor()
        
        var result = Date_Calendar.stringDate(editDay.date, plusOne: editDay.plusone.boolValue)
        
        cell.detailTextLabel?.text = Date_Calendar.stringResult(result)
        cell.detailTextLabel?.backgroundColor = UIColor.clearColor()
        cell.detailTextLabel?.textAlignment = NSTextAlignment.Right
        cell.detailTextLabel?.font = UIFont.systemFontOfSize(20.0)
        cell.detailTextLabel?.textColor = UIColor.blackColor()
        cell.detailTextLabel?.tag = 2000+indexPath.row
        
        if (editDay.badge.boolValue) {
            badgeImage = UIImageView(frame: CGRectMake(self.view.bounds.size.width-25, 0, 25, 25))
            var image:UIImage = UIImage(named: "noti.png")!
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
        
        var editDay:EditDay = self.tableData?.objectAtIndex(indexPath.row) as EditDay
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailViewController:DetailViewController = storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as DetailViewController
        
        detailViewController.setting(editDay)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // Table view edit Cell move Action
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        var fromRow = sourceIndexPath.row
        var toRow = destinationIndexPath.row
        
        var object:NSObject = self.tableData?.objectAtIndex(fromRow) as NSObject
        
        self.tableData?.removeObjectAtIndex(fromRow)
        self.tableData?.insertObject(object, atIndex: toRow)
        
        for (var i = 0; i < self.tableData?.count; i++){
            var editDay:EditDay = self.tableData?.objectAtIndex(i) as EditDay
            editDay.index = NSNumber(integer: i * 10)
        }
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    // Table view editing..
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // CoreData row Delete...
            var editDay:EditDay = self.tableData?.objectAtIndex(indexPath.row) as EditDay
            editDay.MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            
            // TableView Cell Delete...
            self.tableData?.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath), withRowAnimation: UITableViewRowAnimation.Left)
            
            UIApplication.sharedApplication().applicationIconBadgeNumber = Entity_init.badge()
        }
    }
    
    // Table Delete Button Rename...
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
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
        let addEditViewController:AddEditViewController = storyboard.instantiateViewControllerWithIdentifier("AddEditViewController") as AddEditViewController
        addEditViewController.setting(nil)
        self.navigationController?.pushViewController(addEditViewController, animated: true)
    }
}