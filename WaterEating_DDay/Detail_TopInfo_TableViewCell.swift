//
//  Detail_TopInfo_TableViewCell.swift
//  WaterEating_DDay
//
//  Created by kimjiwook on 2015. 10. 3..
//  Copyright © 2015년 KimJiWook. All rights reserved.
//
//  Detail TableView Top 정보.
//  날짜, 디데이 정보, 설정 이미지, 알림 이미지가 들어 있습니다.

import UIKit

class Detail_TopInfo_TableViewCell: UITableViewCell {

    // 1. 좌측 상단 해당 날짜
    @IBOutlet var lb_startDate: UILabel!
    // 2. 가운데 우측 큰 글씨 DDay 일자 표시
    @IBOutlet var lb_ddayCount: UILabel!
    // 3. 우측 상단 알림 표시이미지 (앱 중에 한가지만 표시)
    // Default : Hidden
    @IBOutlet var img_noties: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func layoutSubviews() {
//        img_noties.hidden = true   
//    }

}
