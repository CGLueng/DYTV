 //
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/12.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

 import Foundation
 import UIKit
 
 extension UIBarButtonItem {
    class func createItem(imageName : String, hightlightImage : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightlightImage), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    convenience init(imageName : String, hightlightImage : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightlightImage != "" {
            btn.setImage(UIImage(named: hightlightImage), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
 }
