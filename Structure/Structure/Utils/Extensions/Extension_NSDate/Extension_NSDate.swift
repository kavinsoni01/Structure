//
//  Extension_NSDate.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 22/06/17.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation

extension Date {
	
	// MARK:- APP SPECIFIC FORMATS
	
    var tenDaysfromNow: Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: 10, to: Date(), options: [])!
    }
    
    func app_getNextDatefromNow(nextdaysCount:Int,currentDate:Date) -> Date
    {
        
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: nextdaysCount, to: currentDate, options: [])!
        
    }
    func app_getPreviousDatefromNow(previousdaysCount:Int,currentDate:Date) -> Date
    {
        
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: -(previousdaysCount), to: currentDate, options: [])!
        
    }
    
	func app_dateFromString(strDate:String, format:String) -> Date? {
		
		let dateFormatter:DateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		if let dtDate = dateFormatter.date(from: strDate){
			return dtDate as Date?
		}
		return nil
	}
    
    func getDateInString(GetDateformate:String,date:Date,currentFormate:String)->String
    {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        
        
        formatter.timeZone = TimeZone.current //TimeZone(identifier: "UTC")
        if TARGET_OS_SIMULATOR == 1    {
            
            formatter.timeZone = TimeZone(identifier: "UTC")
        }
        
        if currentFormate == ""
        {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        else
        {
            //"dd-MMM-yyyy"
            
            formatter.dateFormat = currentFormate
        }
        
        
        let myString = formatter.string(from: date)
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = GetDateformate
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
	
	
	func app_stringFromDate() -> String{
		let dateFormatter:DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		let strdt = dateFormatter.string(from: self as Date)
		if let dtDate = dateFormatter.date(from: strdt){
			return dateFormatter.string(from: dtDate)
		}
		return "--"
	}
	
	func app_stringFromDate_notification() -> String{
		return "\(self.monthNameShort) \(self.dayTwoDigit), \(self.yearFourDigit)"
	}

	func getUTCFormateDate(localDate: NSDate) -> String {
		
		let dateFormatter:DateFormatter = DateFormatter()
		let timeZone: NSTimeZone = NSTimeZone(name: "UTC")!
		dateFormatter.timeZone = timeZone as TimeZone!
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
		let dateString: String = dateFormatter.string(from: localDate as Date)
		return dateString
	}
	
	
	func combineDateWithTime(date: NSDate, time: NSDate) -> NSDate? {
		let calendar = NSCalendar.current
		
		
		let dateComponents = calendar.dateComponents([.year, .month, .day], from: date as Date)
		
		let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time as Date)
		
		
		let mergedComponments = NSDateComponents()
		mergedComponments.year = dateComponents.year!
		mergedComponments.month = dateComponents.month!
		mergedComponments.day = dateComponents.day!
		mergedComponments.hour = timeComponents.hour!
		mergedComponments.minute = timeComponents.minute!
		mergedComponments.second = timeComponents.second!
		
		return calendar.date(from: mergedComponments as DateComponents) as NSDate?
	}
	
	func getDatesBetweenDates(startDate:NSDate, andEndDate endDate:NSDate) -> [NSDate] {
		let gregorian: NSCalendar = NSCalendar.current as NSCalendar;
		let components = gregorian.components(NSCalendar.Unit.day, from: startDate as Date, to: endDate as Date, options: [])
		var arrDates = [NSDate]()
		for i in 0...components.day!{
			arrDates.append(startDate.addingTimeInterval(60*60*24*Double(i)))
		}
		return arrDates
	}
	
	
	func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
		//Declare Variables
		var isGreater = false
		
		//Compare Values
		if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
			isGreater = true
		}
		
		//Return Result
		return isGreater
	}
	
	func isLessThanDate(dateToCompare: Date) -> Bool {
		//Declare Variables
		var isLess = false
		
		//Compare Values
		if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
			isLess = true
		}
		
		//Return Result
		return isLess
	}
	
	func equalToDate(dateToCompare: NSDate) -> Bool {
		//Declare Variables
		var isEqualTo = false
		
		//Compare Values
		if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
			isEqualTo = true
		}
		
		//Return Result
		return isEqualTo
	}
	
//	func isEqualToDateWithoutTime(dateToCompareWith:NSDate) -> Bool {
//		if(self.dayTwoDigit_Int == dateToCompareWith.dayTwoDigit_Int &&
//			self.monthTwoDigit_Int == dateToCompareWith.monthTwoDigit_Int &&
//			self.yearFourDigit_Int == dateToCompareWith.yearFourDigit_Int){
//			return true
//		}else{
//			return false
//		}
//	}
	
	
	// MARK:- TIME
	var timeWithAMPM: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mma"
		dateFormatter.amSymbol = "am"
		dateFormatter.pmSymbol = "pm"
		return dateFormatter.string(from: self as Date)
	}
	
	
	
	
	// MARK:- YEAR
	
	
	var yearFourDigit_Int: Int {
		return Int(self.yearFourDigit)!
	}
	
	var yearOneDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "y"
		return dateFormatter.string(from: self as Date)
	}
	var yearTwoDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yy"
		return dateFormatter.string(from: self as Date)
	}
	var yearFourDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy"
		return dateFormatter.string(from: self as Date)
	}
	
	
	
	// MARK:- MONTH
	
	var monthOneDigit_Int: Int {
		return Int(self.monthOneDigit)!
	}
	var monthTwoDigit_Int: Int {
		return Int(self.monthTwoDigit)!
	}
	
	
	var monthOneDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "M"
		return dateFormatter.string(from: self as Date)
	}
	var monthTwoDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM"
		return dateFormatter.string(from: self as Date)
	}
	var monthNameShort: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM"
		return dateFormatter.string(from: self as Date)
	}
	var monthNameFull: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM"
		return dateFormatter.string(from: self as Date)
	}
	var monthNameFirstLetter: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMMM"
		return dateFormatter.string(from: self as Date)
	}
	
	// MARK:- DAY
	
	var dayOneDigit_Int: Int {
		return Int(self.dayOneDigit)!
	}
	var dayTwoDigit_Int: Int {
		return Int(self.dayTwoDigit)!
	}
	
	var dayOneDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "d"
		return dateFormatter.string(from: self as Date)
	}
	var dayTwoDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd"
		return dateFormatter.string(from: self as Date)
	}
	var dayNameShort: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "E"
		return dateFormatter.string(from: self as Date)
	}
	var dayNameFull: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE"
		return dateFormatter.string(from: self as Date)
	}
	var dayNameFirstLetter: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEEE"
		return dateFormatter.string(from: self as Date)
	}
	
	
	
	
	// MARK:- AM PM
	var AM_PM: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "a"
		return dateFormatter.string(from: self as Date)
	}
	
	// MARK:- HOUR
	
	
	var hourOneDigit_Int: Int {
		return Int(self.hourOneDigit)!
	}
	var hourTwoDigit_Int: Int {
		return Int(self.hourTwoDigit)!
	}
	var hourOneDigit24Hours_Int: Int {
		return Int(self.hourOneDigit24Hours)!
	}
	var hourTwoDigit24Hours_Int: Int {
		return Int(self.hourTwoDigit24Hours)!
	}
	var hourOneDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h"
		return dateFormatter.string(from: self as Date)
	}
	var hourTwoDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "hh"
		return dateFormatter.string(from: self as Date)
	}
	var hourOneDigit24Hours: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "H"
		return dateFormatter.string(from: self as Date)
	}
	var hourTwoDigit24Hours: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH"
		return dateFormatter.string(from: self as Date)
	}
	
	// MARK:- MINUTE
	
	var minuteOneDigit_Int: Int {
		return Int(self.minuteOneDigit)!
	}
	var minuteTwoDigit_Int: Int {
		return Int(self.minuteTwoDigit)!
	}
	
	var minuteOneDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "m"
		return dateFormatter.string(from: self as Date)
	}
	var minuteTwoDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "mm"
		return dateFormatter.string(from: self as Date)
	}
	
	
	// MARK:- SECOND
	
	var secondOneDigit_Int: Int {
		return Int(self.secondOneDigit)!
	}
	var secondTwoDigit_Int: Int {
		return Int(self.secondTwoDigit)!
	}
	
	var secondOneDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "s"
		return dateFormatter.string(from: self as Date)
	}
	var secondTwoDigit: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "ss"
		return dateFormatter.string(from: self as Date)
	}
	
	
}
