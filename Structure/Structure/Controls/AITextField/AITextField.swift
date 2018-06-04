//
//  AITextField.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import UIKit




class AITextField: UITextField {
	
	
	//MARK:- PROPERTIES
	
	var shouldPreventAllActions:Bool = false
	var canCut:Bool = true
	var canCopy:Bool = true
	var canPaste:Bool = true
	var canSelect:Bool = true
	var canSelectAll:Bool = true

	var needToLayoutSubviews:Bool = true
	
	
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
	
	func commonInit(){
		
		self.borderStyle = .none
		
		self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
        
		self.tintColor = Constant.Colors.APP_COLOR_BLUE
		
		if(self.placeholder != nil )
        {
			self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: Constant.Colors.APP_COLOR_TF_PLACE_HOLDER])
		}
        
        self.textColor = UIColor.appBlackColor
		self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
		self.leftViewMode = .never
		
		self.autocorrectionType = .no
	}

	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if self.needToLayoutSubviews {
			self.addBorderWithColor(color: UIColor.lightGray, edge: AIEdge.Bottom, thicknessOfBorder: 0.4)
			self.needToLayoutSubviews = false
		}
	}

	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		
		if(self.shouldPreventAllActions){
			return false
		}
		
		switch action {
		case #selector(UIResponderStandardEditActions.cut(_:)):
			return self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
		case #selector(UIResponderStandardEditActions.copy(_:)):
			return self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
		case #selector(UIResponderStandardEditActions.paste(_:)):
			return self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
		case #selector(UIResponderStandardEditActions.select(_:)):
			return self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
		case #selector(UIResponderStandardEditActions.selectAll(_:)):
			return self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
		default:
			return super.canPerformAction(action, withSender: sender)
		}
	}
}


class AITextFieldMedium: UITextField , UITextFieldDelegate {
	
	
	//MARK:- PROPERTIES
	
	var shouldPreventAllActions:Bool = false
	var canCut:Bool = true
	var canCopy:Bool = true
	var canPaste:Bool = true
	var canSelect:Bool = true
	var canSelectAll:Bool = true
	
	var needToLayoutSubviews:Bool = true
    var clearButton : UIButton = UIButton()
    
    var spaceAllowed:Bool = true
    
    
    private var toolBar:UIToolbar?
    var image : UIImage? {
        didSet {
            if let rightImage = image {
                clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                clearButton.setImage(rightImage.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = UIColor.darkGray
                
                self.rightView = clearButton
                clearButton.addTarget(self, action: #selector(self.clearText(_:)), for: .touchUpInside)
                
                self.clearButtonMode = .never
                self.rightViewMode = .always
            }
        }
    }
    var blockDidEndEditing : ((_ textField: UITextField) -> Void)?
    var blockShoudlBeginEditing : ((_ textField: UITextField) -> Void)?
    var blockSearchButtonClick : ((_ index: Int) -> Void)?
    var blockClearButtonClick : ((_ tag : Int) -> Void)?
    var blockShouldChangeCharacter : ((_ textField: UITextField,_ range: NSRange,_ string: String) -> Bool)?
	
	//MARK:- INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
        self.font = UIFont.appFont_Medium(fontSize: self.font!.pointSize.proportionalFontSize())
        self.tintColor = Constant.Colors.APP_COLOR_BLUE
        
        if(self.placeholder != nil ){
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: Constant.Colors.APP_COLOR_TF_PLACE_HOLDER])
        }
		commonInit()
	}
	
	func commonInit(){
		self.delegate = self
		self.borderStyle = .none
				        
//        clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        clearButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
//        clearButton.tintColor = UIColor.darkGray
//
//        self.rightView = clearButton
//        clearButton.addTarget(self, action: #selector(self.clearText(_:)), for: .touchUpInside)
//
//        self.clearButtonMode = .never
//        self.rightViewMode = .always
		
		self.autocorrectionType = .no

	}
    
    @objc func clearText(_ sender: UIButton) {
        if self.blockSearchButtonClick != nil {
            self.blockSearchButtonClick?(sender.tag)
        }
        else {
            self.text = ""
            if self.blockClearButtonClick != nil {
                self.blockClearButtonClick?(self.tag)
            }
        }
    }
	
	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		
		if(self.shouldPreventAllActions){
			return false
		}
		
		switch action {
		case #selector(UIResponderStandardEditActions.cut(_:)):
			return self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
		case #selector(UIResponderStandardEditActions.copy(_:)):
			return self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
		case #selector(UIResponderStandardEditActions.paste(_:)):
			return self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
		case #selector(UIResponderStandardEditActions.select(_:)):
			return self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
		case #selector(UIResponderStandardEditActions.selectAll(_:)):
			return self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
		default:
			return super.canPerformAction(action, withSender: sender)
		}
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // white space not allowed in textfield
        if !spaceAllowed
        {
            
           // if(textField.text == "")  // space not allowed in between
            //{
                if string == " "  //space not allwed in textfield
                {
                    return false
                }
           // }
        }
        
        if self.blockShouldChangeCharacter != nil {
            return (self.blockShouldChangeCharacter?(textField, range, string))!
        }
        
        return true
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.blockShoudlBeginEditing != nil {
            self.blockShoudlBeginEditing?(textField)
            return true
        }
        else {
            return false
        }
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.keyboardType == .numberPad || textField.keyboardType == .phonePad {
            addToolBar()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.blockDidEndEditing != nil {
            blockDidEndEditing?(textField)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}

class AITextFieldNormalBold: UITextField {
	
	
	//MARK:- PROPERTIES
	
	var shouldPreventAllActions:Bool = false
	var canCut:Bool = true
	var canCopy:Bool = true
	var canPaste:Bool = true
	var canSelect:Bool = true
	var canSelectAll:Bool = true
	
	var needToLayoutSubviews:Bool = true
	
	
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
	
	func commonInit(){
		
		self.borderStyle = .none
		
		self.font = UIFont.appFont_Bold(fontSize: self.font!.pointSize.proportionalFontSize())
		self.tintColor = Constant.Colors.APP_COLOR_BLUE
		
		if(self.placeholder != nil ){
			self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: Constant.Colors.APP_COLOR_TF_PLACE_HOLDER])
		}
		
		self.autocorrectionType = .no
		
	}
	
	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		
		if(self.shouldPreventAllActions){
			return false
		}
		
		switch action {
		case #selector(UIResponderStandardEditActions.cut(_:)):
			return self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
		case #selector(UIResponderStandardEditActions.copy(_:)):
			return self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
		case #selector(UIResponderStandardEditActions.paste(_:)):
			return self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
		case #selector(UIResponderStandardEditActions.select(_:)):
			return self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
		case #selector(UIResponderStandardEditActions.selectAll(_:)):
			return self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
		default:
			return super.canPerformAction(action, withSender: sender)
		}
	}
}

class AITextFieldPicker:UITextField,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate
{
    //MARK:- PROPERTIES
    
    var shouldPreventAllActions:Bool = false
    var canCut:Bool = false
    var canCopy:Bool = false
    var canPaste:Bool = false
    var canSelect:Bool = false
    var canSelectAll:Bool = false
    
    var needToLayoutSubviews:Bool = true
    
    private var valuePicker:UIPickerView?

    
    private var toolBar:UIToolbar?
    var aryValueForPicker:[Any] = []
    var selectedPickerViewObject:Any?
    private var selectedPickerValue:String = ""
    
    var textFieldValueChangeNotification:((_ newValue:Any?)->())?
    
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
    
    func commonInit(){
        
        self.borderStyle = .none
        
        self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
        self.tintColor = Constant.Colors.APP_COLOR_BLUE
        
        if(self.placeholder != nil ){
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: Constant.Colors.APP_COLOR_TF_PLACE_HOLDER])
        }
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        self.leftViewMode = .always
        
        self.autocorrectionType = .no
        self.addPickerViewAsInputView()
    }
    
    func addPickerViewAsInputView() -> Void
    {
        
        self.valuePicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: 200))
        self.valuePicker?.delegate = self
        self.valuePicker?.dataSource = self
        self.valuePicker?.backgroundColor = UIColor.white
        self.valuePicker?.translatesAutoresizingMaskIntoConstraints = false
        self.valuePicker?.reloadAllComponents()
        self.inputView = self.valuePicker
        
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(AITextFieldPicker.cancelButtonClick))
            
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        )
        items.append(
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(AITextFieldPicker.doneButtonClick))
        )
        toolBar = UIToolbar.init()
        toolBar?.barStyle = .default
        toolBar?.sizeToFit()
        toolBar?.items = items
        self.inputAccessoryView = toolBar;
        
    }
    @objc private func doneButtonClick() -> Void
    {
        
        selectedPickerValue = self.text!
        if selectedPickerViewObject != nil
        {
            self.sendValueChangeNotification(selectedPickerViewObject)
            
        }
        self.resignFirstResponder()
    }
    @objc private func cancelButtonClick() -> Void
    {
        self.text = selectedPickerValue
        self.resignFirstResponder()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if self.needToLayoutSubviews {
            self.addBorderWithColor(color: Constant.Colors.APP_COLOR_LIGHT_GRAY, edge: AIEdge.Bottom, thicknessOfBorder: 1)
            self.needToLayoutSubviews = false
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    {
        
        if(self.shouldPreventAllActions){
            return false
        }
        
        switch action {
        case #selector(UIResponderStandardEditActions.cut(_:)):
            return self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
        case #selector(UIResponderStandardEditActions.copy(_:)):
            return self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
        case #selector(UIResponderStandardEditActions.paste(_:)):
            return self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
        case #selector(UIResponderStandardEditActions.select(_:)):
            return self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
        case #selector(UIResponderStandardEditActions.selectAll(_:)):
            return self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }
    //MARK:- Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        selectedPickerValue = self.text!;
        
        if self.aryValueForPicker.count > 0
        {
            let value = aryValueForPicker[0]
            if value is String
            {
                selectedPickerValue = selectedPickerValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                var index:Int = 0
                if selectedPickerValue.count > 0
                {
                    let indexes = aryValueForPicker.enumerated().filter
                    {
                        ($0.element as AnyObject).contains(selectedPickerValue)
                        }.map{$0.offset}
                    if indexes.count > 0
                    {
                        index = indexes[0]
                        if let value:UIPickerView = self.inputView as? UIPickerView
                        {
                            value.selectRow(index, inComponent: 0, animated: true)
                        }
                    }
                }
                else
                {
                    if let object:String = value as? String
                    {
                        self.text = object;
                        selectedPickerViewObject = object
                    }
                }
            }
            
            
        }
        else
        {
            //self.endEditing(true)
            
//            CRMAlert.shared.displayAlertWithoutCancelButton(title: Constant.App.Name, message: "No Data Available", buttons: ["Ok"], completion: { (index) in
//                self.resignFirstResponder()
//            })
            //return
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if self.selectedPickerViewObject != nil
        {
            self.sendValueChangeNotification(self.selectedPickerViewObject)
        }
        
        
    }
    
    //MARK:- PickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.aryValueForPicker.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        if let value:String = self.aryValueForPicker[row] as? String{
            return value
        }
        else
        {
            
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if let value = self.aryValueForPicker[row]  as? String
        {
            if row < aryValueForPicker.count
            {
                self.selectedPickerViewObject = value
                self.text = value
                self.sendValueChangeNotification(value)
            }
        }
        else
        {
            self.text = ""
        }
    }
    fileprivate func sendValueChangeNotification(_ value:Any?) -> ()
    {
        if let valueChangeNotificationValue = textFieldValueChangeNotification
        {
            valueChangeNotificationValue(value)
        }
    }
    
}
