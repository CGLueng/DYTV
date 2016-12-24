
//
//  BasicAnchorViewController.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/24.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) * 0.5
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kheaderH : CGFloat = 50
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class BasicAnchorViewController: UIViewController {

    // MARK:- 定义属性
    var basicVM : BasicViewModel!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kheaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //创建collectionview
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //宽高随着父控件拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //注册 cell
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //注册组头
        //        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()

    }
}

// MARK:- 设置 UI
extension BasicAnchorViewController {
    func setupUI() {
        view.addSubview(collectionView)
    }
}

// MARK:- 请求数据
extension BasicAnchorViewController {
    func loadData() {
        
    }
}

// MARK:- 遵守 UIcollectionview 的数据源
extension BasicAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return basicVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basicVM.anchorGroups[section].anchorArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        //设置数据
        cell.anchor = basicVM.anchorGroups[indexPath.section].anchorArr[indexPath.item]
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! HomeCollectionHeaderView
        
        headView.group = basicVM.anchorGroups[indexPath.section]
        
        return headView
    }
}

// MARK:- 遵守 UIcollectionview 的代理
extension BasicAnchorViewController : UICollectionViewDelegate {
    
}
