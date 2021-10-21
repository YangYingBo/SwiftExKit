//
//  Date+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/30/20.
//  日期

import Foundation

extension Date: SwiftExCompatible {}

public extension SwiftExKit where Base == Date {
    /// 年
    var year: Int {
        return Calendar.current.component(.year, from: self.base)
    }
    /// 月
    var month: Int {
        return Calendar.current.component(.month, from: self.base)
    }
    /// 日
    var day: Int {
        return Calendar.current.component(.day, from: self.base)
    }
    /// 小时
    var hour: Int {
        return Calendar.current.component(.hour, from: self.base)
    }
    /// 分
    var minute: Int {
        return Calendar.current.component(.minute, from: self.base)
    }
    /// 秒
    var second: Int {
        return Calendar.current.component(.second, from: self.base)
    }
    /// 纳秒
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self.base)
    }
    /// 工作日
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self.base)
    }
    /// 工作日顺序
    var weekdayOrdinal: Int {
        return Calendar.current.component(.weekdayOrdinal, from: self.base)
    }
    /// 月第几个周
    var weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: self.base)
    }
    /// 年第几个周
    var weekOfYear: Int {
        return Calendar.current.component(.weekOfYear, from: self.base)
    }
    
    var yearForWeekOfYear: Int {
        return Calendar.current.component(.yearForWeekOfYear, from: self.base)
    }
    /// 季度
    var quarter: Int {
        return Calendar.current.component(.quarter, from: self.base)
    }
    /// 闰年
    var isLeapYear: Bool {
        let year = self.year
        return ((year % 400) == 0 || ((year % 100) != 0 && (year % 4) == 0))
        
    }
    /// 是否是今天
    var isToday: Bool {
        
        return Calendar.current.isDateInToday(self.base)
    }
    /// 是否是昨天
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self.base)
    }
    /// 是否是明天
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self.base)
    }
    /// 是否是双休日
    var isWeekend: Bool {
        return Calendar.current.isDateInWeekend(self.base)
    }
    
    
    /// 加多少年
    func dateByAddingYears(_ years: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: years, to: self.base)
    }
    
    /// 加多少月
    func dateByAddingMonths(_ months: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: months, to: self.base)
    }
    
    /// 加多少星期
    func dateByAddingWeeks(_ weeks: Int) -> Date? {
        return Calendar.current.date(byAdding: .weekOfYear, value: weeks, to: self.base)
    }
    
    /// 加多少天
    func dateByAddingDays(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self.base)
    }
    
    /// 加多少小时
    func dateByAddingHours(_ hours: Int) -> Date? {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self.base)
    }
    
    /// 加多少分钟
    func dateByAddingMinutes(_ minutes: Int) -> Date? {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self.base)
    }
    
    /// 加多少秒
    func dateByAddingSeconds(_ senconds: Int) -> Date? {
        return Calendar.current.date(byAdding: .second, value: senconds, to: self.base)
    }
    
    /// 时间转字符串
    func stringWithFormat(_ format: String, locale: Locale = Locale.current, timezone: TimeZone = TimeZone.current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timezone
        
        return formatter.string(from: self.base)
    }
    
    /// 字符串转时间
    static func dateWithString(_ dateString: String, format: String, timezone: TimeZone = TimeZone.current, locale: Locale = Locale.current) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timezone
        
        return formatter.date(from: dateString)
    }
    
    /// 时间戳转字符串时间
    static func stringWithTimeInterval(_ interval: TimeInterval, format: String) -> String {
        let date = Date(timeIntervalSince1970: interval)
        return date.swe.stringWithFormat(format)
        
    }
    
    /// 字符串时间转时间戳
    static func timeIntervalWith(_ dateString: String, format: String) -> TimeInterval? {
        let date = self.dateWithString(dateString, format: format)
        return date?.timeIntervalSince1970
    }
    /// 字符串时间距离现在多长时间
    static func timeIntervalSinceNowWith(_ dateString: String, format: String) -> TimeInterval? {
        let date = self.dateWithString(dateString, format: format)
        return date?.timeIntervalSinceNow
    }
    
    /// 比较两个字符串时间相差多少
    static func timeIntervalDifferenceWith(_ someDateString: String, antherDateString: String, format: String) -> TimeInterval? {
        let oneDate = self.dateWithString(someDateString, format: format)
        let twoDate = self.dateWithString(antherDateString, format: format)
        let oneTimeInterval = oneDate?.timeIntervalSince1970
        let twoTimeInterval = twoDate?.timeIntervalSince1970
        return ((oneTimeInterval ?? 0 ) - (twoTimeInterval ?? 0))
    }
}
