//
//  CommendCycleView.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/16.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class CommendCycleView: UIView {
    
    // MARK:- 定义属性
    var cycleModelArr : [CycleModel]? {
        didSet {
            //刷新 collectionview
            collectionView.reloadData()
            //设置 pagecontrol 个数
            pageControl.numberOfPages = cycleModelArr?.count ?? 0
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件随着父控件拉伸而拉伸
        autoresizingMask = .flexibleHeight
        autoresizingMask = .flexibleWidth
        
        //注册 cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置 collectionview 的 layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }

}

// MARK:- 提供一个快速创建 view 的类方法
extension CommendCycleView {
    class func commendCycleView() -> CommendCycleView {
        return Bundle.main.loadNibNamed("CommendCycleView", owner: nil, options: nil)?.first as! CommendCycleView
    }
}

// MARK:- 遵守 UIcollectionview 数据源
extension CommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModelArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //拿出数据
        let cycleModel = cycleModelArr![indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModel
        
        return cell
    }
}
