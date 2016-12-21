//
//  CommendGameView.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/17.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class CommendGameView: UIView {
    
    // MARK:- 定义数据属性
    var groups : [BasicGameModel]? {
        didSet {
            //刷新
            self.collectionView.reloadData()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // FIXME:- 两者顺序调转,则显示不出 view 了
        autoresizingMask = .flexibleHeight
        autoresizingMask = .flexibleWidth
        
        //注册 cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

// MARK:- 快速创建类方法
extension CommendGameView {
    class func commendGameView() -> CommendGameView {
        return Bundle.main.loadNibNamed("CommendGameView", owner: self, options: nil)?.first as! CommendGameView
    }
}

// MARK:- 遵守 UIcollectionView 数据源
extension CommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![indexPath.item]
        
        return cell
    }
}
