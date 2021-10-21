//
//  UIAlertController+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/29/20.
//

import UIKit

fileprivate struct YYBAltertKeys {
    static var AlterKeysWithAlertControllerActionTextColor = false
    static var AlterKeysWithAlertControllerTintColor = false
    static var AlterKeysWithAlertControllerTitleColor = false
    static var AlterKeysWithAlertControllerMessageColor = false
}

public extension SwiftExKit where Base: UIAlertController {
    // MARK: 标题颜色
    var titleColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &(YYBAltertKeys.AlterKeysWithAlertControllerTitleColor)) as! UIColor
        }
        set {
            let attr = NSMutableAttributedString(string: self.base.title ?? "", attributes: [NSAttributedString.Key.foregroundColor:newValue,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)])
            
            self.base.setValue(attr, forKey: "attributedTitle")
            

            objc_setAssociatedObject(self, &(YYBAltertKeys.AlterKeysWithAlertControllerTitleColor), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    // MARK: 内容颜色
    var messageColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &(YYBAltertKeys.AlterKeysWithAlertControllerMessageColor)) as! UIColor
        }
        set {
            
            
            let attr = NSMutableAttributedString(string: self.base.message ?? "", attributes: [NSAttributedString.Key.foregroundColor:newValue,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)])
            self.base.setValue(attr, forKey: "attributedMessage")
            objc_setAssociatedObject(self, &(YYBAltertKeys.AlterKeysWithAlertControllerMessageColor), newValue, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
}

public extension SwiftExKit where Base: UIAlertAction {
    // MARK: 标题颜色
    var textColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &(YYBAltertKeys.AlterKeysWithAlertControllerActionTextColor)) as! UIColor
        }
        set {
            
            if self.base.style == .destructive {
                return
            }
            self.base.setValue(newValue, forKey: "titleTextColor")
            objc_setAssociatedObject(self, &(YYBAltertKeys.AlterKeysWithAlertControllerActionTextColor), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            
        }
    }
    
}
