//
//  UINavigationController+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/29/20.
//

import UIKit


public extension SwiftExKit where Base: UINavigationController {
    // MARK: - 设置导航栏标题颜色
    var defaultTitleColor: UIColor {
        return base.navigationBar.ex.defaultTitleColor
    }
    
    func setTitleColor(_ color: UIColor) {
        base.navigationBar.ex.setTitleColor(color)
    }
    
    @available(iOS 11.0, *)
    func setLargeTitleColor(_ color: UIColor) {
        base.navigationBar.ex.setLargeTitleColor(color)
    }
    // MARK: - 设置导航栏标题字体
    func setTitleFont(_ font: UIFont) {
        base.navigationBar.ex.setTitleFont(font)
    }
    
    func setLargeTitleFont(_ font: UIFont) {
        base.navigationBar.ex.setLargeTitleFont(font)
    }
    
    // 设置导航栏背景图片
    func setBackgroundImage(_ backgroundImage: UIImage?, for barMetrics: UIBarMetrics) {
        if #available(iOS 13.0, *) {
            self.base.navigationBar.standardAppearance.backgroundImage = backgroundImage
        } else {
            base.navigationBar.setBackgroundImage(backgroundImage, for: barMetrics)
        }
        
    }
    
    
    // 设置导航栏透明度
    var alpha: CGFloat? {
        set {
            base.navigationBar.ex.alpha = newValue
        }
        get {
            return base.navigationBar.ex.alpha
        }
    }
    
    // 设置导航栏背景色
    var barTintColor: UIColor? {
        set {
            if #available(iOS 13.0, *) {
                self.base.navigationBar.standardAppearance.backgroundColor = newValue
            } else {
                base.navigationBar.barTintColor = newValue
            }
            
        }
        get {
            if #available(iOS 13.0, *) {
                return self.base.navigationBar.standardAppearance.backgroundColor
            }
            return base.navigationBar.barTintColor
        }
    }
    
}
