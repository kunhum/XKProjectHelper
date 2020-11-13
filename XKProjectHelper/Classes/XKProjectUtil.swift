//
//  XKProjectUtil.swift
//  XKProjectHelper
//
//  Created by Nicholas on 2020/5/28.
//

import Foundation
import AVFoundation

//MARK: 获取视频大小
public func XK_VideoSize(urlPath: String) -> CGSize {
    
    guard let videoUrl = URL(string: urlPath) else { return CGSize.zero }
    
    let asset = AVURLAsset(url: videoUrl)
    
    var videoSize = CGSize.zero
    
    for track in asset.tracks {
        
        if track.mediaType == .video {
            videoSize = track.naturalSize
        }
    }
    
    let convertHeight = XK_SCREEN_WIDTH * videoSize.height / videoSize.width

    return CGSize(width: XK_SCREEN_WIDTH, height: convertHeight)
    
}
