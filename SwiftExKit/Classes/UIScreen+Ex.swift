//
//  UIScreen+Ex.swift
//  TBExKit
//
//  Created by yangyb on 2022/6/30.
//

import UIKit

public extension SwiftExKit where Base: UIScreen {
    // 是否是刘海屏
    static var isIPhoneXSeries: Bool {
        if let window: UIWindow = UIApplication.shared.delegate?.window ?? nil {
            if #available(iOS 11.0, *) {
                return (window.safeAreaInsets.bottom > 0)
            } else {
                // Fallback on earlier versions
                return false
            }
        }
        return false
    }
    // 导航栏高度
    static var NAV_BAR_HEIGHT: CGFloat {
        return UIDevice.ex.isPad ? 64.0 : (isIPhoneXSeries ? 88.0 : 64.0)
    }
    // 状态栏高度
    static var STATUS_BAR_HEIGHT: CGFloat {
        return UIDevice.ex.isPad ? 20.0 : (isIPhoneXSeries ? 44.0 : 20.0)
    }
    // tab高度
    static var TAB_HEIGHT: CGFloat {
        return UIDevice.ex.isPad ? 49.0 : (isIPhoneXSeries ? 83.0 : 49.0)
    }
    
    // 底部安全间距
    static var BOTTOM_SPACING: CGFloat {
        return UIDevice.ex.isPad ? 0.0 : (isIPhoneXSeries ? 34.0 : 0.0)
    }
    
    // 屏幕展示高度
    static var SHOW_HEIGHT: CGFloat {
        return HEIGHT - TAB_HEIGHT - NAV_BAR_HEIGHT - BOTTOM_SPACING
    }
    
    // UI设计参考尺寸
    static var UIFitWidth: CGFloat { 375.0 }
    static var UIFitHeight: CGFloat { 667.0 }
    // 屏幕高
    static var HEIGHT: CGFloat {
        
        return UIScreen.main.bounds.height
    }
    // 屏幕宽
    static var WIDTH: CGFloat {
        return UIScreen.main.bounds.width
    }
    // 屏幕垂直方向比例
    static var AutoSizeScaleY: CGFloat {
        return ((HEIGHT != UIFitHeight) ? (HEIGHT / UIFitHeight) : 1.0)
    }
    // 屏幕水平方向比例
    static var AutoSizeScaleX: CGFloat {
        return ((WIDTH != UIFitHeight) ? (WIDTH / UIFitWidth) : 1.0)
    }
    
    /// 根据屏幕比例适配高度
    static func AutoGetHeight(height: CGFloat) -> CGFloat{
        return height * AutoSizeScaleY
    }

    /// 根据屏幕比例适配宽度
    static func AutoGetWidth(width: CGFloat) -> CGFloat{
        return width * AutoSizeScaleX
    }

    /// 根据图片比例 计算在新宽度下的size
    static func AutoImageSizeWith(width: CGFloat, size: CGSize) -> CGSize{
        // 计算图片比例
        let value = size.width/size.height
        // 根据图片比例计算高度
        let height = width/value
        return CGSize(width: width, height: height)
    }

    /// 根据图片比例 计算新高度下的size
    static func AutoImageSizeWith(height: CGFloat, size: CGSize) -> CGSize{
        // 计算图片比例
        let value = size.width/size.height
        // 根据屏幕比例计算高度
        let width = height * value
        return CGSize(width: width, height: height)
        
    }
    
}



