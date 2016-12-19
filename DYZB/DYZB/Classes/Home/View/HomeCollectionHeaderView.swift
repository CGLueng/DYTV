//
//  HomeCollectionHeaderView.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/13.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class HomeCollectionHeaderView: UICollectionReusableView {
    
    // MARK:- 控件属性
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLB.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
