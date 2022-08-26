//
//  NSBundle+Ex.swift
//  TBExKit
//
//  Created by yangyb on 2022/8/8.
//

import Foundation

private var TBBundleKey: UInt8 = 0

final class TBBundleExtension: Bundle {

     override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return (objc_getAssociatedObject(self, &TBBundleKey) as? Bundle)?.localizedString(forKey: key, value: value, table: tableName) ?? super.localizedString(forKey: key, value: value, table: tableName)
    }
}

//extension Bundle {
//    /// 替换类
//    static let once: Void = { object_setClass(Bundle.main, type(of: TBBundleExtension())) }()
//    /// 设置语言
//    static func set(language: String, normal: String = "en") {
//        Bundle.once
//        let isLanguageRTL = Locale.characterDirection(forLanguage: language) == .rightToLeft
//        UIView.appearance().semanticContentAttribute = isLanguageRTL == true ? .forceRightToLeft : .forceLeftToRight
//        UserDefaults.standard.set(isLanguageRTL,   forKey: "AppleTextDirection")
//        UserDefaults.standard.set(isLanguageRTL,   forKey: "NSForceRightToLeftWritingDirection")
////        UserDefaults.standard.set([language], forKey: "AppleLanguages")
//        UserDefaults.standard.setValue(language, forKey: "TBCurrentLang")
//        UserDefaults.standard.synchronize()
//        // 没有适配当前语言 默认英文
//        let path = Bundle.main.path(forResource: language, ofType: "lproj") ??  Bundle.main.path(forResource: normal, ofType: "lproj")
//        guard let path = path else {
//            return
//        }
//        objc_setAssociatedObject(Bundle.main, &TBBundleKey, Bundle(path: path), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    }
//
//}

public extension SwiftExKit where Base: Bundle {
    
    /// app名称
    static var displayName: String {
        if let value = self.info["CFBundleDisplayName"] as? String {
            return value
        }
        return ""
    }
    /// app版本
    static var shortVersionString: String {
        if let value = self.info["CFBundleShortVersionString"] as? String {
            return value
        }
        return ""
    }
    /// app build版本
    static var bundleVersion: String {
        if let value = self.info["CFBundleVersion"] as? String {
            return value
        }
        return ""
    }
    
    /// app 证书名字
    static var bundleIdentifier: String {
        if let value = self.info["CFBundleIdentifier"] as? String {
            return value
        }
        return ""
    }
    
    /// 当前App的发行地区
    static var developmentRegion: String {
        if let value = self.info["CFBundleDevelopmentRegion"] as? String {
            return value
        }
        return ""
    }
    /// App信息
    static var info: [String: Any] {
        return Bundle.main.infoDictionary ?? [String: Any]()
    }
    
    
    /**
     语言适配信息
     Bundle.main.preferredLocalizations[0] 获取到的是系统首选的语言, 第一个为手机推荐的语言(在APP没有适配当前手机设置的语言时 手机系统按照首选语言列表顺序向下找, 直到遇见APP本地适配语言终止,把找到的APP本地适配的语言返回 如果没有找到就返回英文) 如果APP对多语言适配没有具体要求时推荐用这个作为获取当前设备语言的API或者（UIDevice.ex.deviceLanguage）
     
     Bundle.main.localizations APP本地适配的语言列表
     
     UserDefaults.standard.value(forKey: "AppleLanguages")[0] 手机设置的首选语言列表第一个为当前手机语言, 如果想获取到设备真实设置的语言推荐用这个API获取或者（UIDevice.ex.currentLanguage）
     */
    
    /// 设置语言
    static func set(language: String, normal: String = "en") {
        once
        let isLanguageRTL = Locale.characterDirection(forLanguage: language) == .rightToLeft
        UIView.appearance().semanticContentAttribute = isLanguageRTL == true ? .forceRightToLeft : .forceLeftToRight
        UserDefaults.standard.set(isLanguageRTL,   forKey: "AppleTextDirection")
        UserDefaults.standard.set(isLanguageRTL,   forKey: "NSForceRightToLeftWritingDirection")
//        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.setValue(language, forKey: "TBCurrentLang")
        UserDefaults.standard.synchronize()
        // 没有适配当前语言 默认英文
        let path = Bundle.main.path(forResource: language, ofType: "lproj") ??  Bundle.main.path(forResource: normal, ofType: "lproj")
        guard let path = path else {
            return
        }
        objc_setAssociatedObject(Bundle.main, &TBBundleKey, Bundle(path: path), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    /// 替换类
    static var once: Void { object_setClass(Bundle.main, type(of: TBBundleExtension())) }
}
