//
//  笔记.c
//  Uber
//
//  Created by ypc on 17/1/16.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

/*
 效果:刚开始显示启动屏
    然后显示一个动画
    然后显示一段视频
 并且当动画显示完以后才显示登录,注册那两个按钮
    1.设置启动图片为黑色
    2.设置guidPage.xib的view的背景也为黑色
    3.为了实现动画播放完毕后再显示按钮,可以把两个按钮放到一个view上,给这个view设置一个动画,动画开始前设置 view的透明度为0,动画播放完后设置 alpha为1
    4.
 */
