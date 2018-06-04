//
//  Extension_Date.swift
//  My Health Companion
//
//  Created by agilemac-30 on 29/11/17.
//  Copyright © 2017 agile-m-32. All rights reserved.
//

import Foundation


extension Date {
    
    static func getDates(forLastNDays nDays: Int,formate:String,currentDate:Date) -> [String] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: currentDate)
        
        var arrDates = [String]()
        
        for _ in 1 ... nDays {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = formate
            let dateString = dateFormatter.string(from: date)
            arrDates.append(dateString)
        }
        //print(arrDates)
        return arrDates
    }
    
    func getDateStringFromDate(_ format: String) -> String
    {
        let dateformatter = DateFormatter()
        //dateformatter.locale = Locale.init(identifier: "en_GB")
       // dateformatter.timeZone = TimeZone(abbreviation: "UTC")
        //TimeZone.current
        dateformatter.timeZone = TimeZone.current //TimeZone(identifier: "UTC")
        if TARGET_OS_SIMULATOR == 1    {
            
            dateformatter.timeZone = TimeZone(identifier: "UTC")
        }
        
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "EEEEE"
        return formatter.string(from: self as Date)
    }
    
    func pastWeekDays(_ startDate: Date) -> [Date] {
        var startDate = startDate
        let calendar = Calendar.current
        var aryDates : [Date] = []
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        while startDate <= Date() {
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            aryDates.append(startDate)
            
        }
        return aryDates
    }
}


extension String {
    
    func getDate(_ format: String) -> Date?
    {
        let dateFormatter = DateFormatter()
       
        //TimeZone.current
        dateFormatter.timeZone = TimeZone.current //TimeZone(identifier: "UTC")
        if TARGET_OS_SIMULATOR == 1    {
            
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
        }
        
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    
    func getDateString(_ inFormat: String, outFormat: String) -> String {
        if let date = self.getDate(inFormat) {
            if let dateString = date.getDateStringFromDate(outFormat) as String? {
                return dateString
            }
            else {
                return ""
            }
        }
        else {
            return ""
        }
    }
    
    func getPreviousDay(_ formate: String) -> Date? {
        let calendar = Calendar.current
        if let backDate = calendar.date(byAdding: .day, value: -1, to: self.getDate(formate)!) {
            return backDate
        }
        else {
            return Date()
        }
    }
    
    func getNextDay(_ formate: String) -> Date? {
        let calendar = Calendar.current
        if let backDate = calendar.date(byAdding: .day, value: 1, to: self.getDate(formate)!) {
            return backDate
        }
        else {
            return Date()
        }
    }
    
    func getDateComponent(_ formate: String) -> DateComponents? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        if let date = formatter.date(from: self) {
            let calendar = Calendar.current
            if let components = calendar.dateComponents([.year, .month , .day], from: date) as DateComponents? {
                return components
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
}
