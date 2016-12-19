//
//  HomeViewController.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/12.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStateBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titileView = PageTitleView(frame: titleFrame, titles: titles)
        titileView.delegate = self
        return titileView
    }()
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        //frame
        let contentHeight = kScreenH - (kStateBarH + kNavigationBarH + kTitleViewH + kTabbarH)
        let contentFrame = CGRect(x: 0, y: kStateBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentHeight)
        //子控制器
        var childVCs = [UIViewController]()
        childVCs.append(CommendViewController())
        childVCs.append(GameViewController())
        for _ in 0..<2 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), alpha: 1.0)
            childVCs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentVC: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置 UI 界面
        setupUI()
    }
}
// MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        //不需要调整 scrollView 内边距
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        //添加titleview
        view.addSubview(pageTitleView)
        //添加 contentview
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    private func setupNavigationBar() {
        //设置左侧 item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //设置右侧 item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightlightImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightlightImage: "btn_search_clicked", size: size)
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", hightlightImage: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrCodeItem]
    }
}

// MARK:- 遵守PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK:- 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWtihProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
