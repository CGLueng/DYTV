//
//  GameViewController.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/19.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2*kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kGameCellID = "kGameCellID"

class GameViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //注册 cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK:- 设置 UI 界面
extension GameViewController {
    fileprivate func setupUI() {
        //添加 collectionview
        view.addSubview(collectionView)
    }
}

// MARK:- 遵守 UIcollectionview 数据源
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}
