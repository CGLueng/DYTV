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
    var baseGame : BasicGameModel? {
        didSet {
            titileLB.text = baseGame?.tag_name
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            }else {
                iconImageView.image = UIImage(named: "btn_v_more")
            }
        }
    }
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
