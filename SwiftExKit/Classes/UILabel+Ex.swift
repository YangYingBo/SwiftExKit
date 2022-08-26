//
//  UILabel+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/28/20.
//

import UIKit

public extension SwiftExKit where Base: UILabel {
    // MARK: - 创建Label
    static func label(_ text: String, fontSize: CGFloat, textColor: UIColor = UIColor.black) -> UILabel {
        return label(text, fontSize: fontSize, textColor: textColor, textAlignment: .left, numberOfLines: 1)
    }
    
    static func label(_ text: String,
                      fontSize: CGFloat,
                      textColor: UIColor,
                      textAlignment: NSTextAlignment,
                      numberOfLines: Int) -> UILabel {
        
        return label(text, font: UIFont.systemFont(ofSize: fontSize), textColor: textColor, textAlignment: textAlignment, numberOfLines: numberOfLines)
        
    }
    
    static func label(_ text: String,
                      font: UIFont,
                      textColor: UIColor,
                      textAlignment: NSTextAlignment,
                      numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = font
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
        
    }
}
