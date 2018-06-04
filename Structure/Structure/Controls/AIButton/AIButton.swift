//
//  AIButton.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//

import UIKit


enum AIButtonType:Int {
    case none
    case blueGradient
    case borderGradient
    case CircleGradient
    case underline
    case red
    case disable
    case normal
}




class AIButton: UIButton {

	//MARK:- INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		commonInit()
        self.updateUIAccordingToButtonType()

	}
    
    var aiButtonType:AIButtonType = .blueGradient{
        didSet{
            self.updateUIAccordingToButtonType()
        }
    }
    
	
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.layer.sublayers?.forEach({ (subLayer) in
            if subLayer is CAGradientLayer
            {
                if self.aiButtonType == .borderGradient
                {
                    subLayer.removeFromSuperlayer()
//                    self.layer.addGradientBorder(WithColors: [gradientLeftColor,gradientRightColor], Width: 2.0)
                }
                    
                else if self.aiButtonType == .underline
                {
                    subLayer.removeFromSuperlayer()
                    subLayer.frame = self.bounds
                }
                else if self.aiButtonType == .normal
                {
                    subLayer.removeFromSuperlayer()
                    subLayer.frame = self.bounds
                }
                else if self.aiButtonType == .none
                {
                    subLayer.removeFromSuperlayer()
                    subLayer.frame = self.bounds
                }
                else
                {
                    subLayer.frame = self.bounds
                }
            }
        })
    }
    
	private func commonInit(){
		self.titleLabel!.font = UIFont.appFont_Medium(fontSize: self.titleLabel!.font.pointSize.proportionalFontSize())
        
        self.backgroundColor = UIColor.appThemePurpleColor
        self.setTitleColor(UIColor.white, for: .normal)
        
        //self.titleLabel?.font = UIFont.customSemiboldFontWithSize(size: constant.fontSizeSixteen)
        
		self.isExclusiveTouch = true
	}
	
    func animateSelectedStateWithAnimation(WithSameEffectOnStateChange sameEffectOnStateChange:Bool, OnCompletion completion: @escaping () -> Void){
		
		// TO DISABLE QUICK NEW ANIMATION UNTIL PREVIOUS ONE COMPLETES
		self.isUserInteractionEnabled = false
		
		if(self.isSelected){
			
			UIView.transition(with: self, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
				self.isSelected = !self.isSelected
				
			}, completion: { (ss) in
				self.isUserInteractionEnabled = true
				//completion()
                completion()
			})
			return
		}
		
		if(sameEffectOnStateChange){
			
			UIView.transition(with: self, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
				self.isSelected = !self.isSelected
				
			}, completion: { (ss) in
				self.isUserInteractionEnabled = true
				//completion()
                completion()
			})
			return
		}
		
		UIView.animate(withDuration: 0.2 ,
		                           animations: {
									self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		},
		                           completion: { finish in
									
									UIView.animate(withDuration: 0.2 ,
									                           animations: {
																self.isSelected = !self.isSelected
																self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
									},
									                           completion: { finish in
																
																
																UIView.animate(withDuration: 0.2 ,
																                           animations: {
																							self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
																},
																                           completion: { finish in
																							UIView.animate(withDuration: 0.2){
																								self.transform = CGAffineTransform.identity
																								self.isUserInteractionEnabled = true
																								//completion()
                                                                                                completion()
																							}
																})
									})
		})
	}
	
	
	
	func animateSelectedStateWithAnimationOnCompletion(completion: @escaping () -> Void){
		
		// TO DISABLE QUICK NEW ANIMATION UNTIL PREVIOUS ONE COMPLETES
		self.isUserInteractionEnabled = false
		
		if(self.isSelected){
			
			UIView.transition(with: self, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
				self.isSelected = !self.isSelected
				
			}, completion: { (ss) in
				self.isUserInteractionEnabled = true
				//completion()
                completion()
			})
			return
		}
		
		
		UIView.animate(withDuration: 0.2 ,
		                           animations: {
									self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		},
		                           completion: { finish in
									
									UIView.animate(withDuration: 0.2 ,
									                           animations: {
																self.isSelected = !self.isSelected
																self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
									},
									                           completion: { finish in
																
																
																UIView.animate(withDuration: 0.2 ,
																                           animations: {
																							self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
																},
																                           completion: { finish in
																							UIView.animate(withDuration: 0.2){
																								self.transform = CGAffineTransform.identity
																								self.isUserInteractionEnabled = true
																								//completion()
                                                                                                completion()
																							}
																})
									})
		})
		
	}

    
    
    func updateUIAccordingToButtonType() -> Void {
        switch self.aiButtonType {
        case .none:
            self.layer.sublayers?.removeLast()
            break
        case .blueGradient:

            self.layer.cornerRadius = 5.0
            self.clipsToBounds = true;
//    /            self.layer.addGradientBackground(WithColors: [gradientRightColor,gradientLeftColor])
//            self.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.layoutIfNeeded()
            break
        case .borderGradient:
//            self.backgroundColor = UIColor.white
//            self.layer.addGradientBorder(WithColors: [gradientLeftColor,gradientRightColor], Width: 2.0)
//            self.setTitleColor(UIColor.appThemeBlueColor(), for: UIControlState.normal)
//            self.layoutIfNeeded()
            break
            
        case .CircleGradient:
//            self.layer.addRoundGradientBackground(WithColors: [gradientRightColor,gradientLeftColor])
//            self.addDropShadow()
//            self.setTitleColor(UIColor.white, for: UIControlState.normal)
//            self.layoutIfNeeded()
            break
        case .disable:
            self.backgroundColor = UIColor.lightGray
            self.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.layoutIfNeeded()
            break
        case .underline:
            
            if let strText:String = self.title(for: UIControlState.normal)
            {
                let dict = NSString .getDictionaryForAttributedString(withString: strText, FontForString: UIFont .appFont_Regular(fontSize: 11.0), ColorForString: UIColor .appThemePurpleColor, AllowUnderline: true)
                
                self.setAttributedTitle(NSString .getCustomAttributedStringForText(strText as NSString, andSubStringData: [dict], normatTextColor: UIColor .appThemePurpleColor, defaultTextFont:UIFont.appFont_Regular(fontSize: 11.0) , textAlignment: .left), for: UIControlState.normal)
            }
            self.setTitleColor(UIColor.appBlackColor, for: UIControlState.normal)
            //self.backgroundColor = UIColor.white
            self.layoutIfNeeded()
            
            break
        case .red:
            self.backgroundColor = UIColor.appThemeRedColor
            self.setTitleColor(UIColor.white, for: UIControlState.normal)
            break
        case .normal:
            
            self.setTitleColor(UIColor.black, for: .normal)
            self.backgroundColor = UIColor.white
            self.layoutIfNeeded()
            break
        default:
            
            self.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            break
            
        }
    }
    
    
}


class AIButtonBold: UIButton {
	
	//MARK:- INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		commonInit()
	}
	
	private func commonInit(){
		self.titleLabel!.font = UIFont.appFont_Bold(fontSize: self.titleLabel!.font.pointSize.proportionalFontSize())
		self.isExclusiveTouch = true
	}
}





class AIButtonPickerItem:NSObject {
	
	var itemName:String = ""
    var code : String = ""
	var isSelected:Bool = false
	
	override init() {
		
	}
	
    init(withName name:String , code: String) {
		self.itemName = name
        self.code = code
	}
}


class AIButtonPicker: UIButton, UIPickerViewDataSource, UIPickerViewDelegate
{
	var pickerView:UIPickerView?
	var toolBarForInputAccessoryView:UIToolbar?
	var arrDataSource:[AIButtonPickerItem] = []
	var arrDataSource1:[AIButtonPickerItem] = []
	
	var btnCancel: AIButton = AIButton()
    let btnDone: AIButton = AIButton()
	
	var btnPressHandler: ((_ sender:AIButtonPicker) -> (Void))?
	var cancelHandler: ((_ sender:AIButtonPicker) -> (Void))?
	var doneHandler: ((_ row: Int) -> (Void))?
	var dateValueChangeHandler: ((_ sender:AIButtonPicker) -> (Void))?
    var didPickValue : ((_ row: Int) -> Void)?
	
	var viewTransparent:UIView?
    var selectedRow : Int = 0
	
	// MARK: - INIT
	override func awakeFromNib() {
		super.awakeFromNib()
		self.isExclusiveTouch = true
		self.doSetupInputView()
		self.backgroundColor = UIColor.clear
	}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
    }
	
	
	// MARK:- OVERRIDING
	override var inputView: UIView? {
		get {
			return self.pickerView
		}
		set {
			self.inputView = self.pickerView
		}
	}
	
	override var inputAccessoryView: UIView? {
		get {
			return self.toolBarForInputAccessoryView
		}
		set {
			self.inputAccessoryView = self.toolBarForInputAccessoryView
		}
	}
//	override func canBecomeFirstResponder() -> Bool {
//		return true
//	}

	 override var canBecomeFirstResponder: Bool {
		return true
	}
	
	// MARK:- SETUP INPUT AND ACCESSORY VIEWS
	func doSetupInputView()
	{
		// UIPICKERVIEW
		
		self.pickerView = UIPickerView()
		self.pickerView!.backgroundColor = UIColor.white
		self.pickerView?.dataSource = self
		self.pickerView?.delegate = self
		
		// TOOLBAR ITEMS
		
		btnCancel.setTitle("Cancel", for: .normal)
		//btnCancel.setTitleColor(UIColor.blueZodiac, for: .normal)
		btnCancel.addTarget(self, action: #selector(self.btnCancelHandler(sender:)), for: .touchUpInside)
		btnCancel.sizeToFit()
		
		
		btnDone.setTitle("Done", for: .normal)
		//btnDone.setTitleColor(UIColor.blueZodiac, for: .normal)
		btnDone.addTarget(self, action: #selector(self.btnDoneHandler(sender:)), for: .touchUpInside)
		btnDone.sizeToFit()
		
		let barBtnCancel: UIBarButtonItem = UIBarButtonItem.init(customView: btnCancel)
		let barBtnDone: UIBarButtonItem = UIBarButtonItem.init(customView: btnDone)
		let barBtnFlexibleSpace: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		
		// TOOLBAR
		self.toolBarForInputAccessoryView = UIToolbar()
		self.toolBarForInputAccessoryView!.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)
		self.toolBarForInputAccessoryView!.barTintColor = Constant.Colors.WHITE_COLOR
		self.toolBarForInputAccessoryView!.isTranslucent = true
		self.toolBarForInputAccessoryView!.items = [barBtnCancel,barBtnFlexibleSpace,barBtnDone]
		
		// ADDING TARGET
		
		self.addTarget(self, action: #selector(self.btnTapHandler(sender:)), for: .touchUpInside)
	}
	
	
	// MARK: - PICKERVIEW DELEGATE
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return self.arrDataSource1.count == 0 ? 1 : 2
	}
	
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		//		return self.arrDataSource.count
		
		var rowsToReturn:Int = 0
		if(self.arrDataSource1.count == 0){
			rowsToReturn = self.arrDataSource.count
		}else{
			switch component {
			case 0:
				rowsToReturn = self.arrDataSource.count
			case 1:
				rowsToReturn = self.arrDataSource1.count
			default:
				break
			}
		}
		return rowsToReturn
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		
		let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
		lblTitle.textAlignment = .center
		lblTitle.textColor = Constant.Colors.APP_COLOR_BLUE
		lblTitle.font = UIFont.appFont_Regular(fontSize: CGFloat(18).proportionalFontSize())
		//		lblTitle.text = self.arrDataSource[row].itemName
		
		
		var title:String = ""
		if(self.arrDataSource1.count == 0){
			title = self.arrDataSource[row].itemName
		}else{
			switch component {
			case 0:
				title = self.arrDataSource[row].itemName
			case 1:
				title = self.arrDataSource1[row].itemName
			default:
				break
			}
		}
		lblTitle.text = title
		return lblTitle
	}
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //print(arrDataSource[row].code)
        //print(arrDataSource[row].itemName)
        self.selectedRow = row
    }
	
	
	// MARK: - BUTTON HANDLER
	
    @objc func btnTapHandler(sender:UIButton){
		
        if !IS_INTERNET_AVAILABLE() {
            SHOW_INTERNET_ALERT()
            return
        }
        
		self.showTransparentViewBehindKeyboard()
		
		//		self.datePickerView!.datePickerMode = self.datePickerViewMode != nil ? self.datePickerViewMode! : UIDatePickerMode.DateAndTime
		
		
		self.becomeFirstResponder()
		if((self.btnPressHandler) != nil){
			self.btnPressHandler!(self)
		}
	}
	
    @objc func btnCancelHandler(sender:UIButton) {
		
		self.resignFirstResponder()
		self.hideTransparentViewBehindKeyboard()
		
		if((self.cancelHandler) != nil){
			self.cancelHandler!(self)
		}
	}
    @objc func btnDoneHandler(sender:UIButton) {
		
		self.resignFirstResponder()
		self.hideTransparentViewBehindKeyboard()
		
		if((self.doneHandler) != nil){
			self.doneHandler!(selectedRow)
		}
	}
	
	func datePickerValueChangedHandler(sender: UIDatePicker) {
		
		if(self.dateValueChangeHandler != nil){
			self.dateValueChangeHandler!(self)
		}
	}
	
	
	//MARK:- SHOW / HIDE TRANSPARENT VIEW
	
	func showTransparentViewBehindKeyboard() {
		
		self.viewTransparent = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
		self.viewTransparent!.backgroundColor = Constant.Colors.BLACK_COLOR
		Constant.appDelegate.window?.addSubview(viewTransparent!)
		self.viewTransparent?.alpha = 0
		
		UIView.animate(withDuration: 0.3) {
			self.viewTransparent?.alpha = 0.2
		}
	}
	
	func hideTransparentViewBehindKeyboard() {
		
		UIView.animate(withDuration: 0.3, animations: {
			self.viewTransparent?.alpha = 0
		}) { (bbb) in
			self.viewTransparent?.removeFromSuperview()
		}
	}
	
}
