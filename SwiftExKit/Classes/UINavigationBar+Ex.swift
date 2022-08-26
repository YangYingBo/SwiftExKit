//
//  UINavigationBar+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/29/20.
//

import UIKit

public extension SwiftExKit where Base: UINavigationBar {
    // MARK: - 设置导航栏标题颜色
    var defaultTitleColor: UIColor {
        return base.barStyle == .default ? UIColor.black : UIColor.white
    }
    
    func setTitleColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            base.standardAppearance.titleTextAttributes = [.foregroundColor: color]
        } else {
            if var titleTextAttributes = base.titleTextAttributes {
                titleTextAttributes[.foregroundColor] = color
                base.titleTextAttributes = titleTextAttributes
            } else {
                base.titleTextAttributes = [.foregroundColor: color]
            }
        }
        
    }
    
    @available(iOS 11.0, *)
    func setLargeTitleColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            base.standardAppearance.largeTitleTextAttributes = [.foregroundColor: color]
        } else {
            if var largeTitleTextAttributes = base.largeTitleTextAttributes {
                largeTitleTextAttributes[.foregroundColor] = color
                base.largeTitleTextAttributes = largeTitleTextAttributes
            } else {
                base.largeTitleTextAttributes = [.foregroundColor: color]
            }
        }
        
    }
    // MARK: - 设置导航栏标题字体
    func setTitleFont(_ font: UIFont) {
        if #available(iOS 13.0, *) {
            base.standardAppearance.titleTextAttributes = [.font: font]
        } else {
            if var titleTextAttributes = base.titleTextAttributes {
                titleTextAttributes[.font] = font
                base.titleTextAttributes = titleTextAttributes
            } else {
                base.titleTextAttributes = [.font: font]
            }
        }
        
    }
    
    func setLargeTitleFont(_ font: UIFont) {
        if #available(iOS 13.0, *) {
            base.standardAppearance.largeTitleTextAttributes = [.font: font]
        } else {
            if var titleTextAttributes = base.titleTextAttributes {
                titleTextAttributes[.font] = font
                base.titleTextAttributes = titleTextAttributes
            } else {
                base.titleTextAttributes = [.font: font]
            }
        }
        
    }
    // 设置导航栏透明度
    var alpha: CGFloat? {
        set {
            base.subviews.first?.alpha = newValue ?? 0
        }
        get {
            return base.subviews.first?.alpha
        }
    }
    
}



