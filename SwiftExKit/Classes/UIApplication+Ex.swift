//
//  UIApplication+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/28/20.
//

import UIKit

public extension SwiftExKit where Base: UIApplication {
    // MARK: 文档目录
    static var documentsURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    static var documentsPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    // MARK: 缓存目录
    static var cachesURL: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }
    
    static var cachesPath: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    // MARK: 库目录
    static var libraryURL: URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last
    }
    
    static var libraryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    
    static var topViewController: UIViewController? {
        
        var rootVC: UIViewController?
        
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                rootVC = scene.windows.first?.rootViewController
            }
        } else {
            // Fallback on earlier versions
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        while (rootVC != nil) {
            
            if (rootVC is UINavigationController) {
                rootVC = (rootVC as! UINavigationController).visibleViewController
            } else if (rootVC is UITabBarController) {
                rootVC = (rootVC as! UITabBarController).selectedViewController
            } else {
                if (rootVC?.presentedViewController != nil) {
                    return rootVC?.presentedViewController
                } else {
                    return rootVC
                }
            }
        }
        
        return rootVC
    }
    
    // 清除启动图缓存文件
    static func clearLaunchScreenCache() {
        do {
            try? FileManager.default.removeItem(atPath: NSHomeDirectory() + "/Library/SplashBoard")
        }
    }
    
}
