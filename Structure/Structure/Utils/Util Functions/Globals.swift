//
//  Globals.swift
//  GoodBuysShopper
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation
import UIKit


//MARK: - APP DELEGATE

let KEY_IS_USER_LOGGED_IN = "KEY_IS_USER_LOGGED_IN"
let AIUSER_CURRENTUSER_STORE = "AIUSER_CURRENTUSER_STORE"


let KEY_IS_POI_LOGGED_IN = "KEY_IS_POI_LOGGED_IN"
let AIPOI_CURRENTPOI_STORE = "AIUSER_CURRENTPOI_STORE"

let defaultProfilepicName = "default_userpic_mycontactscreen"


//MARK: - IMAGE
func ImageNamed(name:String) -> UIImage?{
    return UIImage(named: name)
}

fileprivate func estimateFrameForText(_ text: String) -> CGRect {
    let size = CGSize(width: 200, height: 1000)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.appFont_Medium(fontSize: Constant.FontSize.fontSizeFourteen)], context: nil)
}

func GetLocalizedValue(key:String)->String
{
    return NSLocalizedString(key, comment: "");
}


struct Constant
{
    static let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    static let defaultTimeForHideAlert : Double = 1.5
    
    struct FontSize {
        static let fontSizeTen:CGFloat = 10
        static let fontSizeTwelve:CGFloat = 12
        static let fontSizeThirteen:CGFloat = 13
        static let fontSizeFourteen:CGFloat = 14
        static let fontSizeSixteen:CGFloat = 16
        static let fontSizeEighteen:CGFloat = 18
        static let fontSizeTwenty:CGFloat = 20
        static let fontSizeTwentyTwo:CGFloat = 22
        static let fontSizeTwentyFour:CGFloat = 24
    }
    
    struct AttributedString {
        static let LinkText = "linkText"
        static let LinkUnderline = "shouldAddLinkUnderline"
        static let LinkColor = "linkColor"
        static let LinkFont = "linkFont"
    }
    
    struct App
    {
        static let APP_NAME:String = "ThinkScience Voting App"
        static let OS_TYPE = "1"
        static let dbName = "ThinkScienceVoting"
    }
    struct Image {
        static   let PLACEHOLDER_THUMB_IMAGE_NAME = "placeholder_inventory_thumb"
        static let PLACEHOLDER_LARGE_IMAGE_NAME = "placeholder_inventory_main"
        static    let PLACEHOLDER_MISSION_IMAGE_NAME = "placeholder"
        
        
        static    let IMAGE_PLACEHOLDER_USER = ImageNamed(name: "profile")
        static let IMAGE_PLACEHOLDER_MISSION = ImageNamed(name: "placeholder")
        static let IMAGE_PLACEHOLDER_THUMB = ImageNamed(name: "placeholder_inventory_thumb")
        static let PHONE_NUMBER:String = "1865326598"
    }
    //MARK: - KEYS
    struct Keys
    {
        static let KEY_IS_USER_LOGGED_IN = "KEY_IS_USER_LOGGED_IN"
        static let KEY_HAS_USER_SKIPPED_LOGIN = "KEY_HAS_USER_SKIPPED_LOGIN"
        static let KEY_HAS_USER_AGREED_TO_TC = "KEY_HAS_USER_AGREED_TO_TC"
    }
    //MARK: - COLORS
    struct Colors {
        
        static let CLEAR_COLOR = UIColor.clear
        static let WHITE_COLOR = UIColor.white
        static let BLACK_COLOR = UIColor.black
        static let RED_COLOR = UIColor.red
        static let GRAY_COLOR = UIColor.darkGray
        static let GREEN_COLOR = UIColor.green
        static let Orange_COLOR = UIColor.orange
        
        
        static let APP_COLOR_TF_PLACE_HOLDER = UIColor.appLightGrayColor
        
        static let APP_COLOR_RED = UIColor(red: 219, green: 50, blue: 55)
        static let APP_COLOR_GREEN = UIColor(red: 6, green: 181, blue: 0)
        static let APP_COLOR_BLUE = UIColor(red: 36, green: 58, blue: 128)
        
        
        static let APP_COLOR_PAYPAL = UIColor(red: 10, green: 63, blue: 125)
        
        
        static let APP_COLOR_BLACK = UIColor(red: 0, green: 0, blue: 0)
        static let APP_COLOR_DARK_GRAY = UIColor(red: 50, green: 50, blue: 50)
        static let APP_COLOR_GRAY = UIColor(red: 127, green: 127, blue: 127)
        static let APP_COLOR_LIGHT_GRAY = UIColor(red: 229, green: 229, blue: 229)
        
        static let APP_COLOR_TAB_SEPARATOR = UIColor(red: 77, green: 77, blue: 77)
        
    }
    struct URL
    {
        
        //MARK:- PAYPAL CREDENTIALS
    }
}









