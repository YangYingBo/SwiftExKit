//
//  Data+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/30/20.
//

import Foundation
import CommonCrypto

extension Data: SwiftExKitCompatible {}

public extension SwiftExKit where Base == Data {
    /// 字节数组
    var bytes: [UInt8] {
        return [UInt8](self.base)
    }
    
    
    // MARK: Data转成十六进制字符串
    func convertDataToHexStr() -> String {
        
        if self.base.count == 0 {
            return ""
        }
        var dataHexString = ""
        for bytes in self.base {
            
            let hexString = String(format: "%0x", bytes)
            if hexString.count == 2 {
                dataHexString.append(hexString)
            } else {
                dataHexString.append("0\(hexString)")
            }
        }
        
        return dataHexString
    }
    
    var jsonValue: Any? {
        return  try? JSONSerialization.jsonObject(with: self.base, options: .allowFragments)
    }
    
    static func data(_ pathName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: pathName, ofType: "") else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    
    
    
    // MARK: - 加密
    /// MD5
    func md5Data() -> Data {
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        var bytes = [UInt8](self.base)
        CC_MD5(&bytes, CC_LONG(self.base.count), result)
        return Data(bytes: result, count: Int(CC_MD5_DIGEST_LENGTH))
    }
    
    func md5String() -> String {
        let disges = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        let bytes = [UInt8](self.base)
        CC_MD5(bytes, CC_LONG(self.base.count), result)
        let md5String = NSMutableString()
        for index in 0..<disges {
            md5String.appendFormat("%02x", result[index])
        }
        return md5String as String
        
    }
    
    /// SHA1
    func sha1Data() -> Data {
        let disges = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA1(&bytes, CC_LONG(self.base.count), result)
        return Data(bytes: result, count: disges)
    }
    
    func sha1String() -> String {
        let disges = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA1(&bytes, CC_LONG(self.base.count), result)
        let md5String = NSMutableString()
        for index in 0..<disges {
            md5String.appendFormat("%02x", result[index])
        }
        return md5String as String
    }
    
    /// SHA224
    func sha224Data() -> Data {
        let disges = Int(CC_SHA224_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA224(&bytes, CC_LONG(self.base.count), result)
        return Data(bytes: result, count: disges)
    }
    
    func sha224String() -> String {
        let disges = Int(CC_SHA224_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA224(&bytes, CC_LONG(self.base.count), result)
        let md5String = NSMutableString()
        for index in 0..<disges {
            md5String.appendFormat("%02x", result[index])
        }
        return md5String as String
    }
    /// SHA256
    func sha256Data() -> Data {
        let disges = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA256(&bytes, CC_LONG(self.base.count), result)
        return Data(bytes: result, count: disges)
    }
    
    func sha256String() -> String {
        let disges = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA256(&bytes, CC_LONG(self.base.count), result)
        let md5String = NSMutableString()
        for index in 0..<disges {
            md5String.appendFormat("%02x", result[index])
        }
        return md5String as String
    }
    /// SHA384
    func sha384Data() -> Data {
        let disges = Int(CC_SHA384_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA384(&bytes, CC_LONG(self.base.count), result)
        return Data(bytes: result, count: disges)
    }
    
    func sha384String() -> String {
        let disges = Int(CC_SHA384_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA384(&bytes, CC_LONG(self.base.count), result)
        let md5String = NSMutableString()
        for index in 0..<disges {
            md5String.appendFormat("%02x", result[index])
        }
        return md5String as String
    }
    /// SHA512
    func sha512Data() -> Data {
        let disges = Int(CC_SHA512_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA512(&bytes, CC_LONG(self.base.count), result)
        return Data(bytes: result, count: disges)
    }
    
    func sha512String() -> String {
        let disges = Int(CC_SHA512_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        var bytes = [UInt8](self.base)
        CC_SHA512(&bytes, CC_LONG(self.base.count), result)
        let md5String = NSMutableString()
        for index in 0..<disges {
            md5String.appendFormat("%02x", result[index])
        }
        return md5String as String
    }
    
    
    // MARK: HMAC md5 加密
    func HMACMd5String(_ key: String) -> String {
        let disges = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        let bytes = [UInt8](self.base)
        let cKey = key.cString(using: .utf8)
        let lenght = key.lengthOfBytes(using: .utf8)
        CCHmac(CCHmacAlgorithm(kCCHmacAlgMD5), cKey, lenght, bytes, self.base.count, result)
        let md5String = NSMutableString()
        for index in 0..<disges {
            md5String.appendFormat("%02x", result[index])
        }
        return md5String as String
    }
    
    func HMACMd5Data(_ key: String) -> Data {
        let disges = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: disges)
        let bytes = [UInt8](self.base)
        let cKey = key.cString(using: .utf8)
        let lenght = key.lengthOfBytes(using: .utf8)
        CCHmac(CCHmacAlgorithm(kCCHmacAlgMD5), cKey, lenght, bytes, self.base.count, result)
        return Data(bytes: result, count: disges)
    }
    
    func convertBytesString() -> String {
        var hexString = ""
        for item in self.base {
            let hexS = String(format: "%x", item & 0xFF)
            if hexS.count == 2 {
                hexString += hexS
            } else {
                hexString += "0\(hexS)"
            }
        }
        return hexString
    }
    
}
