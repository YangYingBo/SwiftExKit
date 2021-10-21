//
//  UIApplication+Ex.swift
//  SwiftExKit
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
        
        let window = UIApplication.shared.delegate?.window
//        let windowScenes = UIApplication.shared.openSessions
//
//        let windowIndex = windowScenes.index(windowScenes.startIndex, offsetBy: windowScenes.count - 1)
//
//        let windowScene = windowScenes[windowIndex]
//
//        let window = (windowScene.scene?.delegate as? SceneDelegate)?.window
        
        let frontView = window??.subviews[0]
        
        var nextResponder = frontView?.next
        
        while (nextResponder != nil) {
            
            if (nextResponder is UIWindow) {
                nextResponder = (nextResponder as! UIWindow).rootViewController
            } else if (nextResponder is UINavigationController) {
                nextResponder = (nextResponder as! UINavigationController).visibleViewController
            } else if (nextResponder is UITabBarController) {
                nextResponder = (nextResponder as! UITabBarController).selectedViewController
            } else {
                if ((nextResponder as! UIViewController).presentedViewController != nil) {
                    nextResponder = (nextResponder as! UIViewController).presentedViewController!
                } else {
                    return nextResponder as? UIViewController
                }
            }
        }
        
        return nil
    }
    // 是否是刘海屏
    static var isIPhoneXSeries: Bool {
        if let window:UIWindow = UIApplication.shared.delegate?.window ?? nil {
            if #available(iOS 11.0, *) {
                return (window.safeAreaInsets.bottom > 0)
            } else {
                // Fallback on earlier versions
                return false
            }
        }
        return false
    }
    // 清除启动图缓存文件
    static func clearLaunchScreenCache() {
        do {
            try? FileManager.default.removeItem(atPath: NSHomeDirectory() + "/Library/SplashBoard")
        } catch {
            
        }
    }
    
}
