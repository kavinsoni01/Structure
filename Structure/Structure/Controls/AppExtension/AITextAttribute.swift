//
//  AITextAttribute.swift
//  CRM
//
//  Created by Malav Soni on 05/01/17.
//  Copyright © 2017 AgileInfoWays Pvt.Ltd. All rights reserved.
//

import UIKit

class AITextAttribute: NSObject {
    var text:String = ""
    var textColor:UIColor = UIColor.black
    var textFont:UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    var shouldAddUnderline:Bool = false
    var textAlignment:NSTextAlignment = .left
    
    
    init(WithText text:String, Color textColor:UIColor, Font textFont:UIFont, Underline shouldAddUnderline:Bool,Alignment textAlignment:NSTextAlignment = .left) {
        self.text = text
        self.textColor = textColor
        self.textFont = textFont
        self.shouldAddUnderline = shouldAddUnderline
        self.textAlignment = textAlignment
    }
}
