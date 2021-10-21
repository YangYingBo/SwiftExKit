//
//  UIButton+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/28/20.
//

import UIKit
import Foundation

fileprivate struct UIButtonSwiftExKitAssociatedKey {
    static var animationTimerKey = false
}

// 为UIButton 拓展功能
public extension SwiftExKit where Base: UIButton {
    
    enum ButtonEdgeInsetsStyle :Int{
        case Top    // image在上,Label在下
        case Left   // image在左,label在右
        case Right  // image在右,label在左
        case Bottom // image在下,label在上
    }
    
    // MARK: 变换图片和标题的位置
    ///
    /// - Parameters:
    ///   - EdgeInsetsStyle: 变换位置类型
    ///   - sepace: 标题和图片的间距
    @discardableResult
    func layoutButton(style: ButtonEdgeInsetsStyle, sepace: CGFloat, titleSize: CGSize = .zero) -> CGSize {
        // 获取图片宽高
        let img_width = self.base.imageView?.image?.size.width ?? 0
        let img_height = self.base.imageView?.image?.size.height ?? 0
        
        
        var label_width :CGFloat = 0.0
        var label_height :CGFloat = 0.0
        // 获取到titleLabel宽高
        
//        if #available(iOS 8.0, *) {
//            label_width = self.base.titleLabel?.intrinsicContentSize.width ?? 0
//            label_height = self.base.titleLabel?.intrinsicContentSize.height ?? 0
//        } else {
//            label_width = self.base.titleLabel?.frame.size.width ?? 0
//            label_height = self.base.titleLabel?.frame.size.height ?? 0
//        }
        
        var labelSize = CGSize.zero
        if let label = self.base.titleLabel, let title = label.text {
            labelSize = title.swe.size(label.font, size: titleSize)
        }
        
        label_width = ceil(labelSize.width)
        label_height = ceil(labelSize.height)
        
        var imageEdgeInsets = UIEdgeInsets()
        var labelEdgeInsets = UIEdgeInsets()
        
        var buttonSize = CGSize.zero
        
        
        // 图片和titleLabel的位置偏移量设置
        switch style {
        case .Top:
            imageEdgeInsets = UIEdgeInsets(top: -label_height-sepace/2, left: 0, bottom: 0, right: -label_width)
            labelEdgeInsets = UIEdgeInsets(top: img_height+sepace/2, left: -img_width, bottom: 0, right: 0)
            buttonSize = CGSize(width: max(img_width, label_width), height: img_height+label_height+sepace+5)
        break
            
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -sepace/2, bottom: 0, right: sepace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: sepace/2, bottom: 0, right: -sepace/2)
            buttonSize = CGSize(width: img_width+label_width+sepace+5, height: max(img_height, label_height))
           break
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: label_width+sepace/2, bottom: 0, right: -label_width-sepace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -img_width-sepace/2, bottom: 0, right: img_width+sepace/2)
            buttonSize = CGSize(width: img_width+label_width+sepace+5, height: max(img_height, label_height))
            break
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: label_height+sepace/2, left: 0, bottom: 0, right: -label_width)
            labelEdgeInsets = UIEdgeInsets(top: -img_height-sepace/2, left: -img_width, bottom: 0, right: 0)
            buttonSize = CGSize(width: max(img_width, label_width), height: img_height+label_height+sepace+5)
           break
        }
        
        self.base.imageEdgeInsets = imageEdgeInsets
        self.base.titleEdgeInsets = labelEdgeInsets;
        
        return buttonSize
    }
    
    
    // MARK: 创建默认标题 标题颜色
    static func button(normalTitle: String,
                     normalTitleColor: UIColor) -> UIButton {
        
        return button(normalImage: nil, selectedImage: nil, normalTitle: normalTitle, selectedTitle: nil, normalTitleColor: normalTitleColor, selectedTitleColor: nil)
    }
    
    // MARK: 创建默认图片 标题 标题颜色
    static func button(normalImage: UIImage,
                     normalTitle: String,
                     normalTitleColor: UIColor) -> UIButton {
        
        return button(normalImage: normalImage, selectedImage: nil, normalTitle: normalTitle, selectedTitle: nil, normalTitleColor: normalTitleColor, selectedTitleColor: nil)
    }
    
    // MARK: 创建默认图片 点击图片 默认标题 点击标题
    static func button(normalImage: UIImage,
                     selectedImage: UIImage,
                     normalTitle: String,
                     normalTitleColor: UIColor) -> UIButton {
        return button(normalImage: normalImage, selectedImage: selectedImage, normalTitle: normalTitle, selectedTitle: nil, normalTitleColor: normalTitleColor, selectedTitleColor: nil)
    }
    // MARK: 创建默认标题 点击标题
    static func button(normalTitle: String,
                            selectedTitle: String,
                            normalTitleColor: UIColor,
                            selectedTitleColor: UIColor) -> UIButton {
        
        return button(normalImage: nil, selectedImage: nil, normalTitle: normalTitle, selectedTitle: selectedTitle, normalTitleColor: normalTitleColor, selectedTitleColor: selectedTitleColor)
    }
    // MARK: 创建图片按钮
    static func button(normalImage: UIImage?,
                       selectedImage: UIImage?) -> UIButton {
        return button(normalImage: normalImage, selectedImage: selectedImage, normalTitle: nil, selectedTitle: nil, normalTitleColor: nil, selectedTitleColor: nil)
    }
    
    // MARK: 创建带图带文字的按钮
    static func button(normalImage: UIImage?,
                       selectedImage: UIImage?,
                       normalTitle: String?,
                       selectedTitle: String?,
                       normalTitleColor: UIColor?,
                       selectedTitleColor: UIColor?) -> UIButton {
        
        let button = UIButton(type: .custom)
        
        if let normalImage = normalImage {
          button.setImage(normalImage, for: .normal)
        }
        
        if let selectedImage = selectedImage {
            button.setImage(selectedImage, for: .selected)
        }
        
        if let normalTitle = normalTitle {
           button.setTitle(normalTitle, for: .normal)
        }
        
        if let selectedTitle = selectedTitle {
            button.setTitle(selectedTitle, for: .selected)
        }
        
        if let normalTitleColor = normalTitleColor {
           button.setTitleColor(normalTitleColor, for: .normal)
        }
        
        if let selectedTitleColor = selectedTitleColor {
           button.setTitleColor(selectedTitleColor, for: .selected)
        }
        
        return button
    }
    
    /// 设置按钮纯色背景图片
    func setBackgroundImage(_ color: UIColor, for state: UIControl.State) {
        
        let size = self.base.frame.size
        let normalSize = CGSize(width: size.width == 0 ? 1 : size.width, height: size.height == 0 ? 1 : size.height)
        self.setBackgroundImage(color, size: normalSize, for: state)
        
    }
    
    
    func setBackgroundImage(_ color: UIColor, size: CGSize, corner: CGFloat = 0, for state: UIControl.State) {
        
        let bgImage = UIImage.swe.image(color: color, size: size, corner: corner)
        self.base.setBackgroundImage(bgImage, for: state)
        
    }
    
    /// 设置按钮纯色图片
    func setImage(_ color: UIColor, for state: UIControl.State) {
        let size = self.base.frame.size
        let normalSize = CGSize(width: size.width == 0 ? 1 : size.width, height: size.height == 0 ? 1 : size.height)
        self.setImage(color, size: normalSize, for: state)
    }
    
    func setImage(_ color: UIColor, size: CGSize, corner: CGFloat = 0, for state: UIControl.State) {
        
        let bgImage = UIImage.swe.image(color: color, size: size, corner: corner)
        self.base.setImage(bgImage, for: state)
        
    }
    
    
    var selectImageAnimationTimer: Timer {
        set {
            objc_setAssociatedObject(self.base, &(UIButtonSwiftExKitAssociatedKey.animationTimerKey), newValue, .OBJC_ASSOCIATION_RETAIN)
        } get {
            return objc_getAssociatedObject(self.base, &(UIButtonSwiftExKitAssociatedKey.animationTimerKey)) as! Timer
        }
    }
    
    func animationToSelectImage(_ ti: TimeInterval, block: @escaping (Timer)->()) {
        
        if #available(iOS 10.0, *) {
            self.selectImageAnimationTimer = Timer(timeInterval: ti, repeats: true, block: block)
        } else {
            // Fallback on earlier versions
        }
        RunLoop.current.add(self.selectImageAnimationTimer, forMode: .commonModes)
        self.selectImageAnimationTimer.fireDate = .distantFuture
    }
    
    func startImageAnimation() {
        self.selectImageAnimationTimer.fireDate = .distantPast
    }
    
    func stopImageAnimation() {
        self.selectImageAnimationTimer.fireDate = .distantFuture
    }
    
}
