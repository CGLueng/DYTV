//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/12.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    //随即颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g:  CGFloat(arc4random_uniform(256)), b:  CGFloat(arc4random_uniform(256)), alpha: 1.0)
    }
}
