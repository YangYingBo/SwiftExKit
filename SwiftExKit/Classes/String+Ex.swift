//
//  String+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/30/20.
//

import Foundation
import UIKit

extension String: SwiftExKitCompatible {}


public extension SwiftExKit where Base == String {
    
    /// 多语言适配
    var locale: String {
        NSLocalizedString(self.base, comment: "")
    }
    
    // MARK: - 获取字符串大小
    /// 获取字符串 字体高度
    func height(_ font: UIFont) -> CGFloat {
        return self.size(font).height
    }
    /// 字符串默认字体高度
    var height: CGFloat {
        return self.height(UIFont.systemFont(ofSize: 17))
    }
    
    /// 获取字体宽度
    func width(_ font: UIFont) -> CGFloat {
        return self.size(font).width
    }
    /// 字符串默认字符串宽度
    var width: CGFloat {
        return self.width(UIFont.systemFont(ofSize: 17))
    }
    /// 获取字体size
    func size(_ font: UIFont) -> CGSize {
        return self.size(font, size: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)))
    }
    /// 字符串默认字体size
    var size: CGSize {
        return self.size(UIFont.systemFont(ofSize: 17))
    }
    
    /// 根据size获取字体size
    func size(_ font: UIFont, size: CGSize) -> CGSize {
        return self.base.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:font], context: nil).size
    }
    /// base64解码
    var base64Decoded: String? {
        let remainder = self.base.count % 4

        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }

        guard let data = Data(base64Encoded: self.base + padding,
                              options: .ignoreUnknownCharacters) else { return nil }

        return String(data: data, encoding: .utf8)
    }
    /// base64编码
    var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = self.base.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    /// 是否含有Emoji表情符
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in self.base.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x1F1E6...0x1F1FF, // Regional country flags
            0x2600...0x26FF, // Misc symbols
            0x2700...0x27BF, // Dingbats
            0xE0020...0xE007F, // Tags
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            127000...127600, // Various asian characters
            65024...65039, // Variation selector
            9100...9300, // Misc items
            8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
    // MARK: - 截取
    func range(_ range: Range<Int>) -> String {
        return self.base[range]
    }
    
    // MARK: - 替换
    func replacingOccurrences(of target: String, with replacement: String) -> String {
        if self.base.isEmpty {
            return ""
        }
        return (self.base as NSString).replacingOccurrences(of: target, with: replacement)
    }
    
    func replacingCharacters(in range: NSRange, with replacement: String) -> String {
        if self.base.isEmpty {
            return ""
        }
        
        return (self.base as NSString).replacingCharacters(in: range, with: replacement)
    }
    
    // MARK: - 获取数值
    // 获取整数数值
    var intValue: Int? {
        
        let scanner = Scanner(string: self.base)
        let value = UnsafeMutablePointer<Int>.allocate(capacity: 0)
        let reuslt = scanner.scanInt(value)
        
        return reuslt ? value.pointee : nil
    }
    
    // 获取小数数值
    var floatValue: Float? {
        
        let scanner = Scanner(string: self.base)
        if #available(iOS 13.0, *) {
            return scanner.scanFloat()
        } else {
            let value = UnsafeMutablePointer<Float>.allocate(capacity: 0)
            let result = scanner.scanFloat(value)
            return result ? value.pointee : nil
        }
        
        
    }
    // 获取小数数值
    var doubleValue: Double? {
        
        let scanner = Scanner(string: self.base)
        if #available(iOS 13.0, *) {
            return scanner.scanDouble()
        } else {
            let value = UnsafeMutablePointer<Double>.allocate(capacity: 0)
            let result = scanner.scanDouble(value)
            return result ? value.pointee : nil
        }
        
    }
    // 获取Bool
    var boolValue: Bool {
        guard let intV = self.intValue else {
            return false
        }
        return intV != 0
    }
    // MARK: - 转成十六进制的Data
    var convertBytes: Data {
        var data = Data()
        for index in stride(from: 0, to: self.base.count, by: 2) {
            let hexStr = self.base[index..<(index + 2)]
            var byte = UInt8(hexStr, radix: 16) ?? 00
            data.append(&byte, count: 1)
            
        }
        
        return data
    }
    
    // 字符串转Date
    func dateFormFormatter(_ formatter: String) -> Date? {
        let format = DateFormatter()
        format.dateFormat = formatter
        return format.date(from: self.base)
        
    }
    
    // MARK: - 正则
    func regex(type: TBRegexFormatType) -> Bool {
        self.regex(type.rawValue)
    }
    
    func regex(_ reg: String) -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@",reg)
        return regex.evaluate(with: self.base)
    }
    
//    func matchsRegex(_ regex: String, options: NSRegularExpression.Options = .caseInsensitive) -> Bool {
//        guard let pattern = try? NSRegularExpression(pattern: regex, options: options) else {
//            return false
//        }
//        YYLog(pattern.numberOfCaptureGroups)
//        pattern.enumerateMatches(in: self.base, options: .reportProgress, range: NSRange(location: 0, length: self.base.count)) { (result, flag, stop) in
//            YYLog(result as Any)
//        }
//
//        return pattern.numberOfMatches(in: self.base, options: .reportProgress, range: NSRange(location: 0, length: self.base.count)) == self.base.count
//    }
    
    // MARK: - 进制转换
    /// 十六进制转十进制
    var hexToInt: Int {
        var str = self.base.uppercased()
        if str.hasPrefix("0X") {
            let length = str.count - 2
            str = str[2,length]
        }
        
        var sum = 0
        for i in str.utf8 {
           sum = sum * 16 + Int(i) - 48 // 0-9 ASCⅡ码从48开始
           if i >= 65 {                 // A-Z ASCⅡ码从65开始，但十六进制A == 10，所以应该是减去55
               sum -= 7
           }
        }
        return sum
    }
    
    /// 十进制转十六进制
    var intToHex: String {
        return String(Int(self.base) ?? 0,radix:16)
    }
    /// 十进制转几个字节的十六进制
    func intToHex(_ num: Int) -> String {
        let hex = self.intToHex
        let fillLength = num * 2 - hex.count
        if fillLength <= 0 { return hex }
        let fillZero = String(repeating: "0", count: fillLength)
        return hex + fillZero
        
    }
    /// 十进制转二进制
    var intToBinary: String {
        return String(Int(self.base) ?? 0,radix:2)
    }
    /// 十进制转几个字节的二进制
    func intToBinary(_ num: Int) -> String {
        let bi = self.intToBinary
        let fillLength = num * 8 - bi.count
        if fillLength <= 0 { return bi }
        let fillZero = String(repeating: "0", count: fillLength)
        return fillZero + bi
    }
    /// 二进制转十进制
    var binaryToInt: Int {
        var sum = 0
        var ll = 0
        
        for index in 0..<self.base.count {
            sum = Int(self.base[index,1]) ?? 0
            sum = sum * Int(powf(2, Float(self.base.count - index - 1)))
            ll += sum
        }
        
        return ll
    }
    /// 二进制转十六进制
    var binaryToHex: String {
        let intValue = self.base.ex.binaryToInt
        let hex = "\(intValue)".ex.intToHex
        return hex.count % 2 == 0 ? hex : "0\(hex)"
    }
    
    /// 十六进制转UInt8
    var hexToUInt8: UInt8 {
        let intValue = self.base.ex.hexToInt
        return UInt8(intValue)
    }
    /// 十六进制转UInt16
    var hexToUInt16: UInt16 {
        let intValue = self.base.ex.hexToInt
        return UInt16(intValue)
    }
    /// 十六进制转UInt32
    var hexToUInt32: UInt32 {
        let intValue = self.base.ex.hexToInt
        return UInt32(intValue)
    }
    
    /// 十六进制转UInt64
    var hexToUInt64: UInt64 {
        let intValue = self.base.ex.hexToInt
        return UInt64(intValue)
    }
    
    // 版本号对比
    func compareVersion(_ newVersion: String) -> Bool {
        
        if newVersion.isEmpty || self.base.isEmpty {
            return false
        }
        
        let new = newVersion.components(separatedBy: ".")
        let old = self.base.components(separatedBy: ".")
        let count = min(new.count, old.count)
        
        for idx in 0..<count {
            let newValue = Int(new[idx]) ?? 0
            let oldValue = Int(old[idx]) ?? 0
            if newValue == oldValue { continue }
            return newValue > oldValue
        }
        
        return false
    }
    
    // MARK: - 加密
    /// 字符串加密
    var md5: String? {
        if self.base.isEmpty { return nil }
        
        let data = self.base.data(using: .utf8)
        return data?.ex.md5String()
    }
    
    var sha1: String? {
        if self.base.isEmpty { return nil }
        let data = self.base.data(using: .utf8)
        return data?.ex.sha1String()
    }
    
    var sha224: String? {
        if self.base.isEmpty { return nil }
        let data = self.base.data(using: .utf8)
        return data?.ex.sha224String()
    }
    
    var sha256: String? {
        if self.base.isEmpty { return nil }
        let data = self.base.data(using: .utf8)
        return data?.ex.sha256String()
    }
    
    var sha384: String? {
        if self.base.isEmpty { return nil }
        let data = self.base.data(using: .utf8)
        return data?.ex.sha384String()
    }
    
    var sha512: String? {
        if self.base.isEmpty { return nil }
        let data = self.base.data(using: .utf8)
        return data?.ex.sha512String()
    }
}

public enum TBRegexFormatType: String {
    /// 邮箱
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    /// 弱密码 任意字母、数字、下划线 长度在6-20之间 (不允许有除此之外的字符)
    case password = "^\\w{6,20}$"
    /// 中强密码 数字、字母、下划线必须包含两个组成 长度在6-20之间 (不允许有除此之外的字符)
    case password1 = "^(?=.*\\d)(?=.*[a-zA-Z_])\\w{6,20}$"
    /// 强密码 必须包含数字、字母/下划线、特殊字符 三种组合，长度在6-20之间
    case password2 = "^(?=.*\\d)(?=.*[a-zA-Z_])(?=.*\\W).{6,20}$"
    /// 纯数字
    case int = "^[0-9]+$"
    /// URL验证
    case URL = "[a-zA-Z_-]+://[^\\s]*"
    /// 手机号码
    case mobile = "^1[0-9]{7,10}$"
}

public extension String {
    /// 下标脚本
    /// 替换和截取
    subscript (range: Range<Int>) -> String {
        get {
            var r = range
            guard r.lowerBound < self.count else{
                return ""
            }
            if r.upperBound > self.count {
                r = r.lowerBound..<self.count
            }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
        set{
            var r = range
            guard r.lowerBound < self.count else{
                return
            }
            if r.upperBound > self.count {
                r = r.lowerBound..<self.count
            }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            self.replaceSubrange(Range(uncheckedBounds: (startIndex, endIndex)), with: newValue)
        }
    }
    
    subscript (closerange: ClosedRange<Int>) -> String {
        get {
            var r = closerange
            guard r.lowerBound < self.count else{
                return ""
            }
            if r.upperBound >= self.count {
                r = r.lowerBound...(self.count - 1)
            }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex...endIndex])
        }
        set{
            var r = closerange
            guard r.lowerBound < self.count else{
                return
            }
            if r.upperBound >= self.count {
                r = r.lowerBound...(self.count - 1)
            }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound+1)
            self.replaceSubrange(Range(uncheckedBounds: (startIndex, endIndex)), with: newValue)
        }
    }
    
    subscript (loc: Int, len: Int) -> String {
        return self[loc..<(loc+len)]
    }
    
}
