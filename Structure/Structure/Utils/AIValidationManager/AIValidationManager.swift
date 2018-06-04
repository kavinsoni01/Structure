//
//  AIValidationManager.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 22/06/17.
//  Copyright © 2017 Agile. All rights reserved.
//

import UIKit

//MARK:- VALIDATION CONSTANTS

let MINIMUM_CHAR_NAME = 3
let MAXIMUM_CHAR_NAME = 64

let MINIMUM_CHAR_EMAIL = 3
let MAXIMUM_CHAR_EMAIL = 60

let MINIMUM_CHAR_CITY = 3
let MAXIMUM_CHAR_CITY = 30

let MAXIMUM_CHAR_POSTAL_CODE = 6

let MINIMUM_CHAR_PASSWORD = 6
let MAXIMUM_CHAR_PASSWORD = 16

let MINIMUM_CHAR_PHONE_NUMBER = 8
let MAXIMUM_CHAR_PHONE_NUMBER = 15

let MINIMUM_CHAR_ADDRESS = 2
let MAXIMUM_CHAR_ADDRESS = 256

let MAXIMUM_CHAR_CARD_NUMBER = 16

let MAXIMUM_CHAR_CVV = 3

let MINIMUM_CHAR_MESSAGE = 10
let MAXIMUM_CHAR_MESSAGE = 1000





enum AIValidationRule: Int {
	case
	EmptyCheck,
	MinMaxLength,
	FixedLength,
	EmailCheck,
	UpperCase,
	LowerCase,
	SpecialCharacter,
	DigitCheck,
	WhiteSpaces,
	None
}


let ValidationManager = AIValidationManager.sharedManager


class AIValidationManager: NSObject {
	
	// MARK: - SHARED MANAGER -
	static let sharedManager = AIValidationManager()
    
    
    //MARK:- VALIDATION CHECK Without Textfield
    func validate(value:String,titleName:String,forRule rule:AIValidationRule, withMinimumChar minChar:Int, andMaximumChar maxChar:Int) -> (isValid:Bool, errMessage:String)? {
        
        switch rule {
            
        case .EmptyCheck:
            return (value.count == 0) ? (false,"Please enter your \(titleName.lowercased()).") : nil
            
            
        case .MinMaxLength:
            //            return (txtField.text!.characters.count < minChar || txtField.text!.characters.count > maxChar) ? (false,"\(txtField.placeholder!) should be of \(minChar) to \(maxChar) characters",txtField) : nil
            
            return (value.count < minChar) ? (false,"\(titleName) should contain at least \(minChar) characters.") : nil
            
            
        case .FixedLength:
            return (value.count != minChar) ? (false,"\(titleName) should be of \(minChar) characters.") : nil
            
            
        case .EmailCheck:
            return (!(value.isValidEmail())) ? (false,"Please enter valid \(titleName.lowercased()).") : nil
            
            
        case .UpperCase:
            return ((value as NSString).rangeOfCharacter(from: NSCharacterSet.uppercaseLetters).location == NSNotFound) ? (false,"\(titleName) should contain at least one uppercase letter.") : nil
            
            
        case .LowerCase:
            return ((value as NSString).rangeOfCharacter(from: NSCharacterSet.lowercaseLetters).location == NSNotFound) ? (false,"\(titleName) should contain at least one lowercase letter.") : nil
            
            
        case .SpecialCharacter:
            let symbolCharacterSet = NSMutableCharacterSet.symbol()
            symbolCharacterSet.formUnion(with: NSCharacterSet.punctuationCharacters)
            return ((value as NSString).rangeOfCharacter(from: symbolCharacterSet as CharacterSet).location == NSNotFound) ? (false,"\(titleName) should contain at least one special letter.") : nil
            
            
        case .DigitCheck:
            return ((value as NSString).rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789") as CharacterSet).location == NSNotFound) ? (false,"\(titleName) should contain at least one digit letter.") : nil
            
        case .WhiteSpaces:
            return (value.containsAdjacentSpaces() || value.isLastCharcterAWhiteSpace()) ? (false,"\(titleName) seems to be invalid.") : nil
            
        case .None:
            return nil
        }
    }
	
	
	//MARK:- VALIDATION CHECK
	func validateTextField(txtField:AITextField, forRule rule:AIValidationRule, withMinimumChar minChar:Int, andMaximumChar maxChar:Int) -> (isValid:Bool, errMessage:String, txtFieldWhichFailedValidation:AITextField)? {
		
		switch rule {
			
		case .EmptyCheck:
			return (txtField.text?.count == 0) ? (false,"Please enter your \(txtField.placeholder!.lowercased()).",txtField) : nil
			
			
		case .MinMaxLength:
//			return (txtField.text!.characters.count < minChar || txtField.text!.characters.count > maxChar) ? (false,"\(txtField.placeholder!) should be of \(minChar) to \(maxChar) characters",txtField) : nil

			return (txtField.text!.count < minChar) ? (false,"\(txtField.placeholder!) should contain at least \(minChar) characters.",txtField) : nil

			
		case .FixedLength:
			return (txtField.text!.count != minChar) ? (false,"\(txtField.placeholder!) should be of \(minChar) characters.",txtField) : nil
			
			
		case .EmailCheck:
			return (!(txtField.text?.isValidEmail())!) ? (false,"Please enter valid \(txtField.placeholder!.lowercased()).",txtField) : nil
			
			
		case .UpperCase:
			return ((txtField.text! as NSString).rangeOfCharacter(from: NSCharacterSet.uppercaseLetters).location == NSNotFound) ? (false,"\(txtField.placeholder!) should contain at least one uppercase letter.",txtField) : nil
			
			
		case .LowerCase:
			return ((txtField.text! as NSString).rangeOfCharacter(from: NSCharacterSet.lowercaseLetters).location == NSNotFound) ? (false,"\(txtField.placeholder!) should contain at least one lowercase letter.",txtField) : nil
			
			
		case .SpecialCharacter:
			let symbolCharacterSet = NSMutableCharacterSet.symbol()
			symbolCharacterSet.formUnion(with: NSCharacterSet.punctuationCharacters)
			return ((txtField.text! as NSString).rangeOfCharacter(from: symbolCharacterSet as CharacterSet).location == NSNotFound) ? (false,"\(txtField.placeholder!) should contain at least one special letter.",txtField) : nil
			
			
		case .DigitCheck:
			return ((txtField.text! as NSString).rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789") as CharacterSet).location == NSNotFound) ? (false,"\(txtField.placeholder!) should contain at least one digit letter.",txtField) : nil
			
		case .WhiteSpaces:
			return (txtField.text!.containsAdjacentSpaces() || txtField.text!.isLastCharcterAWhiteSpace()) ? (false,"\(txtField.placeholder!) seems to be invalid.",txtField) : nil
			
		case .None:
			return nil
		}
	}
	
	
	func validateTextField(txtField:AITextField, forRules rules:[AIValidationRule]) -> (isValid:Bool, errMessage:String, txtFieldWhichFailedValidation:AITextField)? {
		return validateTextField(txtField: txtField, forRules: rules, withMinimumChar: 0, andMaximumChar: 0)
	}
	
	
    func validateFieldsValue(value:String, titleName:String, forRules rules:[AIValidationRule], withMinimumChar minChar:Int, andMaximumChar maxChar:Int) -> (isValid:Bool, errMessage:String)? {
        
        var strMessage:String = ""
        for eachRule in rules {
            
            
            if let result = validate(value: value, titleName: titleName, forRule: eachRule, withMinimumChar: minChar, andMaximumChar: maxChar)
            {
                if(eachRule == AIValidationRule.EmptyCheck){
                    return result
                }else{
                    strMessage += "\(strMessage.count == 0 ? "" : "\n\n") \(result.errMessage)"
                }
            }
            
            /*
            if let result = validateTextField(txtField: txtField, forRule: eachRule, withMinimumChar: minChar, andMaximumChar: maxChar) {
                if(eachRule == AIValidationRule.EmptyCheck){
                    return result
                }else{
                    strMessage += "\(strMessage.characters.count == 0 ? "" : "\n\n") \(result.errMessage)"
                }
            }
             */
        }
        return strMessage.count > 0 ? (false,strMessage) : nil
    }
	
	func validateTextField(txtField:AITextField, forRules rules:[AIValidationRule], withMinimumChar minChar:Int, andMaximumChar maxChar:Int) -> (isValid:Bool, errMessage:String, txtFieldWhichFailedValidation:AITextField)? {
		
		var strMessage:String = ""
		for eachRule in rules {
			
			if let result = validateTextField(txtField: txtField, forRule: eachRule, withMinimumChar: minChar, andMaximumChar: maxChar) {
				if(eachRule == AIValidationRule.EmptyCheck){
					return result
				}else{
					strMessage += "\(strMessage.count == 0 ? "" : "\n\n") \(result.errMessage)"
				}
			}
		}
		return strMessage.count > 0 ? (false,strMessage,txtField) : nil
	}
}
