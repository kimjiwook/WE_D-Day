//
//  DDayViewController.swift
//  WaterEating_DDay
//
//  Created by kimjiwook on 2014. 10. 21..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation

class DDayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var ddayTable: UITableView!
    var tableData:NSMutableArray?
    var badgeImage:UIImageView?
    var adView:MobileAdView!
    
    override func viewDidLoad() {
        ddayTable.dataSource = self
        ddayTable.delegate = self
        ddayTable.backgroundColor = UIColor.clearColor()
        
        self.navigationItem.title = "D-Day"
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
// TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.ddayTable.dequeueReusableCellWithIdentifier("CellTwo") as UITableViewCell
        
        cell.textLabel.text = "\(indexPath.row) 샘플작업진행중"
        cell.detailTextLabel?.text = "디테일 텍스트"
        
        return cell

    }
    
    
}