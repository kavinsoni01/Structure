//
//  Extension_UIColor.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation
import UIKit

extension UIColor {
	
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
   // static let btnBGColor = UIColor(red: 150/255, green: 186/255, blue: 56/255, alpha: 1)
    
    static let statusBarBGColor = UIColor(red: 0/255, green: 85/255, blue: 140/255, alpha: 1)
    
    static let gradientFirstColor = UIColor(red: 0/255, green: 85/255, blue: 140/255, alpha: 1)
    
    static let gradientSecondColor = UIColor(red: 0/255, green: 124/255, blue: 170/255, alpha: 1)
    
    static let appBrownColor = UIColor(red: 57/255, green: 64/255, blue: 76/255, alpha: 1)
    
    static let appDarkGrayColor = UIColor(red: 119/255, green: 123/255, blue: 135/255, alpha: 1)

    static let appLightGrayColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1)
    
    static let appBlackColor = UIColor(red: 25/255, green: 30/255, blue: 44/255, alpha: 1)
    
    static let appYellowColor = UIColor(red: 166/255, green: 206/255, blue: 58/255, alpha: 1)
    
    static let applightBrownColor = UIColor(red: 201/255, green: 208/255, blue: 219/255, alpha: 1)
    
    static let appBorderGrayColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1)
    
    static let appThemeRedColor = UIColor(red: 255/255, green: 81/255, blue: 59/255, alpha: 1)
    
    
    static let appThemePurpleColor = UIColor(red: 130/255, green: 83/255, blue: 225/255, alpha: 1)

    
    
    
    
    
    //static let headerViewColor = = UIColor(red: 0/255, green: 85/255, blue: 140/255, alpha: 1)
    
    
    //static let appDarkGray = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
    
    
    
    /*
	convenience init(netHex:Int) {
		//self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
        
        self.init(hex: hex, alpha:1)
	}*/
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
