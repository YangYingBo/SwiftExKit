//
//  UIViewController+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/29/20.
//

import UIKit

public extension SwiftExKit where Base: UIViewController {
    
    // MARK: - 模态视图
    /// PUSH
    func pushVC(_ vc: UIViewController) {
        self.base.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// POP
    func popVC() {
        _ = self.base.navigationController?.popViewController(animated: true)
    }
    
    func popToRootVC() {
        _ = self.base.navigationController?.popToRootViewController(animated: true)
    }
    
    func present(_ vc: UIViewController) {
        self.base.present(vc, animated: true, completion: nil)
    }
    
    func dismiss() {
        self.base.dismiss(animated: true, completion: nil)
    }
    
    /// 导航栏颜色
    var navigationBarColor: UIColor? {
        get {
            return self.base.navigationController?.ex.barTintColor
        } set(value) {
            self.base.navigationController?.ex.barTintColor = value
        }
    }
    
    /// 设置左按钮(标题按钮)
    func leftBarButtonItem(title: String, titleColor: UIColor, textAlignment: NSTextAlignment = .center, actionBlock: @escaping (UIControl)->()) {
        self.base.navigationItem.ex.leftBarButtonItem(title: title, titleColor: titleColor, textAlignment:textAlignment, actionBlock: actionBlock)
    }
    /// 设置右按钮(标题按钮)
    func rightBarButtonItem(title: String, titleColor: UIColor, textAlignment: NSTextAlignment = .center, actionBlock: @escaping (UIControl)->()) {
        self.base.navigationItem.ex.rightBarButtonItem(title: title, titleColor: titleColor, textAlignment:textAlignment, actionBlock: actionBlock)
    }
    /// 设置左按钮(图片按钮)
    func leftBarButtonItem(normalImage: UIImage, selectedImage: UIImage, actionBlock: @escaping (UIControl)->()) {
        self.base.navigationItem.ex.leftBarButtonItem(normalImage: normalImage, selectedImage: selectedImage, actionBlock: actionBlock)
    }
    /// 设置右按钮(图片按钮)
    func rightBarButtonItem(normalImage: UIImage, selectedImage: UIImage, actionBlock: @escaping (UIControl)->()) {
        self.base.navigationItem.ex.rightBarButtonItem(normalImage: normalImage, selectedImage: selectedImage, actionBlock: actionBlock)
    }
    
    /// 设置左按钮(图片按钮)
    func leftBarButtonItems(nomarImage: [UIImage], seleteImage: [UIImage], actionBlock: @escaping (Int)->()) {
        self.base.navigationItem.ex.leftBarButtonItems(normarImages: nomarImage, selectedImages: seleteImage, actionBlock: actionBlock)
    }
    /// 设置右按钮(图片按钮)
    func rightBarButtonItems(nomarImage: [UIImage], seleteImage: [UIImage], actionBlock: @escaping (Int)->()) {
        self.base.navigationItem.ex.rightBarButtonItems(normarImages: nomarImage, selectedImages: seleteImage, actionBlock: actionBlock)
    }
    
}
