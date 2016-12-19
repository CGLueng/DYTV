//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/19.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
 
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titileLB: UILabel!
    
    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titileLB.text = group?.tag_name
            let iconURL = URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "btn_v_more"))
        }
    }
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
