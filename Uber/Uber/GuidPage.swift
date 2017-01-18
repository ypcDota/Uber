//
//  GuidPage.swift
//  Uber
//
//  Created by ypc on 17/1/16.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit
import AVFoundation
class GuidPage: FxBaseController {

    //MARK: - 定义属性
    var playItem : AVPlayerItem?
    var player : AVPlayer?
//    var location : FxLocation?
    
    lazy var location : FxLocation = FxLocation()
    //MARK: - 控件属性
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBAction func login(_ sender: Any) {
        
        FxLog("登录")
        location.startLocation()
        
    }
    
    @IBAction func register(_ sender: Any) {
        // 点击注册,model出accountPage控制器,
        let accountPage = CreatAccountPage()
        let nav = UINavigationController(rootViewController: accountPage)
        self.present(nav, animated: true, completion: nil)
//        showIndicator(tipMessage: "验证", autoHide: false, afterDelay: false)
    }
    //MARK: - 懒加载
    fileprivate var imagesArray : [UIImage] = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        initPlayVideo()
        // 设置启动动画
        doAnimation()
        // 
    }
}

//MARK: - 设置启动动画
extension GuidPage {
    
        func doAnimation() {
            var imageName : String = ""
            var image : UIImage?
            var imagePath : String = ""
            for i in 0..<68 {
                
                imageName = String(format: "logo-%03d", i)
//                image = UIImage(named: imageName)
                imagePath = Bundle.main.path(forResource: imageName, ofType:"png")!
                image = UIImage(contentsOfFile: imagePath)
                imagesArray.append(image!)
            }
            backImageView.animationImages = imagesArray
            backImageView.animationDuration = 5
            backImageView.animationRepeatCount = 1
            backImageView.startAnimating()
            backView.alpha = 0
            UIView.animate(withDuration: 5, animations: {
                self.backView.alpha = 1.0
                // 动画播放完毕后,播放视频
                self.player?.play()
                
            }) { (finished) in
                
                FxLog("animation End")
            }
    }
    
    // 初始化视频播放器
    func initPlayVideo() {
        guard let urlString = Bundle.main.path(forResource: "welcome_video", ofType: "mp4") else {return}
        let url = URL(fileURLWithPath: urlString)
        
        playItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playItem)
        
        let playerlayer = AVPlayerLayer(player: player)
        playerlayer.frame = backView.bounds
        playerlayer.videoGravity = AVLayerVideoGravityResizeAspect
        
//        playerlayer.addSublayer(backView.layer) 这个跟下面的区别,如果是这一句就会报错
        backView.layer.insertSublayer(playerlayer, at: 0)
        
        // 为了使视频循环播放,需要发送通知监听
        NotificationCenter.default.addObserver(self, selector:#selector(self.repeatPlay(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playItem)
        
        
    }
    
    @objc func repeatPlay(_ sender:NSNotification){
    
        // 拿到item
        let item = sender.object as! AVPlayerItem
        item.seek(to:kCMTimeZero)
        // 开始播放
        player?.play()
    }
}


/*在swift中使用target-action时,action的格式应该怎么书写呢??
 #selector(self.方法)
 因为这是OC种的格式,所以要在调用的方法前面加上 @objc
 */
