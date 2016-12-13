//
//  PageContentView.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/12.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let contenCellID = "contenCellID"

class PageContentView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var parentVC : UIViewController?//防止循环引用,改用可选型
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建collectionview
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contenCellID)
        return collectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        //设置 UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置 UI 界面
extension PageContentView {
    fileprivate func setupUI() {
        //将子控制器添加到父控制器中
        for childVC in childVCs {
            parentVC?.addChildViewController(childVC)
        }
        //添加 uicollecionview
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- 遵守 UIcollectionview datasource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contenCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK:- 遵守 UIcollectionviewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        //定义所需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //判断左滑还右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX {//左滑,floor():是一个取整函数,能取出一个数的整数部分
            //计算 progress
            progress = currentOffsetX  / scrollViewW - floor(currentOffsetX  / scrollViewW)
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX  / scrollViewW)
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {//右滑
            //计算 progress
            progress = 1 - (currentOffsetX  / scrollViewW - floor(currentOffsetX  / scrollViewW))
            //计算targetIndex
            targetIndex = Int(currentOffsetX  / scrollViewW)
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            //如果完全划过去
            if startOffsetX - currentOffsetX == scrollViewW {
                progress = 1
                sourceIndex = targetIndex
            }
        }
        //将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        //记录禁止执行代理方法
        isForbidScrollDelegate = true
        //滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
