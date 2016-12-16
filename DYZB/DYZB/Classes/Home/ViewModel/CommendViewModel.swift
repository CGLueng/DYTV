//
//  CommendViewModel.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/15.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class CommendViewModel {
    // MARK:- 懒加载属性
    lazy var anchorGroupArr : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModelArr : [CycleModel] = [CycleModel]()
    
    fileprivate lazy var group1 : AnchorGroup = AnchorGroup()
    fileprivate lazy var group2 : AnchorGroup = AnchorGroup()
}

// MARK:- 发送网络请求
extension CommendViewModel {
    //请求推荐数据
    func requestData(finishedCallback: @escaping () -> ()) {
        //定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
        
        //创建线程组
        let dispatchGroup = DispatchGroup()

        //请求推荐部分
        dispatchGroup.enter()//一旦请求数据线进入组
        NetWorkingTools.requestData(type: .GET, URL: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime() as NSString], finishedCallback:{(result) in
            //转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //设置属性
            self.group1.tag_name = "热门"
            self.group1.icon_name = "home_header_hot"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.group1.anchorArr.append(anchor)
            }
            //请求到数据再离开组
            dispatchGroup.leave()
        })
        
        //请求颜值部分
        dispatchGroup.enter()//一旦请求数据线进入组
        NetWorkingTools.requestData(type: .GET, URL: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, finishedCallback:{(result) in
            //转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}

            //设置属性
            self.group2.tag_name = "颜值"
            self.group2.icon_name = "home_header_phone"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.group2.anchorArr.append(anchor)
            }
            //请求到数据再离开组
            dispatchGroup.leave()
        })
        
        //请求游戏部分
         dispatchGroup.enter()//一旦请求数据线进入组
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1481770951
        NetWorkingTools.requestData(type: .GET, URL: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters, finishedCallback:{(result) in
            //转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            
            for dict in dataArr {
                let group = AnchorGroup(dict: dict)
                self.anchorGroupArr.append(group)
            }
            //请求到数据再离开组
            dispatchGroup.leave()
        })
        
        //所有数据请求到之后进行排序
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            self.anchorGroupArr.insert(self.group2, at: 0)
            self.anchorGroupArr.insert(self.group1, at: 0)
            
            finishedCallback()
        })
    }
    //请求无限轮播的数据
    func requestCycleData(finishedCallback: @escaping () -> ()) {
        NetWorkingTools.requestData(type: .GET, URL: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            //根据 key 获取数据
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            //字典转模型
            for dict in dataArr {
                self.cycleModelArr.append(CycleModel(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
