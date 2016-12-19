//
//  GameViewModel.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/19.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class GameViewModel {
     lazy var gamesArr : [BasicGameModel] = [BasicGameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallbakc: @escaping () -> ()) {
        NetWorkingTools.requestData(type: .GET, URL: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (response) in
            //获取数据
            guard let resultDict = response as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
            //字典转模型
            for dict in dataArr {
                 self.gamesArr.append(GameModel(dict: dict))
            }
            //完成回调
            finishedCallbakc()
        }
    }
}
