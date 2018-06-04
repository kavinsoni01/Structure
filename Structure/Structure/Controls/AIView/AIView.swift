//
//  AIView.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import UIKit

class AIView: UIView {

}


class AIViewRound: UIView {

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.backgroundColor = Constant.Colors.WHITE_COLOR
		self.applyCircle()
		
		
	}
	override func layoutSubviews() {
		self.applyCircle()
	}
	
	required override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	override func draw(_ rect: CGRect) {
		
	}
}

class AIViewWithDashedLineBorder: UIView {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	required override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	override func draw(_ rect: CGRect) {
		self.applyCircle()

//		let path = UIBezierPath(roundedRect: rect, cornerRadius: 0)
//		
//		CLEAR_COLOR.setFill()
//		path.fill()
//		
//		WHITE_COLOR.setStroke()
//		path.lineWidth = 2.0
//		
//		let dashPattern : [CGFloat] = [10, 4]
//		path.setLineDash(dashPattern, count: 2, phase: 0)
//		path.stroke()
		

	}
}
class customHeaderView: UIView {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func layoutSubviews() {
        
        self.backgroundColor = UIColor(patternImage: self.applyNavigationBarGradient(colours: [.gradientFirstColor,.gradientSecondColor], style: .leftToRight))
        
    }
    
    
    
    
    
}
