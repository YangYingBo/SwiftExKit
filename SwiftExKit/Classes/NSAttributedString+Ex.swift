//
//  NSAttributedString+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 1/8/21.
//

import UIKit
import Foundation

public extension SwiftExKit where Base: NSMutableAttributedString {
    
    /// 设置字体
    func setFont(_ font: UIFont, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.font, value: font, range: range)
    }
    
    /// 字体间距
    func setKern(_ kern: CGFloat, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.kern, value: kern, range: range)
    }
    /// 设置颜色
    func setColor(_ color: UIColor, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.foregroundColor, value: color, range: range)
    }
    /// 设置背景颜色
    func setBackgroundColor(_ color: UIColor, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.backgroundColor, value: color, range: range)
    }
    /// 设置字体线条宽度 默认 0
    func setStrokeWidth(_ width: CGFloat, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.strokeWidth, value: width, range: range)
    }
    /// 设置阴影
    func setShadow(_ shadow: NSShadow, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.shadow, value: shadow, range: range)
    }
    /// 设置删除线样式
    func setStrikethroughStyle(_ style: NSUnderlineStyle, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.strikethroughStyle, value: style.rawValue, range: range)
    }
    /// 设置删除线颜色
    func setStrikethroughColor(_ color: UIColor, rang: NSRange) -> SwiftExKit {
        return self.setAttribute(.strikethroughColor, value: color, range: rang)
    }
    /// 设置下划线样式
    func setUnderlineStyle(_ style: NSUnderlineStyle, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.underlineStyle, value: style.rawValue, range: range)
    }
    /// 设置下划线颜色
    func setUnderlineColor(_ color: UIColor, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.underlineColor, value: color, range: range)
    }
    /// 
    func setLigature(_ ligature: NSInteger, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.ligature, value: ligature, range: range)
    }
    /// 文字效果风格
    func setTextEffect(_ textStyle: NSAttributedString.TextEffectStyle, range: NSRange) -> SwiftExKit {
        
        return self.setAttribute(.textEffect, value: textStyle.rawValue as NSString, range: range)
    }
    /// 设置字体斜度
    func setObliqueness(_ obliqueness: CGFloat, range: NSRange) -> SwiftExKit {
        return self.setAttribute(.obliqueness, value: obliqueness, range: range)
    }
    /// 应用于符号的扩展因子的对数
    func setExpansion(_ expansion: CGFloat, range: NSRange) -> SwiftExKit {
        return setAttribute(.expansion, value: expansion, range: range)
    }
    /// 从基线的偏移量
    func setBaselineOffset(_ baselineOffset: CGFloat, range: NSRange) -> SwiftExKit {
        return setAttribute(.baselineOffset, value: baselineOffset, range: range)
    }
    /// 0表示水平文本。1表示垂直文本
    func setVerticalGlyphForm(_ verticalGlyphForm: Bool, range: NSRange) -> SwiftExKit {
        setAttribute(.verticalGlyphForm, value: verticalGlyphForm, range: range)
    }
    /// 指定文本语言
    func setLanguage(_ language: String, range: NSRange) -> SwiftExKit {
        setAttribute(kCTLanguageAttributeName as NSAttributedString.Key, value: language, range: range)
    }
    /// 控制字符可以通过屏蔽NSWritingDirection和NSWritingDirectionFormatType值来获得
    func setWritingDirection(_ writingDirection: NSArray, range: NSRange) -> SwiftExKit {
        setAttribute(.writingDirection, value: writingDirection, range: range)
    }
    /// 段落样式
    func setParagraphStyle(_ style: NSParagraphStyle, range: NSRange) -> SwiftExKit {
        setAttribute(.paragraphStyle, value: style, range: range)
    }
    /// 设置链接  link -- NSURL (preferred) or NSString
    func setLink(_ link: Any, range: NSRange) -> SwiftExKit {
        setAttribute(.link, value: link, range: range)
    }
    /// 设置富文本样式属性
    func setAttribute(_ values: [NSAttributedString.Key:Any], range:NSRange) -> SwiftExKit {
        self.base.addAttributes(values, range: range)
        return self
    }
    /// 设置富文本样式属性
    func setAttribute(_ key: NSAttributedString.Key, value: Any, range:NSRange) -> SwiftExKit {
        self.base.addAttribute(key, value: value, range: range)
        return self
    }
    
}
