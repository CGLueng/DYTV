//
//  CollectionViewBasicCell.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/16.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewBasicCell: UICollectionViewCell {
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLB: UILabel!
    
    // MARK:- 定义模型
    var anchor : AnchorModel? {
        didSet {
            //校验模型是否有值
            guard let anchor = anchor else {return}
            //在线人数
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                let num  = Double(anchor.online) / 10000
                onlineStr = "\(num.roundTo(places: 1))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //昵称
            nickNameLB.text = anchor.nickname
            //设置图片
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
