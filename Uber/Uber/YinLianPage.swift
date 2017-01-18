//
//  YinLianPage.swift
//  Uber
//
//  Created by ypc on 17/1/18.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

class YinLianPage: FxBasePage {

    //MARK: - 定义属性
    var responseData:NSMutableData?
    //MARK: - 控件属性
    @IBAction func payMoney(_ sender: Any) {
        let url = URL(string: YLTnURL)
     startPay(url: url!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
        self.setUpNavWith(title: "返回", selector: #selector(self.doLeft), isRight: false)
    }
}

extension YinLianPage {
    
    func startPay(url : URL) {
        let urlRequest = URLRequest(url : url)
        let connect = NSURLConnection(request: urlRequest, delegate: self)
        connect?.start()
    }
    
    // 支付回调函数
    func UPPayPluginResult(result : String){
        // 支付完成打印支付信息给用户看
        FxLog(result)
    }
}
//MARK: - URLConnectionDelegate
extension YinLianPage : NSURLConnectionDataDelegate {
    
    func connection(connection: NSURLConnection, didReceiveResponse response: URLResponse) {
        let urlResponse = response as! HTTPURLResponse
        
        if urlResponse.statusCode != 200 {
            FxLog("error status code")
        }
        else {
            responseData = NSMutableData()
        }
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: Data) {
        responseData?.append(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        let result = String(data: responseData! as Data, encoding: String.Encoding.utf8)
        
        if result != nil {
//            FxPayPlugin.startPayFx(result, mode: "01", viewController: self, delegate: self)
        }
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        FxLog(error.localizedFailureReason!)
    }

}
