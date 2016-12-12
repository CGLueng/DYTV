//
//  PageTitleView.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/12.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    // MARK:- 定义属性
    fileprivate var titles : [String]
    
    // MARK:- 懒加载属性
    fileprivate lazy var titlaLabelArr : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView  = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置 UI 界面
        setupUI()
    }
    //重写 init 构造函数必须实现下面这个构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置 UI 界面
extension PageTitleView {
    fileprivate func setupUI() {
        //添加 scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加对应的 label
        setupTitleLabel()
        //设置底部滚条与滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupTitleLabel() {
        for (index, item) in titles.enumerated() {
            //确定一些 frame 值(提高效率)
            let lbW : CGFloat = frame.width / CGFloat(titles.count)
            let lbH : CGFloat = frame.height - kScrollLineH
            let lbY : CGFloat = 0
            
            //创建 label, 设置属性
            let label = UILabel()
            label.text = item
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //设置 frame
            let lbX : CGFloat = lbW * CGFloat(index)
            label.frame = CGRect(x: lbX, y: lbY, width: lbW, height: lbH)
            
            scrollView.addSubview(label)
            titlaLabelArr.append(label)
        }
    }
    
    private func setupBottomMenuAndScrollLine() {
        //创建底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollline
        guard let firstLabel = titlaLabelArr.first else {return}
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}
