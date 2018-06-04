//
//  Extension_UIButton.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	
	func makeBold(){
        
		self.titleLabel?.font = UIFont.appFont_Bold(fontSize: (self.titleLabel?.font.pointSize)!)
		self.setTitleColor(Constant.Colors.WHITE_COLOR, for: .normal)
	}
	
	func makeRegular(){
		self.titleLabel?.font = UIFont.appFont_Regular(fontSize: (self.titleLabel?.font.pointSize)!)
        
		self.setTitleColor(Constant.Colors.WHITE_COLOR, for: .normal)
	}
}
