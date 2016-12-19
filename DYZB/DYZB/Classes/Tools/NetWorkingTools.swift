//
//  NewWorkingTools.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/14.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetWorkingTools {
    class func requestData(type: MethodType, URL: String, parameters: [String : Any]? = nil, finishedCallback: @escaping (_ result: Any) -> () ) {
        //获取请求类型
        let methodType = type == MethodType.GET ? HTTPMethod.get : HTTPMethod.post
        //请求数据
        Alamofire.request(URL, method: methodType, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            finishedCallback(result: result)
        }
    }
}
