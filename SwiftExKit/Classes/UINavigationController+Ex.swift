//
//  UINavigationController+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/29/20.
//

import UIKit


public extension SwiftExKit where Base: UINavigationController {
    // MARK: - 设置导航栏标题颜色
    var defaultTitleColor: UIColor {
        return base.navigationBar.swe.defaultTitleColor
    }
    
    func setTitleColor(_ color: UIColor) {
        base.navigationBar.swe.setTitleColor(color)
    }
    
    @available(iOS 11.0, *)
    func setLargeTitleColor(_ color: UIColor) {
        base.navigationBar.swe.setLargeTitleColor(color)
    }
    // MARK: - 设置导航栏标题字体
    func setTitleFont(_ font: UIFont) {
        base.navigationBar.swe.setTitleFont(font)
    }
    
    func setLargeTitleFont(_ font: UIFont) {
        base.navigationBar.swe.setLargeTitleFont(font)
    }
    
    // 设置导航栏背景图片
    func setBackgroundImage(_ backgroundImage: UIImage?, for barMetrics: UIBarMetrics) {
        base.navigationBar.setBackgroundImage(backgroundImage, for: barMetrics)
    }
    
    
    // 设置导航栏透明度
    var alpha: CGFloat? {
        set {
            base.navigationBar.swe.alpha = newValue
        }
        get {
            return base.navigationBar.swe.alpha
        }
    }
    
    // 设置导航栏背景色
    var barTintColor: UIColor? {
        set {
            base.navigationBar.barTintColor = newValue
        }
        get {
            return base.navigationBar.barTintColor
        }
    }
    
}
