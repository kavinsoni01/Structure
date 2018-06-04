//
//  AppExtension.swift
//  Alarm App
//
//  Created by Kavin Soni on 13/12/16.
//  Copyright © 2016 AgileInfoWays Pvt.Ltd. All rights reserved.
//

import Foundation
import UIKit
import Photos


extension UIDevice
{
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}


//extension CALayer {
//
//
//    func addGradientBackground(WithColors color:[UIColor]) -> Void {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = CGRect.init(origin: CGPoint.zero, size: self.bounds.size)
//        gradientLayer.colors = color.map({$0.cgColor})
//        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
//        self.addSublayer(gradientLayer)
//    }
//    func addRoundGradientBackground(WithColors color:[UIColor]) -> Void {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.cornerRadius = self.bounds.size.width/2
//        gradientLayer.frame = CGRect.init(origin: CGPoint.zero, size: self.bounds.size)
//        gradientLayer.colors = color.map({$0.cgColor})
//        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
//
//        let roundRect = CALayer()
//        roundRect.frame = self.bounds
//        roundRect.cornerRadius = self.bounds.size.height/2.0
//        roundRect.masksToBounds = true
//        roundRect.addSublayer(gradientLayer)
//        gradientLayer.mask = roundRect
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.bounds.size.height).cgPath
//        shapeLayer.fillColor = nil
//        shapeLayer.cornerRadius = self.bounds.size.width/2.0
//        shapeLayer.strokeColor = UIColor.clear.cgColor
//
//        self.addSublayer(shapeLayer)
//    }
//
//    func addGradientBorder(WithColors color:[UIColor],Width width:CGFloat = 1) -> Void {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = CGRect.init(origin: CGPoint.zero, size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
//        gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
//        gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
//        gradientLayer.colors = color.map({$0.cgColor})
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.lineWidth = width
//        shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
//        shapeLayer.fillColor = nil
//        shapeLayer.strokeColor = UIColor.black.cgColor
//        gradientLayer.mask = shapeLayer
//
//        self.addSublayer(gradientLayer)
//    }
//
//    //
//    //    func addShadow(Color color:UIColor, View view:UIView) -> Void {
//    //        //  let shapeLayer = CAShapeLayer()
//    //        view.layer.shadowColor = color.cgColor
//    //         view.layer.shadowOpacity = 0.3
//    //
//    //        //self.addSublayer(shapeLayer)
//    //    }
//    //
//
//    func addBorderShadow(Height height:CGFloat, Width width:CGFloat) -> Void {
//
//
//        let shapeLayer = CAShapeLayer()
//
//        shapeLayer.path = UIBezierPath(roundedRect:CGRect (x: 0, y: 0, width: width, height: height), cornerRadius: height/2).cgPath
//        shapeLayer.fillColor = UIColor.appThemePurpleColor().cgColor
//
//        shapeLayer.shadowColor = UIColor .appThemePurpleColor().cgColor
//
//        shapeLayer.shadowPath = shapeLayer.path
//        shapeLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        shapeLayer.shadowOpacity = 0.5
//        shapeLayer.shadowRadius = 2
//
//        // layer.insertSublayer(shadowLayer, at: 0)
//        self.addSublayer(shapeLayer)
//    }
//}


extension UIImage
{
    func resizeImage(withWidth newWidth: CGFloat,withHeight newHeight:CGFloat) -> UIImage {
        
        //let scale = newWidth / image.size.width
        //let newHeight = image.size.height * scale
        //UIGraphicsBeginImageContext(CGSize.init(width: newWidth, height: newHeight))
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: newWidth, height: newHeight), false, 1.0)
        self.draw(in: CGRect.init(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
//extension UIColor
//{
//    class func appRedColor() -> UIColor {
//        return UIColor.init(red: 255/255.0, green: 59/255.0, blue: 47/255.0, alpha: 1.0)
//    }
//    class func appThemeBlueColor() -> UIColor {
//        return UIColor.init(red: 0/255.0, green: 125/255.0, blue: 255/255.0, alpha: 1.0)
//    }
//    class func appGrayColor() -> UIColor {
//        return UIColor.init(red: 110/255.0, green: 114/255.0, blue: 118/255.0, alpha: 1.0)
//    }
////    class func appLightGrayColor() -> UIColor {
////        return UIColor.init(red: 190/255.0, green: 194/255.0, blue: 205/255.0, alpha: 1.0)
////    }
//    class func appDarkGrayColor() -> UIColor {
//        return UIColor.init(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1.0)
//    }
//    class func appBorderGrayColor() -> UIColor {
//        //return UIColor.init(red: 190/255.0, green: 194/255.0, blue: 205/255.0, alpha: 1.0)
//        return UIColor.init(red: 218/255.0, green: 220/255.0, blue: 226/255.0, alpha: 1.0)
//    }
//    class func appLightBlueColor() -> UIColor {
//        return UIColor.init(red: 238/255.0, green: 240/255.0, blue: 248/255.0, alpha: 1.0)
//    }
//    class func appNotificationSuccess() -> UIColor {
//        return UIColor.init(red: 204/255.0, green: 250/255.0, blue: 228/255.0, alpha: 1.0)
//    }
//    class func appNotificationFail() -> UIColor {
//        return UIColor.init(red: 225/255.0, green: 216/255.0, blue: 241/255.0, alpha: 1.0)
//    }
//
//    class func appPurpleColor() -> UIColor {
//        return UIColor.init(red: 103/255.0, green: 57/255.0, blue: 183/255.0, alpha: 1.0)
//    }
//    class func appGoldenColor() -> UIColor {
//        return UIColor.init(red: 247/255.0, green: 188/255.0, blue: 59/255.0, alpha: 1.0)
//    }
//    class func appPerrotColor() -> UIColor {
//        return UIColor.init(red: 0/255.0, green: 148/255.0, blue: 134/255.0, alpha: 1.0)
//    }
//    class func appGreenColor() -> UIColor {
//        return UIColor.init(red: 141/255.0, green: 197/255.0, blue: 62/255.0, alpha: 1.0)
//    }
//    class func randomColor() -> UIColor {
//
//        let hue = CGFloat(arc4random() % 100) / 100
//        let saturation = CGFloat(arc4random() % 100) / 100
//        let brightness = CGFloat(arc4random() % 100) / 100
//
//        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
//    }
//
//}
//extension Int {
//    /// returns number of digits in Int number
//    public var digitCount: Int {
//        get {
//            return numberOfDigits(in: self)
//        }
//    }
//    // private recursive method for counting digits
//    private func numberOfDigits(in number: Int) -> Int {
//        if abs(number) < 10 {
//            return 1
//        } else {
//            return 1 + numberOfDigits(in: number/10)
//        }
//    }
//}

//extension UIFont{
//
//
//    class func appRegularFont(WithSize size:CGFloat) -> UIFont
//    {
//        return UIFont.init(name: "Graphik-Regular", size: size.proportionalFontSize())!
//    }
//    class func appMediumFont(WithSize size:CGFloat) -> UIFont
//    {
//        return UIFont.init(name: "Graphik-Medium", size: size.proportionalFontSize())!
//    }
//    class func appSemiboldFont(WithSize size:CGFloat) -> UIFont
//    {
//        return UIFont.init(name: "Graphik-Semibold", size: size.proportionalFontSize())!
//    }
//
//}


//extension CGFloat{
//    func proportionalFontSize() -> CGFloat
//    {
//        let sizeToCheckAgainst = self
//        let screenHeight = UIScreen.main.bounds.size.height
//
//        switch UIDevice.current.userInterfaceIdiom {
//        case .phone:
//            if screenHeight==480{
//                return (sizeToCheckAgainst - 3.5)
//            }else if screenHeight == 568{
//                return (sizeToCheckAgainst -  2.5)
//            }else if screenHeight == 667{
//                return (sizeToCheckAgainst +  0)
//            }else if screenHeight == 736{
//                return (sizeToCheckAgainst + 1)
//            }
//            break
//        case .pad:
//            return (sizeToCheckAgainst + 12)
//        default:
//            return self
//        }
//        return self
//    }
//}

//extension Date{
//
//    func startOfMonth() -> Date
//    {
//        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
//    }
//
//    func endOfMonth1() -> Date
//    {
//        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
//    }
//
//
//    func previousMonth() -> Date
//    {
//        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
//        return previousMonth!
//    }
//    func nextMonth() -> Date
//    {
//        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
//        return nextMonth!
//    }
//
//
//    func isGreaterThanDate(dateToCompare: Date) -> Bool {
//        //Declare Variables
//        var isGreater = false
//
//        //Compare Values
//        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
//            isGreater = true
//        }
//
//        //Return Result
//        return isGreater
//    }
//    func isGreaterThanOrEqualToDate(dateToCompare: Date) -> Bool {
//        //Declare Variables
//        var isGreater = false
//
//        //Compare Values
//        if self.compare(dateToCompare) == ComparisonResult.orderedDescending || self.compare(dateToCompare) == ComparisonResult.orderedSame {
//            isGreater = true
//        }
//
//        //Return Result
//        return isGreater
//    }
//
//
//    func isLessThanDate(dateToCompare: Date) -> Bool {
//        //Declare Variables
//        var isLess = false
//
//        //Compare Values
//        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
//            isLess = true
//        }
//
//        //Return Result
//        return isLess
//    }
//
//    func isLessThanOrEqualToDate(dateToCompare: Date) -> Bool {
//        //Declare Variables
//        var isLess = false
//
//        //Compare Values
//        if self.compare(dateToCompare) == ComparisonResult.orderedAscending || self.compare(dateToCompare) == ComparisonResult.orderedSame {
//            isLess = true
//        }
//
//        //Return Result
//        return isLess
//    }
//
//    func equalToDate(dateToCompare: Date) -> Bool {
//        //Declare Variables
//        var isEqualTo = false
//
//        //Compare Values
//        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
//            isEqualTo = true
//        }
//
//        //Return Result
//        return isEqualTo
//    }
//
//    func endOfMonth() -> Date?
//    {
//
//        let calendar = NSCalendar.current
//        if let plusOneMonthDate = calendar.date(byAdding: .month, value: 1, to: self) {
//
//            let plusOneMonthDateComponents = calendar.dateComponents([.month,.year], from: plusOneMonthDate)
//
//            let endOfMonth = (calendar.date(from: plusOneMonthDateComponents))?.addingTimeInterval(-1)
//            return endOfMonth
//        }
//
//        return nil
//    }
//
//    func getDateWith(Seconds second:Int) -> Date
//    {
//        var dateComponent = Calendar.current.dateComponents([Calendar.Component.day,Calendar.Component.month,Calendar.Component.year,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: self)
//        dateComponent.second = 0
//        return Calendar.current.date(from: dateComponent)!
//    }
//
//    func dateWithTimeFromDate(_ secondDate:Date) -> Date{
//
//        let secondDateComponent:DateComponents = NSCalendar.current.dateComponents([.hour,.minute], from: secondDate)
//        var selfDateComponent:DateComponents = NSCalendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: self)
//
//        selfDateComponent.hour = secondDateComponent.hour
//        selfDateComponent.minute  = secondDateComponent.minute
//
//        return NSCalendar.current.date(from: selfDateComponent)!
//    }
//    func dateWithTimeFromDate(_ secondDate:Date,withTimeInterval interval:Int) -> Date
//    {
//
//        let secondDateComponent:DateComponents = NSCalendar.current.dateComponents([.hour,.minute], from: secondDate)
//        var selfDateComponent:DateComponents = NSCalendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: self)
//
//        selfDateComponent.hour = secondDateComponent.hour
//        selfDateComponent.minute  = secondDateComponent.minute
//        let value:Int = Int(floorf(Float(secondDateComponent.minute! / interval)))
//        selfDateComponent.minute  = value
//
//        return NSCalendar.current.date(from: selfDateComponent)!
//    }
//
////    var yesterday: Date {
////        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
////    }
//    static func add(Hours hours:Int, InCurrentTime currentTime:String, withTimeFormat format:String) -> String
//    {
//        var strConvertedDate:String = currentTime
//
//        let dateFormat:DateFormatter = DateFormatter()
//        dateFormat.dateFormat = format
//
//
//        if let currentTimeDate:Date = dateFormat.date(from: currentTime)
//        {
//            var selfDateComponent:DateComponents = NSCalendar.current.dateComponents([.day,.month,.year,.hour], from: currentTimeDate)
//            let currentHours:Int = selfDateComponent.hour!
//            selfDateComponent.hour = currentHours + hours
//            if let value = NSCalendar.current.date(from: selfDateComponent)
//            {
//                strConvertedDate = dateFormat.string(from: value)
//            }
//        }
//        return strConvertedDate
//    }
//    func addMinutesInDate(Minutes minutes:String, withDateFormat format:String ) -> String
//    {
//        var strConvertedDate:String = ""
//
//        let dateFormat:DateFormatter = DateFormatter()
//        dateFormat.dateFormat = format
//
//        var selfDateComponent:DateComponents = NSCalendar.current.dateComponents([.day,.month,.year,.hour,.minute,.second], from: self)
//        selfDateComponent.timeZone = TimeZone.init(abbreviation: "UTC")
//
//        let currentMinutes:Int = selfDateComponent.minute!
//        selfDateComponent.minute = currentMinutes + Int(minutes)!
//
//        if let value = NSCalendar.current.date(from: selfDateComponent)
//        {
//            strConvertedDate = dateFormat.string(from: value)
//        }
//
//        return strConvertedDate
//    }
//
//
//    func dateWith(Hour hour:Int ,AndMinutes minutes:Int) -> Date{
//        var selfDateComponent:DateComponents = NSCalendar.current.dateComponents([.day,.month,.year], from: self)
//        selfDateComponent.hour = hour
//        selfDateComponent.minute  = minutes
//        return NSCalendar.current.date(from: selfDateComponent)!
//    }
//
//    func isToday() -> Bool {
//        let dateComponents = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: self)
//        let currentDateComponents = self.getCurrentDateComponents()
//
//        if dateComponents.day == currentDateComponents.day && dateComponents.month == currentDateComponents.month && currentDateComponents.year == dateComponents.year{
//            return true
//        }else{
//            return false
//        }
//    }
//    func getDateInString(withFormat format:String) -> String
//    {
//        var strConvertedDate:String = ""
//
//        let dateFormat:DateFormatter = DateFormatter()
//        dateFormat.dateFormat = format
//        strConvertedDate = dateFormat.string(from: self)
//
//        return strConvertedDate
//    }
//    func convertLocalDateToUTCDate(date:String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.calendar = NSCalendar.current
//        dateFormatter.timeZone = TimeZone.current
//
//        let dt = dateFormatter.date(from: date)
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        return dateFormatter.string(from: dt!)
//    }
//
//    func convertDateInString(withDateFormat format:String, withConvertedDateFormat convertDate:String) -> String
//    {
//        var strConvertedDate:String = ""
//
//        let dateFormat:DateFormatter = DateFormatter()
//        dateFormat.dateFormat = format
//        strConvertedDate = dateFormat.string(from: self)
//        let convertedDate:Date = dateFormat.date(from: strConvertedDate)!;
//        dateFormat.dateFormat = convertDate
//        strConvertedDate = dateFormat.string(from: convertedDate);
//        return strConvertedDate
//    }
//    func convertDateInUTCDateString(withDateFormat format:String, withConvertedDateFormat convertDate:String) -> String
//    {
//        var strConvertedDate:String = ""
//
//        let dateFormat:DateFormatter = DateFormatter()
//        dateFormat.dateFormat = format
//        strConvertedDate = dateFormat.string(from: self)
//        let convertedDate:Date = dateFormat.date(from: strConvertedDate)!;
//        dateFormat.dateFormat = convertDate
//        dateFormat.timeZone = TimeZone(abbreviation: "UTC")
//        strConvertedDate = dateFormat.string(from: convertedDate);
//        return strConvertedDate
//    }
//    func convertDateInTimeZoneDateString(withDateFormat format:String, withConvertedDateFormat convertDate:String,withTimeZone timeZone:String ) -> String
//    {
//        var strConvertedDate:String = ""
//
//        let dateFormat:DateFormatter = DateFormatter()
//        dateFormat.dateFormat = format
//        strConvertedDate = dateFormat.string(from: self)
//        let convertedDate:Date = dateFormat.date(from: strConvertedDate)!;
//        dateFormat.dateFormat = convertDate
//        dateFormat.timeZone = TimeZone(abbreviation: timeZone)
//        strConvertedDate = dateFormat.string(from: convertedDate);
//        return strConvertedDate
//
//    }
//
//    func isTimeGretherThanCurrentTime() -> Bool {
//        let dateComponents = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: self)
//        let currentDateComponents = self.getCurrentDateComponents()
//
//        if currentDateComponents.hour! > dateComponents.hour!{
//            return true
//        }else if currentDateComponents.hour == dateComponents.hour{
//            if currentDateComponents.minute! >= dateComponents.minute!{
//                return true
//            }else{
//                return false
//            }
//        }else{
//            return false
//        }
//    }
//
//    var timeStamp: UInt64
//    {
//        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
//    }
//    init(withTimestamp timeStamp: UInt64) {
//        self.init(timeIntervalSince1970: Double(timeStamp)/10_000_000 - 62_135_596_800)
//    }
//
//    func getCurrentDateComponents() -> DateComponents {
//        return Calendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: Date())
//    }
//
//    func getDateWithMinutes(Minutes minute:Int, andHour hour:Int)->Date
//    {
//        var secondDateComponet:DateComponents = Calendar.current.dateComponents([.hour,.minute,.month,.year,.day], from: self)
//
//        if minute != -1{
//            secondDateComponet.minute = minute
//        }
//        if hour != -1{
//            secondDateComponet.hour = hour
//        }
//        return Calendar.current.date(from: secondDateComponet)!
//
//    }
//    func dateWithTimeFromDate(secondDate:Date) -> (Date){
//        //let secondDateComponent:NSDateComponents = NSCalendar.currentCalendar().components([.Hour,.Minute], fromDate: secondDate)
//
//          var secondDateComponent:DateComponents = Calendar.current.dateComponents([.hour,.minute], from: secondDate)
//
//        var selfDateComponent:DateComponents = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: self)
//
//        selfDateComponent.hour = secondDateComponent.hour
//        selfDateComponent.minute  = secondDateComponent.minute
//        return Calendar.current.date(from: selfDateComponent)!
//        //return NSCalendar.currentCalendar().dateFromComponents(selfDateComponent)!
//    }
//
//    func daysBetween(date: Date) -> Int {
//        return Date.daysBetween(start: self, end: date)
//    }
//
//    static func daysBetween(start: Date, end: Date) -> Int {
//        let calendar = Calendar.current
//
//        // Replace the hour (time) of both dates with 00:00
//        let date1 = calendar.startOfDay(for: start)
//        let date2 = calendar.startOfDay(for: end)
//
//        let a = calendar.dateComponents([.day], from: date1, to: date2)
//        return a.value(for: .day)!
//    }
//
//    func findNext(DayDate day: String) -> Date {
//
//        var calendar = NSCalendar.current
//        calendar.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
//        calendar.locale = Locale.current
//
//        guard let indexOfDay = calendar.weekdaySymbols.index(of: day) else {
//            assertionFailure("Failed to identify day")
//            return self
//        }
//
//        let weekDay = indexOfDay + 1
//
//        let components = calendar.component(.weekday, from: self)
//
//        if components == weekDay {
//            return self
//        }
//
//        var matchingComponents = DateComponents()
//        matchingComponents.weekday = weekDay // Monday
//
//        let comingMonday = calendar.nextDate(after: self, matching: matchingComponents, matchingPolicy: Calendar.MatchingPolicy.nextTime)  //calendar.nextDate(After
//
//        if let nextDate = comingMonday{
//            return nextDate.dateWithTimeFromDate(self)
//        }else{
//            assertionFailure("Failed to find next day")
//            return self
//        }
//    }
//}
//extension Data
//{
//    func getImageSizeInMB() -> String
//    {
//        if self != nil
//        {
//            let bcf = ByteCountFormatter()
//            bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
//            bcf.countStyle = .file
//            let string = bcf.string(fromByteCount: Int64((self.count)))
//
//            let strSize = "File Size: \(string)"
//            return strSize
//        }
//        else
//        {
//            return ""
//        }
//    }
//}
extension UIView
{
    func addCornerRadiusAndBorder()-> Void{
        self.layer.borderColor = UIColor .appBorderGrayColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }
    func addDropShadow() -> Void {
        self.layer.masksToBounds = false;
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowColor = UIColor .appLightGrayColor.cgColor
        self.layer.shadowOpacity = 0.3;
    }
    
    func addRoundShadow() -> Void {
        self.layer.masksToBounds = false;
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
        self.layer.shadowRadius = 7.5;
        self.layer.shadowColor = UIColor .appThemePurpleColor.cgColor
        self.layer.shadowOpacity = 0.5;
    }
    
}

extension UILabel{
    func animateToFont(_ font: UIFont, withDuration duration: TimeInterval) {
        let oldFont = self.font
        self.font = font
        // let oldOrigin = frame.origin
        let labelScale = oldFont!.pointSize / font.pointSize
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        // let newOrigin = frame.origin
        // frame.origin = oldOrigin
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            //    self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
    
    func lineSpacingInLabel(Space space:CGFloat, StringText text:String) -> NSAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = space
        let attributes = [NSAttributedStringKey.paragraphStyle : style]
        let attributeText:NSAttributedString =  NSAttributedString(string: text, attributes:attributes)
        // attributedText =
        return attributeText
    }
    
    
}
//extension String{
//    func getDate(withDateFormate format:String) -> Date?
//    {
//        let dateFormat:DateFormatter = DateFormatter()
//        dateFormat.dateFormat = format
//        if let date = dateFormat.date(from: self)
//        {
//            return date
//        }
//        return nil
//    }
//    func trim() -> String
//    {
//        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
//    }
//
//    func attributedString(WithStringAttributes textAttribute:AITextAttribute, SubStringData arySubString:[AITextAttribute]) -> Void {
//
//        // Whole Length
//        let rangeOfString:NSRange = NSRange.init(location: 0, length: textAttribute.text.characters.count)
//
//        // ParagraphStyle
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = textAttribute.textAlignment
//        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
//
//        // Main Attributed String
//        let attributedString = NSMutableAttributedString(string: self)
//        attributedString.addAttributes([
//            NSParagraphStyleAttributeName:paragraphStyle,
//            NSForegroundColorAttributeName:textAttribute.textColor,
//            NSFontAttributeName:textAttribute.textFont
//            ], range: rangeOfString)
//        if textAttribute.shouldAddUnderline == true {
//            attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: rangeOfString)
//        }
//
//        var searchRange: NSRange = rangeOfString
//
//        for index in 0..<arySubString.count{
//            let subStringAttributes = arySubString[index]
//
//            var foundRange: NSRange = NSRange.init(location: 0, length: 0)
//
//            searchRange.length = rangeOfString.length - searchRange.location
//            if let subStringValue = textAttribute.text as? NSString{
//                foundRange = subStringValue.range(of: subStringAttributes.text, options: .forcedOrdering, range: searchRange, locale: nil)
//            }
//            //            foundRange = rangeOfString.rangeOfString(subStringAttributes.text, options:NSString.CompareOptions.ForcedOrderingSearch, range: searchRange)
//        }
//    }
//
//
//
//    static func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat
//    {
//        let label:UILabel = UILabel(frame: CGRect.init(x: 0.0, y: 0.0, width: width, height: CGFloat.greatestFiniteMagnitude ) )
//
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.autoresizingMask = []
//        label.text = text
//        label.sizeToFit()
//        return label.frame.height
//    }
//
//    static func heightForLabel(text:String, font:UIFont, width:CGFloat, numberOfLine:Int) -> CGFloat
//    {
//        let label:UILabel = UILabel(frame: CGRect.init(x: 0.0, y: 0.0, width: width, height: CGFloat.greatestFiniteMagnitude) )
//        //CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude)
//        label.numberOfLines = numberOfLine
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.autoresizingMask = []
//        label.text = text
//        label.sizeToFit()
//        return label.frame.height
//    }
//
//}
extension NSAttributedString {
    
    
}
//extension NSString{
//
//    class func getDictionaryForAttributedString(withString strString:String, FontForString font:UIFont, ColorForString color:UIColor, AllowUnderline underline:Bool) -> NSMutableDictionary {
//        let dicAttribute = NSMutableDictionary()
//        dicAttribute.setValue(strString, forKey:  Constant.AttributedString.LinkText)
//        dicAttribute.setValue(color, forKey:  Constant.AttributedString.LinkColor)
//        dicAttribute.setValue(font, forKey:  Constant.AttributedString.LinkFont)
//        dicAttribute.setValue(NSNumber(value: underline as Bool), forKey:  Constant.AttributedString.LinkUnderline)
//        return dicAttribute
//    }
//
//
//    static func isValidEmail(_ testStr:String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//
//        if var emailTest:NSPredicate = NSPredicate (format:"SELF MATCHES %@", emailRegEx){
//            // if let emailTest:NSPredicate? = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
//            return emailTest.evaluate(with: testStr)
//        }
//        return false
//    }
//
//
//
//    class func getCustomAttributedStringForText(_ strWholeString:NSString, andSubStringData arySubString:NSArray, normatTextColor textColor:UIColor, defaultTextFont font:UIFont, textAlignment alignment:NSTextAlignment)->(NSMutableAttributedString){
//
//        let rangeOfString:NSRange = NSMakeRange(0, strWholeString.length)
//
//        // Satup Paragraph Style
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
//        paragraphStyle.alignment = alignment
//        //        paragraphStyle.minimumLineHeight = 5.0
//
//        // Create new attributed string
//        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: strWholeString as String)
//        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: rangeOfString)
//        attributedString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: rangeOfString)
//        attributedString.addAttribute(NSFontAttributeName, value: font, range: rangeOfString)
//        var searchRange: NSRange = NSMakeRange(0, strWholeString.length)
//
//        for dicAttributes in arySubString {
//
//            let subString: NSString = (dicAttributes as! NSDictionary) .value(forKey: Constant.AttributedString.LinkText) as! NSString  //((dicAttributes as AnyObject) .value(forKey: Constant.AttributedString.LinkText) as! String)
//            var foundRange: NSRange
//
//            searchRange.length = strWholeString.length - searchRange.location
//            foundRange = strWholeString.range(of: subString as String, options:NSString.CompareOptions.forcedOrdering, range: searchRange)
//
//
//            if foundRange.location != NSNotFound {
//                // found an occurrence of the substring! do stuff here
//                searchRange.location = foundRange.location + foundRange.length
//
//                let linkColor:UIColor? = (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkColor) as? UIColor
//                attributedString.addAttribute(NSForegroundColorAttributeName, value: linkColor!, range: foundRange)
//
//                // Link Font
//                var linkFont:UIFont? = font
//                if (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkFont) != nil {
//                    linkFont = (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkFont) as? UIFont
//                }
//                attributedString.addAttribute(NSFontAttributeName, value: linkFont!, range: foundRange)
//
//                // Link Underline
//                let shouldAddUnderline:Bool = ((dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkUnderline) as! NSNumber ) as Bool
//                if shouldAddUnderline == true {
//                    attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: foundRange)
//                }
//            }else{
//
//                let linkColor:UIColor? = (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkColor) as? UIColor
//                attributedString.addAttribute(NSForegroundColorAttributeName, value: linkColor!, range: foundRange)
//
//                // Link Font
//                var linkFont:UIFont? = font
//                if (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkFont) != nil {
//                    linkFont = (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkFont) as? UIFont
//                }
//                attributedString.addAttribute(NSFontAttributeName, value: linkFont!, range: foundRange)
//
//                // Link Underline
//                let shouldAddUnderline:Bool = ((dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkUnderline) as! NSNumber ) as Bool
//                if shouldAddUnderline == true {
//                    attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: foundRange)
//                }
//            }
//
//        }
//        return attributedString
//
//    }
//}


    /*
     class func getCustomAttributedStringForText(strWholeString:NSString, andSubStringData arySubString:NSArray, normatTextColor textColor:UIColor, defaultTextFont font:UIFont, textAlignment alignment:NSTextAlignment)->(NSMutableAttributedString){

     let rangeOfString:NSRange = NSMakeRange(0, strWholeString.length)

     // Satup Paragraph Style
     let paragraphStyle = NSMutableParagraphStyle()
     paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
     paragraphStyle.alignment = alignment
     //        paragraphStyle.minimumLineHeight = 5.0

     // Create new attributed string
     let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: strWholeString as String)
     attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: rangeOfString)
     attributedString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: rangeOfString)
     attributedString.addAttribute(NSFontAttributeName, value: font, range: rangeOfString)
     var searchRange: NSRange = NSMakeRange(0, strWholeString.length)

     for dicAttributes in arySubString {

     let subString: NSString = ((dicAttributes as AnyObject).valueForKey(Constant.AttributedString.LinkText) as! String)
     var foundRange: NSRange

     searchRange.length = strWholeString.length - searchRange.location
     foundRange = strWholeString.rangeOfString(subString as String, options:NSString.CompareOptions.ForcedOrderingSearch, range: searchRange)


     if foundRange.location != NSNotFound {
     // found an occurrence of the substring! do stuff here
     searchRange.location = foundRange.location + foundRange.length

     let linkColor:UIColor? = dicAttributes.valueForKey(Constant.AttributedString.LinkColor) as? UIColor
     attributedString.addAttribute(NSForegroundColorAttributeName, value: linkColor!, range: foundRange)

     // Link Font
     var linkFont:UIFont? = font
     if dicAttributes.valueForKey(Constant.AttributedString.LinkFont) != nil {
     linkFont = dicAttributes.valueForKey(Constant.AttributedString.LinkFont) as? UIFont
     }
     attributedString.addAttribute(NSFontAttributeName, value: linkFont!, range: foundRange)

     // Link Underline
     let shouldAddUnderline:Bool = (dicAttributes.valueForKey(Constant.AttributedString.LinkUnderline) as! NSNumber ) as Bool
     if shouldAddUnderline == true {
     attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: foundRange)
     }
     }else{

     let linkColor:UIColor? = dicAttributes.valueForKey(Constant.AttributedString.LinkColor) as? UIColor
     attributedString.addAttribute(NSForegroundColorAttributeName, value: linkColor!, range: foundRange)

     // Link Font
     var linkFont:UIFont? = font
     if dicAttributes.valueForKey(Constant.AttributedString.LinkFont) != nil {
     linkFont = dicAttributes.valueForKey(Constant.AttributedString.LinkFont) as? UIFont
     }
     attributedString.addAttribute(NSFontAttributeName, value: linkFont!, range: foundRange)

     // Link Underline
     let shouldAddUnderline:Bool = (dicAttributes.valueForKey(Constant.AttributedString.LinkUnderline) as! NSNumber ) as Bool
     if shouldAddUnderline == true {
     attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: foundRange)
     }
     }

     }
     return attributedString

     }*/
//}

