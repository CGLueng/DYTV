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
    var cycleTimer : Timer?
    var cycleModelArr : [CycleModel]? {
        didSet {
            //刷新 collectionview
            collectionView.reloadData()
            //设置 pagecontrol 个数
            pageControl.numberOfPages = cycleModelArr?.count ?? 0
            //默认滚动到中间某一个位置
            let indexPath = NSIndexPath(item: (cycleModelArr?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //添加定时器
            removeTimer()
            addCycleTimer()
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
        return (cycleModelArr?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //拿出数据
        let cycleModel = cycleModelArr![indexPath.item % cycleModelArr!.count]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModel
        
        return cell
    }
}

// MARK:- 遵守 UIcollectionview 代理
extension CommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //计算 pagecontrol的 currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModelArr?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //用户滑动时候移除定时器
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //用户停止滑动时候添加定时器
        addCycleTimer()
    }
}

// MARK:- 对定时器的操作方法
extension CommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        //添加到运行循环中
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeTimer() {
        //从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        //计算偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        //滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
