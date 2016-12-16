//
//  Double-Extension.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/16.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import Foundation

extension Double {
    //四舍五入保留n位小数
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    //四舍五入保留n位小数
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
