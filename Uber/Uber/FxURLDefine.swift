//
//  FxURLDefine.swift
//  Uber
//
//  Created by ypc on 17/1/16.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

func ServerAddress() -> String {
    
    let address = "http://127.16.19.18"
    
    #if AppStore
        address = "http://www.uber.com"
    #endif
    return address
}
// 银联地址url
let YLTnURL = "http://202.101.25.178:8080/sim/gettn"
