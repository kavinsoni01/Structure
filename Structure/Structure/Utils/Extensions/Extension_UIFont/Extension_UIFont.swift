//
//  Extension_UIFont.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation
import UIKit

extension UIFont {
	
    
//    Rams
//    Rams-LightItalic
//    Rams-Black
//    Rams-Light
//    Rams
//    Rams-BlackItalic
//    Rams-Bold
//    Rams-BoldItalic
//    Rams-Italic
    
    
	// AvenirNextCyr-Regular_0
	class func appFont_Regular(fontSize : CGFloat) -> UIFont {
		return UIFont(name: "Rams", size: fontSize.proportionalFontSize())!
	}
    class func appFont_LightItalic(fontSize : CGFloat) -> UIFont {
        return UIFont(name: "Rams-LightItalic", size: fontSize.proportionalFontSize())!
    }

    class func appFont_BlackItalic(fontSize : CGFloat) -> UIFont {
        return UIFont(name: "Rams-BlackItalic", size: fontSize.proportionalFontSize())!
    }
    
    class func appFont_Italic(fontSize : CGFloat) -> UIFont {
        return UIFont(name: "Rams-Italic", size: fontSize.proportionalFontSize())!
    }
    
    class func appFont_BoldItalic(fontSize : CGFloat) -> UIFont {
        return UIFont(name: "Rams-BoldItalic", size: fontSize.proportionalFontSize())!
    }
    
	// Roboto BOLD
	class func appFont_Bold(fontSize : CGFloat) -> UIFont {
		return UIFont(name: "Rams-Bold", size: fontSize.proportionalFontSize())!
	}
    
    // AvenirNextCyr-Regular
    class func appFont_Light(fontSize : CGFloat) -> UIFont {
        return UIFont(name: "Rams-Light", size: fontSize.proportionalFontSize())!
    }
    
    // AvenirNextCyr-Medium_0
    class func appFont_Medium(fontSize : CGFloat) -> UIFont {
        return UIFont(name: "Rams", size: fontSize.proportionalFontSize())!
    }
    // AvenirNextCyr-Regular
    class func appFont_Thin(fontSize : CGFloat) -> UIFont {
        return UIFont(name: "Rams-Light", size: fontSize.proportionalFontSize())!
    }
    
}
