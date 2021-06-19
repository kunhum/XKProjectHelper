//
//  XKFileManager.swift
//  Health
//
//  Created by Nicholas on 2020/4/23.
//  Copyright © 2020 Nicholas. All rights reserved.
//

import Foundation
import XKUtil

class XKFileManager: NSObject {
    
    static let fileManager = FileManager.default
    
    static func xk_moveFile(atPath fromPath: String, toPath targetPath: String) -> (Bool, String?) {
        
        if fileManager.fileExists(atPath: targetPath) {
            do {
                try fileManager.removeItem(atPath: targetPath)
            }
            catch let error {
                return (false, error.localizedDescription)
            }
        }
        
        do {
            try fileManager.moveItem(atPath: fromPath, toPath: targetPath)
        }
        catch let error {
            return (false, error.localizedDescription)
        }
        return (true, nil)
    }
    //MARK: 获取APP缓存
    static func xk_appCacheSize() -> String {
        
        guard var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last else { return "" }
        path.append("/Caches")
        
        let size = XKUtil.folderSize(atPath: path)
        
        if (size < 1000) {
            return "\(size)B"
        }
        let realSize = Double(size) / 1000.0 / 1000.0;
        if (realSize >= 1.0) {
            return String(format: "%.0f", realSize) + "M"
        }
        else {
            return String(format: "%.0f", Double(size) / 1000.0) + "KB"
        }
        
    }
    //MARK: 获取文件大小
    static func xk_fileSize(path: String) -> String {
        
        let size = XKUtil.fileSize(atPath: path)
        
        if (size < 1000) {
            return "\(size)B"
        }
        let realSize = Double(size) / 1000.0 / 1000.0;
        if (realSize >= 1.0) {
            return String(format: "%.1f", realSize) + "M"
        }
        else {
            return String(format: "%.1f", Double(size) / 1000.0) + "KB"
        }
        
    }
    //MARK: 获取数据大小
    static func xk_dataSize(data: Data?) -> String {
        
        guard let fileData = data else { return "" }
        
        let size = Double(fileData.count)
        
        if (size < 1000) {
            return "\(size)B"
        }
        let realSize = Double(size) / 1000.0 / 1000.0;
        if (realSize >= 1.0) {
            return String(format: "%.1f", realSize) + "M"
        }
        else {
            return String(format: "%.1f", Double(size) / 1000.0) + "KB"
        }
    }
    //MARK: 清除APP缓存
    static func xk_clearAPPCaches() {
        
        guard var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last else { return }
        path.append("/Caches")
        
        do {
            try fileManager.removeItem(atPath: path)
        }
        catch let error {
            print("清理缓存错误：\(error.localizedDescription)")
        }
    }
    //MARK: 创建文件夹
    static func xk_createFileDirectory(path: String) {
        
        guard fileManager.fileExists(atPath: path) == false else {
            return
        }
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        catch {
            
        }
    }
    //MARK: 判断是否存在文件
    static func xk_fileExist(filePath: String) -> Bool {
        return fileManager.fileExists(atPath: filePath)
    }
    //MARK: 创建文件
    static func xk_createFile(path: String, content: Data?) -> Bool {
        
        guard fileManager.fileExists(atPath: path) == false else {
            return false
        }
        return fileManager.createFile(atPath: path, contents: content, attributes: nil)
    }
    
}
