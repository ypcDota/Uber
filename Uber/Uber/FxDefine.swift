//
//  FxDefine.swift
//  Uber
//
//  Created by ypc on 17/1/16.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import Foundation

// 
let LoadingTip = "加载中..."
func FxLog(_ message:String){
    
    #if DEBUG
        print("\(message)")
    #else
    
    #endif
}
