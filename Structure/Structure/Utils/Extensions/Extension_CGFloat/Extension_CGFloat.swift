//
//  Extension_CGFloat.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 22/06/17.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation
import CoreGraphics

extension CGFloat{
	
	init?(_ str: String) {
		guard let float = Float(str) else { return nil }
		self = CGFloat(float)
	}

	
	func twoDigitValue() -> String {
		
		let formatter = NumberFormatter()
		formatter.maximumFractionDigits = 2
		formatter.minimumFractionDigits = 0
		formatter.roundingMode = NumberFormatter.RoundingMode.halfUp //NumberFormatter.roundingMode.roundHalfUp
	
		
//		let str : NSString = formatter.stringFromNumber(NSNumber(self))!
		let str = formatter.string(from: NSNumber(value: Double(self)))
		return str! as String;
	}

	
	
    func proportionalFontSize() -> CGFloat {

        var sizeToCheckAgainst = self

        switch Devices.deviceType!
        {
        case .iPad:
             sizeToCheckAgainst += 12
            break;
        case .iPhoneX:
            sizeToCheckAgainst += 2
            break;
        case .iPhone6por6sp:
            sizeToCheckAgainst += 1
            break;
        case .iPhone6or6s:
            sizeToCheckAgainst += 0
            break;
        case .iPhone5or5s:
            sizeToCheckAgainst -= 1
            break;
        case .iPhone4or4s:
            sizeToCheckAgainst -= 1

        }

        return sizeToCheckAgainst
    }
}
