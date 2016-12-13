//
//  PageTitleView.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/12.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol PageTitleViewDelegate : class {//class修饰符协议表示只能被类遵守
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK:- 定义类
class PageTitleView: UIView {
    // MARK:- 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate: PageTitleViewDelegate?
    
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1)
            label.textAlignment = .center
            
            //设置 frame
            let lbX : CGFloat = lbW * CGFloat(index)
            label.frame = CGRect(x: lbX, y: lbY, width: lbW, height: lbH)
            
            //添加到界面上
            scrollView.addSubview(label)
            titlaLabelArr.append(label)
        
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLableClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
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
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, alpha: 1)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

// MARK:- 监听 label 点击
extension PageTitleView {
    @objc fileprivate func titleLableClick(tapGes: UITapGestureRecognizer) {
        //获取当前 label 的下标值
        guard let currentLabel = tapGes.view as? UILabel else {return}
        //获取之前的 label
        let oldLabel = titlaLabelArr[currentIndex]
        //切换文字颜色
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, alpha: 1)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1)
        //保存新的 label 下标值
        currentIndex = currentLabel.tag
        //滚动条位置改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        //通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleWtihProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) -> Void {
        //取出 sourceIndex 对应的 label
        let sourceLb = titlaLabelArr[sourceIndex]
        //取出 targetIndex 对应的 label
        let targetLB = titlaLabelArr[targetIndex]
        //处理滑块逻辑
        let movetotalX = targetLB.frame.origin.x - sourceLb.frame.origin.x
        let moveX = movetotalX * progress
        scrollLine.frame.origin.x = sourceLb.frame.origin.x + moveX
        //颜色发生渐变
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        sourceLb.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress, alpha: 1)
        targetLB.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress, alpha: 1)
        //记录最新的 index
        currentIndex = targetIndex
    }
}
