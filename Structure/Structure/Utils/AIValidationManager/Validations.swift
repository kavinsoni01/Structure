//
//  Validations.swift
//  EventManager
//
//  Created by viral shah on 08/06/17.
//  Copyright © 2017 viral shah. All rights reserved.
//

//TODO: - PASSWORD CONTAIN 1 UPPERCASE, 1 LOWERCASE, 1 DIGIT, 1 SPECIAL CHARACTER, 8 CHARACTER MIN LIMIT

import UIKit

extension String {
    
    var isTrimmed : String {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed
        }
    }
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    var isAlphabatics : Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.letters.inverted) == nil
    }
    
    var isNumbericOrDecimal : Bool {
        if let newString = self as NSString? {
            if newString.length > 0 {
                let scanner: Scanner = Scanner(string: self)
                let isNumeric = scanner.scanDecimal(nil) && scanner.isAtEnd
                
                return isNumeric
            } else {
                return false
            }
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isNumberic : Bool {
        return !isEmpty && range(of: "[0-9]", options: .regularExpression) == nil
    }
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    var isValidPassword: Bool {
            let regex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,}$")
            return regex.evaluate(with:self)
    }
    
    func setCharacterLimit(_ minChar : Int, maxChar : Int) -> Bool {
        if self.count < minChar {
            return false
        }
        else {
            if self.count > maxChar {
                return false
            }
            else {
                return true
            }
        }
    }
}
