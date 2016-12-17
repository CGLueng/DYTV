//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/16.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    
    // MARK:- 控件属性
    @IBOutlet weak var icomImageView: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    
    
    // MARK:- 定义属性
    var cycleModel : CycleModel? {
        didSet {
            titleLB.text = cycleModel?.titile
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            icomImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
