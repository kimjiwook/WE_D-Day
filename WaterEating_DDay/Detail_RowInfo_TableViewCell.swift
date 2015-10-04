//
//  Detail_RowInfo_TableViewCell.swift
//  WaterEating_DDay
//
//  Created by kimjiwook on 2015. 10. 3..
//  Copyright © 2015년 KimJiWook. All rights reserved.
//
//  DetailView Row 정보.
//  가운데의 View 를 기점으로 반절을 나눠놓은 상태.
//  글씨 길이의 변경에 따라 글씨 Scal 적용 0.5 까지 적용 됨.

import UIKit

class Detail_RowInfo_TableViewCell: UITableViewCell {

    @IBOutlet var lb_leftInfo: UILabel!
    @IBOutlet var lb_rightYYMMDD: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
