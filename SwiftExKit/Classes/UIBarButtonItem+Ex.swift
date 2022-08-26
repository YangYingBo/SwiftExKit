//
//  UIBarButtonItem+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/28/20.
//

import UIKit

public extension SwiftExKit where Base: UIBarButtonItem {
    
    typealias block = (UIControl)->()
    typealias itemsBlock = (Int) -> ()
    
    static func barButtonItem(normalImage: UIImage, selectedImage: UIImage, actionBlock: @escaping block) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        
        button.setBackgroundImage(normalImage, for: .normal)
        
        button.setBackgroundImage(selectedImage, for: .selected)
        button.setBackgroundImage(selectedImage, for: .highlighted)
        
        let buttonFrame = CGRect(x: 0, y: 0, width: 30 * (normalImage.size.width) / (normalImage.size.height), height: 30)
        
        button.frame = buttonFrame
        
        button.ex.whenClick(event: .touchUpInside, callback: actionBlock)
        
        return UIBarButtonItem(customView: button)
        
    }
    
    static func barButtonItems(normalImages: [UIImage], selectedImages: [UIImage], actionBlock: @escaping itemsBlock ) -> [UIBarButtonItem] {
        
        let count = min(normalImages.count, selectedImages.count)
        var barItems = [UIBarButtonItem]()
        
        for index in 0..<count {
            let barItem = self.barButtonItem(normalImage: normalImages[index], selectedImage: selectedImages[index]) { button in
                actionBlock(button.tag - 10086)
            }
            barItem.customView?.tag = 10086 + index
            barItems.append(barItem)
        }
        
        return barItems
    }
    
    
    static func barButtonItem(title: String, titleColor: UIColor, textAlignment: NSTextAlignment = .center, actionBlock: @escaping block) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = textAlignment
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        let buttonFrame = CGRect(x: 0, y: 0, width: title.ex.size.width, height: title.ex.size.height)
        button.frame = buttonFrame
        button.ex.whenClick(event: .touchUpInside, callback: actionBlock)
        return UIBarButtonItem(customView: button)
        
    }
    
   
}

