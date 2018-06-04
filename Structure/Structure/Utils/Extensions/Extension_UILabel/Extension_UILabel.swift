//
//  Extension_UILabel.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation
import UIKit

extension UILabel {
	
	func setLineHeight(lineHeight: CGFloat) {
		self.setLineHeight(lineHeight: lineHeight, withAlignment: .left)
	}
   
        var numberOfVisibleLines: Int {
            let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
            let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
            let charSize: Int = lroundf(Float(self.font.pointSize))
            return rHeight / charSize
        }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2)
    {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
    
	
	func setLineHeight(lineHeight: CGFloat, withAlignment alignment:NSTextAlignment) {
		let text = self.text
		if let text = text {
			let attributeString = NSMutableAttributedString(string: text)
			
			let style = NSMutableParagraphStyle()
			style.lineSpacing = lineHeight
			style.alignment = alignment
			
            attributeString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
			self.attributedText = attributeString
		}
	}

    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        assert(self.attributedText != nil, "Sign Up")
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
    
	
	func addImageWith(name: String, behindText: Bool) {
		
		let attachment = NSTextAttachment()
		attachment.image = UIImage(named: name)
		let attachmentString = NSAttributedString(attachment: attachment)
		
		
		guard let txt = self.text else {
			return
		}
		
		
		if behindText {
			
			let strLabelText = NSMutableAttributedString(string: txt)
			strLabelText.append(attachmentString)
			
			self.attributedText = strLabelText
			
		} else {
			 
			let strLabelText = NSAttributedString(string: txt)
			let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
			mutableAttachmentString.append(strLabelText)
			
			self.attributedText = mutableAttachmentString
			
		}
		
	}
	
	func removeImage() {
		
		let text = self.text
		self.attributedText = nil
		self.text = text
	}
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
