//
//  CommendViewController.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/13.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

// MARK:- 定义常量
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

// MARK:- 定义类
class CommendViewController: BasicAnchorViewController {
    
    // MARK:- 设置属性
    
    // MARK:- 懒加载属性
    fileprivate lazy var commendViewModel : CommendViewModel = CommendViewModel()
    
    fileprivate lazy var cycleView : CommendCycleView = {
        let cycleView = CommendCycleView.commendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView : CommendGameView = {
        let gameView = CommendGameView.commendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK:- 设置 UI
extension CommendViewController {
    override func setupUI() {
        //先调用 super.setupUI
        super.setupUI()
        //添加 cycleview
        collectionView.addSubview(cycleView)
        //添加 gameView
        collectionView.addSubview(gameView)
        //设置 collectionview 的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH +
             kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension CommendViewController {
    override func loadData() {
        //给父类中的 viewmodel 进行赋值
        basicVM = commendViewModel
        //请求推荐数据
        commendViewModel.requestData { 
            self.collectionView.reloadData()
            //将数据传递给 gameView
            var groups = self.commendViewModel.anchorGroups
            //移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            //添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)

            self.gameView.groups = groups
        }
        //请求轮播图数据
        commendViewModel.requestCycleData { 
            self.cycleView.cycleModelArr = self.commendViewModel.cycleModelArr
        }
    }
}

// MARK:- 重写父类方法
extension CommendViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = commendViewModel.anchorGroups[indexPath.section].anchorArr[indexPath.item]
            return prettyCell
        }else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}

// MARK:- 遵守UICollectionViewDelegateFlowLayout
extension CommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
