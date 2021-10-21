//
//  UINavigationBar+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/29/20.
//

import UIKit

public extension SwiftExKit where Base: UINavigationItem {
    
    /// 设置左按钮(标题按钮)
    func leftBarButtonItem(title: String, titleColor: UIColor, textAlignment: NSTextAlignment = .center, actionBlock: @escaping (UIControl)->()) {
        self.base.leftBarButtonItem = UIBarButtonItem.swe.barButtonItem(title: title, titleColor: titleColor, textAlignment:textAlignment, actionBlock: actionBlock)
    }
    /// 设置右按钮(标题按钮)
    func rightBarButtonItem(title: String, titleColor: UIColor, textAlignment: NSTextAlignment = .center, actionBlock: @escaping (UIControl)->()) {
        self.base.rightBarButtonItem = UIBarButtonItem.swe.barButtonItem(title: title, titleColor: titleColor, textAlignment:textAlignment ,actionBlock: actionBlock)
    }
    /// 设置左按钮(图片按钮)
    func leftBarButtonItem(normalImage: UIImage, selectedImage: UIImage, actionBlock: @escaping (UIControl)->()) {
        self.base.leftBarButtonItem = UIBarButtonItem.swe.barButtonItem(normalImage: normalImage, selectedImage: selectedImage, actionBlock: actionBlock)
    }
    /// 设置右按钮(图片按钮)
    func rightBarButtonItem(normalImage: UIImage, selectedImage: UIImage, actionBlock: @escaping (UIControl)->()) {
        self.base.rightBarButtonItem = UIBarButtonItem.swe.barButtonItem(normalImage: normalImage, selectedImage: selectedImage, actionBlock: actionBlock)
    }
    
    /// 设置左边多个图片按钮
    func leftBarButtonItems(normarImages: [UIImage], selectedImages: [UIImage], actionBlock: @escaping (Int)->()) {
        self.base.leftBarButtonItems = UIBarButtonItem.swe.barButtonItems(normalImages: normarImages, selectedImages: selectedImages, actionBlock: actionBlock)
    }
    /// 设置右边多个图片按钮
    func rightBarButtonItems(normarImages: [UIImage], selectedImages: [UIImage], actionBlock: @escaping (Int)->()) {
        self.base.rightBarButtonItems = UIBarButtonItem.swe.barButtonItems(normalImages: normarImages, selectedImages: selectedImages, actionBlock: actionBlock)
    }
    
}



