//
//  XKDefines.swift
//  XKProjectHelper
//
//  Created by Nicholas on 2020/5/26.
//

import Foundation
import UIKit

//MARK: 判断是否小屏，4.7寸以下
public let XK_SMALL_SCREEN = XK_SCREEN_WIDTH < 375.0
//MARK: 系统版本
public let XK_SYSTEM_VERSION = Double(UIDevice.current.systemVersion)!
//MARK: 判断是否iPhoneX系列
public let XK_IS_IPHONEX_SERIES = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? (Int((UIScreen.main.currentMode?.size.height ?? 0.0)/(UIScreen.main.currentMode?.size.width ?? 0.01) * 100.0) == 216) : false

//MARK: 屏幕宽
public let XK_SCREEN_WIDTH = UIScreen.main.bounds.width
//MARK: 屏幕高
public let XK_SCREEN_HEIGHT = UIScreen.main.bounds.height
//MARK: 状态栏
public let XK_STATUS_BAR_HEIGHT = XK_IS_IPHONEX_SERIES ? 44.0 : 20.0
//MARK: 导航栏高度
public let XK_NAVIGATION_BAR_HEIGHT = 44.0
//MARK: 状态栏和导航栏的高度
public let XK_STATUS_NAVIGATION_BAR_HEIGHT = XK_STATUS_BAR_HEIGHT + XK_NAVIGATION_BAR_HEIGHT
//MARK: iphonex系列底部安全区域
public let XK_IPHONEX_SAFEAREA_BOTTOM_HEIGHT = XK_IS_IPHONEX_SERIES ? 34.0 : 0.0
//MARK: iphonex系列顶部安全区域
public let XK_IPHONEX_SAFEAREA_TOP_HEIGHT = XK_IS_IPHONEX_SERIES ? 44.0 : 0.0
//MARK: Tabbar高度
public let XK_TABBAR_HEIGHT = XK_IPHONEX_SAFEAREA_BOTTOM_HEIGHT + 49.0

//MARK: 通知中心
public let XK_NotificationCenter = NotificationCenter.default
//MARK: 偏好设置
public let XK_UserDefaults = UserDefaults.standard

//MARK: - 沙盒目录
//MARK: 获取沙盒 temp
public let XK_PATH_TEMP     = NSTemporaryDirectory()
//MARK: 获取沙盒 Document
public let XK_PATH_DOCUMENT = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//MARK: 获取沙盒 Cache
public let XK_PATH_CACHE    = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

//MARK: - 方法
//MARK: 打印日志
public func XKLog<T>(_ message: T, file: String = (#file as NSString).lastPathComponent, line: Int = #line, public function:String = #function) {
    #if DEBUG
    print("file:\(file)，fuction:\(function)，line:\(line)\nmessage:\(message)")
    #endif
}
//MARK: 在主线程上执行
public func XK_MainThread(excute: (() -> Void)?) {
    DispatchQueue.main.async {
        excute?()
    }
}
//MARK: 在global线程执行
public func XK_GlobalThread(excute: (() -> Void)?) {
    DispatchQueue.global().async {
        excute?()
    }
}
//MARK: 由角度转换弧度
public func XK_DegressToRadian(_ degress: Double) -> Double {
    return Double.pi * degress / 180.0
}
//MARK: 由弧度转换角度
public func XK_RadianToDegress(_ radian: Double) -> Double {
    return radian * 180.0 / Double.pi
}
//MARK: 获取角度
public func XK_Angle(_ angle: Double) -> Double {
    return Double.pi * angle
}
//MARK: 检查是否安装某个app
public func XK_CheckInstalled(app: String) -> Bool {
    guard let url = URL(string: app) else { return false }
    return UIApplication.shared.canOpenURL(url)
}




////MARK: 获取随机颜色
//public func XK_RandomColor() -> UIColor {
//    public let r     = CGFloat(arc4random_uniform(256))
//    public let g     = CGFloat(arc4random_uniform(256))
//    public let b     = CGFloat(arc4random_uniform(256))
//    public let color = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
//    return color
//}

