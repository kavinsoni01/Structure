//
//  Extension_String.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit


extension NSString
{
    
    class func getDictionaryForAttributedString(withString strString:String, FontForString font:UIFont, ColorForString color:UIColor, AllowUnderline underline:Bool) -> NSMutableDictionary {
        let dicAttribute = NSMutableDictionary()
        dicAttribute.setValue(strString, forKey:  Constant.AttributedString.LinkText)
        dicAttribute.setValue(color, forKey:  Constant.AttributedString.LinkColor)
        dicAttribute.setValue(font, forKey:  Constant.AttributedString.LinkFont)
        dicAttribute.setValue(NSNumber(value: underline as Bool), forKey:  Constant.AttributedString.LinkUnderline)
        return dicAttribute
    }
    
    
    static func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        if var emailTest:NSPredicate = NSPredicate (format:"SELF MATCHES %@", emailRegEx){
            // if let emailTest:NSPredicate? = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
            return emailTest.evaluate(with: testStr)
        }
        return false
    }
    
    
    
    class func getCustomAttributedStringForText(_ strWholeString:NSString, andSubStringData arySubString:NSArray, normatTextColor textColor:UIColor, defaultTextFont font:UIFont, textAlignment alignment:NSTextAlignment)->(NSMutableAttributedString){
        
        let rangeOfString:NSRange = NSMakeRange(0, strWholeString.length)
        
        // Satup Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = alignment
        //        paragraphStyle.minimumLineHeight = 5.0
        
        // Create new attributed string
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: strWholeString as String)
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: rangeOfString)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: textColor, range: rangeOfString)
        attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: rangeOfString)
        var searchRange: NSRange = NSMakeRange(0, strWholeString.length)
        
        for dicAttributes in arySubString {
            
            let subString: NSString = (dicAttributes as! NSDictionary) .value(forKey: Constant.AttributedString.LinkText) as! NSString  //((dicAttributes as AnyObject) .value(forKey: Constant.AttributedString.LinkText) as! String)
            var foundRange: NSRange
            
            searchRange.length = strWholeString.length - searchRange.location
            foundRange = strWholeString.range(of: subString as String, options:NSString.CompareOptions.forcedOrdering, range: searchRange)
            
            
            if foundRange.location != NSNotFound {
                // found an occurrence of the substring! do stuff here
                searchRange.location = foundRange.location + foundRange.length
                
                let linkColor:UIColor? = (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkColor) as? UIColor
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: linkColor!, range: foundRange)
                
                // Link Font
                var linkFont:UIFont? = font
                if (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkFont) != nil {
                    linkFont = (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkFont) as? UIFont
                }
                attributedString.addAttribute(NSAttributedStringKey.font, value: linkFont!, range: foundRange)
                
                // Link Underline
                let shouldAddUnderline:Bool = ((dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkUnderline) as! NSNumber ) as! Bool
                if shouldAddUnderline == true {
                    attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: foundRange)
                }
            }else{
                
                let linkColor:UIColor? = (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkColor) as? UIColor
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: linkColor!, range: foundRange)
                
                // Link Font
                var linkFont:UIFont? = font
                if (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkFont) != nil {
                    linkFont = (dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkFont) as? UIFont
                }
                attributedString.addAttribute(NSAttributedStringKey.font, value: linkFont!, range: foundRange)
                
                // Link Underline
                let shouldAddUnderline:Bool = ((dicAttributes as AnyObject).value(forKey: Constant.AttributedString.LinkUnderline) as! NSNumber ) as! Bool
                if shouldAddUnderline == true {
                    attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: foundRange)
                }
            }
            
        }
        return attributedString
        
    }
    
//
//    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
//
//        let foundRange = self.mutableString.rangeOfString(textToFind)
//        if foundRange.location != NSNotFound {
//            self.addAttribute(NSLinkAttributeName, value: linkURL, range: foundRange)
//            return true
//        }
//        return false
//    }

    
}

extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedStringKey.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}


extension String {
	
	subscript(integerIndex: Int) -> Character {
		let index = self.index(self.startIndex, offsetBy: integerIndex)
		return self[index]
	}
	
	var getTimeIn24Format: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm a"
		
		let date = dateFormatter.date(from: self)
		
		
		return (date?.hourTwoDigit24Hours)!
	}
	var getTimeIn12Format : String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm:ss"
		let date = dateFormatter.date(from: self)
		return (date?.hourTwoDigit)!
	}
	var getDateFromString: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm a"
		dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
		let date = dateFormatter.date(from: self)
		return date!
	}
    func formatnumber(_ formate:String) -> NSNumber? {
        let formater = NumberFormatter()
        formater.groupingSeparator = formate
        formater.numberStyle = .decimal
        return formater.number(from: self)
    }
	
    func convertStringToDate(currentformate:String,outputFormate:String) -> String
    {
        /*
        let isoDate = self
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = currentformate
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date1 = dateFormatter1.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date1)
        let finalDate = calendar.date(from:components)
        
        print(finalDate)
        */
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = currentformate
        
        dateFormatter.timeZone = TimeZone.current //TimeZone(identifier: "UTC")
        
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        
        if TARGET_OS_SIMULATOR == 1
        {
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
        }
        
        
  
        let date = dateFormatter.date(from: self) //according to date format your date string
        print(date ?? "") //Convert String to Date
        
        
        dateFormatter.dateFormat = outputFormate
        
        if date != nil
        {
        
            let newDate = dateFormatter.string(from: date!) //pass Date here
        
            return newDate
        }
        return ""
        
    }
    
	func isLastCharcterAWhiteSpace() -> Bool{
		
		if(self.count == 0){
			return false
		}
		
		var result:Bool = false
		if(self.count == 1){
			result = self[0] == " "
		}else{
			result = self[self.count-1] == " "
		}
		
		return result
	}
	
	func containsAdjacentSpaces() -> Bool{
		
		if(self.count == 0){
			return false
		}
		
		var result = false
		if(self.count == 1){
			result = false
		}else{
			var wasLastCharacterAWhiteSpace = false
			for i in 0..<self.count{
				let currentChar = self[i] as Character
				print(currentChar)
				if(currentChar == " "){
					if(wasLastCharacterAWhiteSpace){
						return true
					}
					wasLastCharacterAWhiteSpace = true
				}else{
					wasLastCharacterAWhiteSpace = false
				}
			}
		}
		return result
	}
	
	func whiteSpaceTrimmed() -> String{
		return self.components(separatedBy: NSCharacterSet.whitespaces).filter({ !$0.isEmpty }).joined(separator: " ")
	}
       
	
//	func encodedUrl() -> String{
//		return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
//	}
	
	func heightWithWidthAndFont(width: CGFloat, font: UIFont) -> CGFloat {
		
		let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
		return boundingBox.height
	}
	
	func isValidEmail() -> Bool	{
		return ( (isValidEmail_OLD(stringToCheckForEmail: self as String))  && (isValidEmail_NEW(stringToCheckForEmail: self as String)) )
	}
	
	func isValidEmail_OLD(stringToCheckForEmail:String) -> Bool {
		let emailRegex = "[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}"
		return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: stringToCheckForEmail)
	}
	
	func isValidEmail_NEW(stringToCheckForEmail:String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: stringToCheckForEmail)
	}
	
//	func doContainsEmoji() -> Bool	{
//		return false//self.isIncludingEmoji()
//	}

	
//	func doContainsEmoji() -> Bool	{
//
//		 {
//			for scalar in unicodeScalars {
//				switch scalar.value {
//				case 0x1F600...0x1F64F, // Emoticons
//				0x1F300...0x1F5FF, // Misc Symbols and Pictographs
//				0x1F680...0x1F6FF, // Transport and Map
//				0x2600...0x26FF,   // Misc symbols
//				0x2700...0x27BF,   // Dingbats
//				0xFE00...0xFE0F:   // Variation Selectors
//					return true
//				default:
//					continue
//				}
//			}
//			return false
//		}
//
//	
//	}
    
        func attributedString(WithStringAttributes textAttribute:AITextAttribute, SubStringData arySubString:[AITextAttribute]) -> Void {
    
            // Whole Length
            let rangeOfString:NSRange = NSRange.init(location: 0, length: textAttribute.text.characters.count)
    
            // ParagraphStyle
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAttribute.textAlignment
            paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
    
            // Main Attributed String
            let attributedString = NSMutableAttributedString(string: self)
            attributedString.addAttributes([
                NSAttributedStringKey.paragraphStyle:paragraphStyle,
                NSAttributedStringKey.foregroundColor:textAttribute.textColor,
                NSAttributedStringKey.font:textAttribute.textFont
                ], range: rangeOfString)
            if textAttribute.shouldAddUnderline == true {
                attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: rangeOfString)
            }
    
            var searchRange: NSRange = rangeOfString
    
            for index in 0..<arySubString.count{
                let subStringAttributes = arySubString[index]
    
                var foundRange: NSRange = NSRange.init(location: 0, length: 0)
    
                searchRange.length = rangeOfString.length - searchRange.location
                if let subStringValue = textAttribute.text as? NSString{
                    foundRange = subStringValue.range(of: subStringAttributes.text, options: .forcedOrdering, range: searchRange, locale: nil)
                }
                //            foundRange = rangeOfString.rangeOfString(subStringAttributes.text, options:NSString.CompareOptions.ForcedOrderingSearch, range: searchRange)
            }
        }
    

	var containsEmoji: Bool {
		get {
			for scalar in unicodeScalars {
				switch scalar.value {
				case 0x1F600...0x1F64F, // Emoticons
				0x1F300...0x1F5FF, // Misc Symbols and Pictographs
				0x1F680...0x1F6FF, // Transport and Map
				0x2600...0x26FF,   // Misc symbols
				0x2700...0x27BF,   // Dingbats
				0xFE00...0xFE0F:   // Variation Selectors
					return true
				default:
					continue
				}
			}
			return false
		}
	}
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: from)...])
    }
    
    var length: Int {
        return self.count
    }
	
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func substring(start: Int, end: Int) -> String
    {
        if (start < 0 || start > self.count)
        {
            print("start index \(start) out of bounds")
            return ""
        }
        else if end < 0 || end > self.count
        {
            print("end index \(end) out of bounds")
            return ""
        }
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        let range = startIndex..<endIndex
        
        return self.substring(with: range)
    }
    
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }

}

