//
//  XKProjectHelper.swift
//  PhysicalExamination
//
//  Created by Nicholas on 2020/11/9.
//

import Foundation
import AVFoundation

let XK_LOGIN_KEY = "XK_LOGIN_KEY"
let XK_TAOLU_KEY = "XK_TAOLU_KEY"

///登录状态
public var XK_LOGIN_STATUS: Bool {
    return XK_UserDefaults.bool(forKey: XK_LOGIN_KEY)
}
///设置登录状态
public func XK_SetLogin(status: Bool) {
    XK_UserDefaults.set(status, forKey: XK_LOGIN_KEY)
    XK_UserDefaults.synchronize()
}
public func XK_excute(debug: (() -> Void)?, release: (() -> Void)?) {
    #if DEBUG
    debug?()
    #else
    release?()
    #endif
}
///套路：true时代表要执行套路
public var XK_TAOLU_STATUS: Bool {
    return XK_UserDefaults.bool(forKey: XK_TAOLU_KEY)
}
public func Xk_SetTaolu(status: Bool) {
    XK_UserDefaults.set(status, forKey: XK_TAOLU_KEY)
    XK_UserDefaults.synchronize()
}

public class XKProjectHelper {
    
    //MARK: 获取视频大小
    public static func videoSize(urlPath: String, maxHeight: CGFloat = XK_SCREEN_HEIGHT) -> CGSize {
        
        guard let videoUrl = URL(string: urlPath) else { return CGSize.zero }
        
        let asset = AVURLAsset(url: videoUrl)
        
        var videoSize = CGSize.zero
        
        for track in asset.tracks {
            
            if track.mediaType == .video {
                videoSize = track.naturalSize
            }
        }
        
        let convertHeight = videoSize == CGSize.zero ? 0.0 : XK_SCREEN_WIDTH * videoSize.height / videoSize.width
        
        return CGSize(width: XK_SCREEN_WIDTH, height: convertHeight > maxHeight ? maxHeight : convertHeight)
        
    }
    //MARK: 格式化距离，返回*m，*km
    public static func formatDistance(distance: Double) -> String {
        
        guard distance > 1000.0 else {
            return "\(distance)" + "m"
        }
        return String(format: "%.1fkm", distance / 1000.0)
    }
    //MARK: 格式化昵称
    public static func formatNickname(nickName: String) -> String {

        let tmpNic = nickName as NSString
        
        guard tmpNic.length > 1 else {
            return nickName
        }
        guard tmpNic.length > 2 else {
            return tmpNic.replacingCharacters(in: NSRange(location: tmpNic.length - 1, length: 1), with: "*") as String
        }
        
        let prefix = tmpNic.substring(to: 1)
        let suffix = tmpNic.substring(with: NSRange(location: tmpNic.length - 1, length: 1))
        
        return prefix + "*" + suffix
    }

    //MARK: 创建缓存文件
    public static func createCaches() {
        guard let documentPath = XK_PATH_DOCUMENT else { return }
        let path = documentPath + "/XKCaches"
        XKFileManager.xk_createFileDirectory(path: path)
    }
    //MARK: 获取缓存目录路径
    public static func cachesPath() -> String {
        guard let documentPath = XK_PATH_DOCUMENT else { return "" }
        return documentPath + "/XKCaches"
    }
    
}

