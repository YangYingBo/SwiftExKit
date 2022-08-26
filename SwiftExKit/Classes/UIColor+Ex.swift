//
//  UIColor+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/28/20.
//  UIColor 拓展

import UIKit

public extension SwiftExKit where Base: UIColor {
    
    // MARK: 十六进制色值转UIColor
    static func color(_ hex: String) -> UIColor {
        var noHashString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if noHashString.hasPrefix("#") {
            noHashString = noHashString.replacingOccurrences(of: "#", with: "")
        }
        
        if noHashString.hasPrefix("0X") {
            noHashString = noHashString.replacingOccurrences(of: "0X", with: "")
        }
        
        if noHashString.count < 6 {
            return .clear
        }
        
        let scanner = Scanner(string: noHashString)
        
        var hexInt: UInt32 = 0
        if #available(iOS 13.0, *) {
            hexInt = UInt32(scanner.scanInt32(representation:.hexadecimal) ?? 0)
        } else {
            scanner.scanHexInt32(&hexInt)

        }
        
        let red = (hexInt >> 16) & 0xFF
        let green = (hexInt >> 8) & 0xFF
        let blue = (hexInt) & 0xFF
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
        
    }
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    // MARK: 随机色
    static func randomColor() -> UIColor {
        let randomRed = CGFloat((arc4random()%255))/255.0;
        let randomGreen = CGFloat((arc4random()%255))/255.0;
        let randomBlue = CGFloat((arc4random()%255))/255.0;
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    // MARK 十六进制RGB转UIColor
    static func color(rgbValue: UInt32) -> UIColor {
        return UIColor(red: CGFloat(((rgbValue & 0xFF0000) >> 16) / 255),
                       green: CGFloat(((rgbValue & 0xFF00) >> 8) / 255),
                        blue: CGFloat(((rgbValue & 0xFF) >> 0) / 255),
                                      alpha: 1)
    }
    // MARK 十六进制RGBA转UIColor
    static func color(rgbaValue: UInt32) -> UIColor {
        return UIColor(red: CGFloat(((rgbaValue & 0xFF000000) >> 24) / 255),
                       green: CGFloat(((rgbaValue & 0xFF0000) >> 16) / 255),
                        blue: CGFloat(((rgbaValue & 0xFF00) >> 8) / 255),
                                      alpha: CGFloat(((rgbaValue & 0xFF) >> 0) / 255))
    }
    // MARK: 获取颜色rgb数值
    var rgbValue: UInt32 {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.base.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let red = UInt(r * 255)
        let green = UInt(g * 255)
        let blue = UInt(b * 255)
        
        return UInt32((red << 16) + (green << 8) + blue)
     
    }
    // MARK: 获取颜色rgba数值
    var rgbaValue: UInt32 {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        self.base.getRed(&r, green: &g, blue: &b, alpha: &a)

        let red = UInt(r * 255)
        let green = UInt(g * 255)
        let blue = UInt(b * 255)
        let alpha = UInt(a * 255)
        let rgb = (red << 24) + (green << 16) + (blue << 8) + alpha
        
        return UInt32(rgb)

    }

}

