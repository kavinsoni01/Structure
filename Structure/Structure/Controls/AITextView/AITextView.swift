//
//  AITextView.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import UIKit
import PureLayout


class AITextView: UITextView , UITextViewDelegate {
	
	//MARK:- PROPERTIES
	var lblPlaceHolder : AILabel?
	
	var strPlaceHolder:String = "Type.." {
		didSet{
			self.lblPlaceHolder?.text = strPlaceHolder
		}
	}
	
	override open var text: String! {
		didSet {
			 lblPlaceHolder?.isHidden = !text.isEmpty
		}
	}
	
	var blockTextViewShouldChangeTextInRangeWithReplacementText:((_ textView: UITextView, _ range: NSRange, _ text: String) -> Bool)?
	var blockTextViewDidEndEditing:(()->(Void))?
	
	var needToLayoutSubviews:Bool = true
	private var toolBar:UIToolbar?
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		
		var shouldReturn:Bool = true

		if text == "\n" {
			return true
		}
		if(self.blockTextViewShouldChangeTextInRangeWithReplacementText != nil){
			shouldReturn = self.blockTextViewShouldChangeTextInRangeWithReplacementText!(textView, range, text)
		}
		
		let fullText = (textView.text! as NSString).replacingCharacters(in: range, with: text);
		lblPlaceHolder?.isHidden = !fullText.isEmpty
		
		return shouldReturn
	}

	
	//MARK:- INIT
	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		self.commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		self.commonInit()
	}
    
    public func addToolBar() {
        var items = [UIBarButtonItem]()
        
        items.append(
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonClick))
        )
        toolBar = UIToolbar.init()
        toolBar?.barStyle = .default
        toolBar?.sizeToFit()
        toolBar?.items = items
        self.inputAccessoryView = toolBar;
    }
    
    @objc private func doneButtonClick() -> Void
    {
        self.resignFirstResponder()
    }
	
	private func commonInit() {
		
		//self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
		self.tintColor = Constant.Colors.APP_COLOR_BLUE
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
		self.delegate = self
		
		self.clipsToBounds = true
		
		// ADDING PLACEHOLDER LABEL
		if(self.lblPlaceHolder == nil){
			self.lblPlaceHolder = AILabel(forAutoLayout: ())
			self.addSubview(self.lblPlaceHolder!)
			self.lblPlaceHolder?.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset:self.textContainerInset.left + 5)
			self.lblPlaceHolder?.autoPinEdge(toSuperviewEdge: ALEdge.top, withInset: self.textContainerInset.top)
			self.lblPlaceHolder?.text = self.strPlaceHolder
			self.lblPlaceHolder?.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize)
			self.lblPlaceHolder?.textColor = Constant.Colors.APP_COLOR_TF_PLACE_HOLDER
		}
		
		
	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
//		if self.needToLayoutSubviews {
//			self.addBorderWithColor(color: APP_COLOR_LIGHT_GRAY, edge: AIEdge.Bottom, thicknessOfBorder: 1)
//			self.needToLayoutSubviews = false
//		}
	}

	
	//MARK:- TEXTVIEW DELEGATE
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if(self.blockTextViewDidEndEditing != nil){
			self.blockTextViewDidEndEditing!()
		}
	}
	
	
//	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//		
//		let fullText = (textView.text! as NSString).replacingCharacters(in: range, with: text);
//		
//		if(self.blockTextViewShouldChangeTextInRangeWithReplacementText != nil){
//			
//			let shouldReturn = self.blockTextViewShouldChangeTextInRangeWithReplacementText!(textView, range, fullText)
//			if(!shouldReturn){
//				return false
//			}
//			self.lblPlaceHolder?.isHidden = fullText.characters.count > 0
//			return shouldReturn
//		}else{
//			self.lblPlaceHolder?.isHidden = fullText.characters.count > 0
//		}
//		
//		return true
//	}

}
