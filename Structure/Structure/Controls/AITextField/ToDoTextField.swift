//
//  ToDoTextField.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2018 agile-m-32. All rights reserved.
//

import UIKit

enum ToDoTextFieldType {
    case standard
}


enum ToDoTextFieldValidationType : Int
{
    case none
    case name
    case email
    case password
    case numbers
    case characters
    case characters_WithSpace
    case alphaNumeric
    case alphaNumeric_WithSpace
    case alphaNumeric_WithSpace_SpecialCharacter
    case amountValidation
    case currency
    case minMaxNumber
    case numericOnly
    
    
}



class ToDoTextField: UITextField ,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
    
    //MARK:- Public Vars
    var textFieldValueChangeNotification:((_ newValue:Any?)->())?
    var bottomBorderWidth:CGFloat = 1.0
    var borderActiveColor = UIColor .appThemePurpleColor//(UIApplication.shared.delegate as? AppDelegate)?.window?.tintColor ?? UIColor.appThemeBlueColor()
    var borderInActiveColor = UIColor .groupTableViewBackground //UIColor(red: 136/255.0, green: 136/255.0, blue: 136/255.0, alpha: 1.0)
    
    //MARK:- Private Vars
    
    // UI Helper
    private let imgBottomBorder = UIImageView()
    private let lblPlaceholder:UILabel = UILabel()
    private let placeholderColor = UIColor .lightGray
    private let textFieldFont = UIFont.appFont_Regular(fontSize: UIFont.systemFontSize )
    //UIFont.systemFont(ofSize: UIFont.systemFontSize)//.systemFont(WithSize: UIFont.systemFontSize)
    private let contentPadding:CGFloat = 10.0
    
    private var valuePicker:UIPickerView?
    private var datePicker:UIDatePicker?
    var timePicker:UIDatePicker?
    var minimumDate:Date = Date()
    var maximumDate:Date = Date()
    private var selectedPickerValue:String = ""
    private var toolBar:UIToolbar?
    fileprivate var btnDone:UIButton?
    var maxCharacterLimit:NSInteger = 20
    var disablePasteOption:Bool = false;
    
    override var text: String?{
        didSet
        {
            // Update Position Of Placeholder
            
            self.updatePlaceholderPosition(WithAnimation: false)
        }
    }
    
    var aryValueForPicker:[Any] = []
    
    var selectedPickerViewObject:Any?
    
    // Override Existing Vars
    override var placeholder: String?{
        didSet{
            if let newPlaceHolder = self.placeholder{
                if newPlaceHolder.characters.count > 0 {
                    self.placeholder = ""
                    self.lblPlaceholder.text = newPlaceHolder
                    self.lblPlaceholder.font = UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
                }
            }
        }
    }
    
    var textFieldType:ToDoTextFieldType = ToDoTextFieldType.standard{
        didSet{
            switch textFieldType
            {
            case .standard:
                self.rightImageValue = UIImage()
                self.inputView = nil
                self.inputAccessoryView = nil
                break
            }
            
        }
    }
    
    var rightImageValue:UIImage?{
        didSet{
            if let availableRightImage = rightImageValue{
                let imgRightView = UIImageView(frame: CGRect.init(x: 0, y: 8, width: 40.0, height: self.bounds.size.height))
                imgRightView.contentMode = .center
                imgRightView.backgroundColor = UIColor.clear
                imgRightView.image = availableRightImage
                self.rightView = imgRightView
                self.rightViewMode = .always
            }
        }
    }
    
    var leftImageValue:UIImage?{
        didSet{
            if let availableLeftImage = leftImageValue{
                let imgLeftView = UIImageView(frame: CGRect.init(x: 0, y: 8, width: 40.0, height: self.bounds.size.height))
                imgLeftView.contentMode = .center
                imgLeftView.backgroundColor = UIColor.clear
                imgLeftView.image = availableLeftImage
                self.leftView = imgLeftView
                self.leftViewMode = .always
            }
        }
    }
    
    //MARK:- Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func addImageAtRightCorner(_ imgRightImage:UIImage?, ShouldShowWhenValidValue shouldShowWhenValidValue:Bool) -> Void {
        if imgRightImage == nil{
            self.rightView = nil
            self.rightViewMode = UITextFieldViewMode.never
        }else{
            let imgRightView = UIImageView(image: imgRightImage)
            imgRightView.frame = CGRect(x: 0, y: 0, width: 44.0, height: self.bounds.size.height)
            imgRightView.contentMode = UIViewContentMode.right
            
            self.rightView = imgRightView
            self.rightViewMode = UITextFieldViewMode.never
        }
    }
    
    //MARK:- Private Helper Methods
    fileprivate func commonInit()->(){
        
        // Delegate
        self.delegate = self
        
        // Set font
        self.font = textFieldFont
        
        // Tint Color
        self.tintColor = self.borderActiveColor
        
        // Text Color
        self.textColor = UIColor.black
        
        // Update Border Style to None
        self.borderStyle = UITextBorderStyle.none
        
        // Background Color
        self.backgroundColor = UIColor.white
        
        // Value Change Method
        self.addTarget(self, action: #selector(ToDoTextField.textFieldValueChangeMethod(_:)) , for: UIControlEvents.editingChanged)
        
        // Add Bottom Border
        imgBottomBorder.frame = CGRect.init(x: 0.0, y: self.bounds.size.height-bottomBorderWidth, width: self.bounds.size.width, height: bottomBorderWidth)
        imgBottomBorder.backgroundColor = UIColor.clear
        imgBottomBorder.layer.backgroundColor = borderInActiveColor.cgColor
        imgBottomBorder.autoresizingMask = [.flexibleWidth,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        imgBottomBorder.translatesAutoresizingMaskIntoConstraints = true
        self.addSubview(imgBottomBorder)
        
        //  Update Placeholde Style
        self.updatePlaceholderStyle()
        
    }
    
    // Update Placeholder Style
    fileprivate func updatePlaceholderStyle()->(){
        if (self.placeholder?.characters.count ?? 0) > 0{
            self.lblPlaceholder.text = self.placeholder
            self.placeholder = ""
        }
        self.lblPlaceholder.font = self.font ?? UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
        self.lblPlaceholder.textColor = placeholderColor
        self.addSubview(self.lblPlaceholder)
        
        self.updatePlaceholderPosition(WithAnimation: false)
    }
    
    private func updatePlaceholderPosition(WithAnimation withAnimation:Bool)->Void
    {
        if withAnimation == true{
            UIView.animate(withDuration: 0.25)
            {
                
                self.imgBottomBorder.frame = CGRect.init(x: 0.0, y: self.bounds.size.height-(self.bottomBorderWidth+1.0), width: self.bounds.size.width, height: self.bottomBorderWidth+1.0)
                
                if (self.text?.characters.count ?? 0) > 0{
                    self.lblPlaceholder.frame = CGRect.init(x: 0, y: (self.contentPadding/2), width: self.bounds.size.width, height: (self.bounds.size.height/4))
                    self.lblPlaceholder.font = UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
                    self.lblPlaceholder.textColor = self.tintColor
                }else{
                    self.lblPlaceholder.frame = CGRect.init(x: 0, y: (self.contentPadding/2), width: self.bounds.size.width, height: (self.bounds.size.height))
                    self.lblPlaceholder.font = UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
                    self.lblPlaceholder.textColor = self.placeholderColor
                    
                }
            }
        }
        else
        {
            self.imgBottomBorder.frame = CGRect.init(x: 0.0, y: self.bounds.size.height-(self.bottomBorderWidth+1.0), width: self.bounds.size.width, height: self.bottomBorderWidth+1.0)
            
            if (self.text?.characters.count ?? 0) > 0{
                self.lblPlaceholder.frame = CGRect.init(x: 0, y: (self.contentPadding/2), width: self.bounds.size.width, height: (self.bounds.size.height/4))
                self.lblPlaceholder.font = UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
                self.lblPlaceholder.textColor = self.tintColor
            }else{
                self.lblPlaceholder.frame = CGRect.init(x: 0, y: (self.contentPadding/2), width: self.bounds.size.width, height: (self.bounds.size.height))
                self.lblPlaceholder.font = UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
                self.lblPlaceholder.textColor = self.placeholderColor
            }
        }
    }
    
    // When Text Change This Method will be called
    @objc func textFieldValueChangeMethod(_ sender:UITextField) -> Void {
        self.sendValueChangeNotification(sender.text)
        
        //        if let strValue = sender.text{
        //            if strValue.characters.count > 0{
        //                self.rightViewMode = UITextFieldViewMode.always
        //            }else{
        //                self.rightViewMode = UITextFieldViewMode.never
        //            }
        //        }
        //self.updatePlaceholderPosition(WithAnimation: true)
    }
    
    // Send Notification From Anywhere Using this Method
    fileprivate func sendValueChangeNotification(_ value:Any?) -> ()
    {
        if let valueChangeNotificationValue = textFieldValueChangeNotification
        {
            valueChangeNotificationValue(value)
        }
    }
    
    //MARK:- Content Position
    override func textRect(forBounds bounds:CGRect) -> CGRect
    {
        
        var textRect:CGRect = CGRect(x:bounds.origin.x, y: contentPadding-4.0,width: bounds.size.width, height: bounds.size.height).insetBy(dx: 0, dy: 0);
        
        if self.textFieldType == .standard
        {
            textRect = CGRect(x:bounds.origin.x, y: contentPadding-4.0,width: bounds.size.width, height: bounds.size.height).insetBy(dx: 0, dy: 0);
        }
        else
        {
            textRect = CGRect(x:bounds.origin.x, y: contentPadding-4.0,width: bounds.size.width-(self.rightView?.frame.size.width)!, height: bounds.size.height).insetBy(dx: 0, dy: 0);
        }
        
        return textRect
        
    }
    override func editingRect(forBounds bounds:CGRect) -> CGRect
    {
        var textRect:CGRect = CGRect(x:bounds.origin.x, y: contentPadding-4.0,width: bounds.size.width, height: bounds.size.height).insetBy(dx: 0, dy: 0);
        
        if self.textFieldType == .standard
        {
            textRect = CGRect(x:bounds.origin.x, y: contentPadding-4.0,width: bounds.size.width, height: bounds.size.height).insetBy(dx: 0, dy: 0);
        }
        else
        {
            textRect = CGRect(x:bounds.origin.x, y: contentPadding-4.0,width: bounds.size.width-(self.rightView?.frame.size.width)!, height: bounds.size.height).insetBy(dx: 0, dy: 0);
        }
        
        return textRect
        
        //return bounds.insetBy(dx: 0, dy: contentPadding-4.0);
    }
    
    
    // Get Validation Type From TextField
    //    var validationTypeRef:ToDoTextFieldValidationType
    //
    //    if  simplete.isKindOfClass(ToDoTextField)
    //    {
    //    let textFieldRef:CustomTextField = textField as! ToDoTextField
    //    validationTypeRef = textFieldRef.validationType
    //    maxCharacterLimit = textFieldRef.maxCharacter
    //    if textFieldRef.maxCharacter != 0 {
    //    if textFieldRef.maxCharacter != -1 && !string.isEqual("") {
    //    if textFieldRef.text?.characters.count >= textFieldRef.maxCharacter
    //    {
    //    return false
    //    }
    //    }
    //    }
    //    }
    //
    
    //MARK:- Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        UIView.animate(withDuration: 0.25, animations:
            {
                self.imgBottomBorder.layer.backgroundColor = self.borderActiveColor.cgColor
                self.imgBottomBorder.frame = CGRect.init(x: 0.0, y: self.bounds.size.height-(self.bottomBorderWidth+1.0), width: self.bounds.size.width, height: self.bottomBorderWidth+1.0)
                
                self.lblPlaceholder.frame = CGRect.init(x: 0, y: (self.contentPadding/2), width: self.bounds.size.width, height: (self.bounds.size.height/4))
                self.lblPlaceholder.font = UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
                self.lblPlaceholder.textColor = self.tintColor
        })
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        UIView.animate(withDuration: 0.15, animations:
            {
                self.imgBottomBorder.layer.backgroundColor = self.borderInActiveColor.cgColor
                self.imgBottomBorder.frame = CGRect.init(x: 0.0, y: self.bounds.size.height-self.bottomBorderWidth, width: self.bounds.size.width, height: self.bottomBorderWidth)
                
                if (self.text?.characters.count ?? 0) > 0
                {
                    self.lblPlaceholder.frame = CGRect.init(x: 0, y: (self.contentPadding/2), width: self.bounds.size.width, height: (self.bounds.size.height/4))
                    self.lblPlaceholder.font = UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
                    self.lblPlaceholder.textColor = self.tintColor
                }
                else
                {
                    self.lblPlaceholder.frame = CGRect.init(x: 0, y: (self.contentPadding/2), width: self.bounds.size.width, height: (self.bounds.size.height))
                    self.lblPlaceholder.font = UIFont.appFont_Medium(fontSize: UIFont.systemFontSize)
                    self.lblPlaceholder.textColor = self.placeholderColor
                }
                
        })
        
        if self.selectedPickerViewObject != nil
        {
            self.sendValueChangeNotification(self.selectedPickerViewObject)
        }
        
    }
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    {
        
        if self.disablePasteOption == false
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    //MARK:- PickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.aryValueForPicker.count
    }
    
    //MARK:- Private Helper
    
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
            UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(ToDoTextField.cancelButtonClick))
            
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        )
        items.append(
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ToDoTextField.doneButtonClick))
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
        self.selectedPickerViewObject = nil
        self.resignFirstResponder()
    }
    private func addTextInputDoneButton() -> Void
    {
        //        if (self.inputAccessoryView?.viewWithTag(101) as? ToDoButton) != nil{
        //            let btnDone = ToDoButton(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: 40))
        //            btnDone.setTitle("Done", for: UIControlState.normal)
        //            btnDone.ToDoButtonType = ToDoButtonType.blueGradient
        //            btnDone.addTarget(self, action: #selector(ToDoTextField.btnDone_Clicked), for: UIControlEvents.touchUpInside)
        //            self.inputAccessoryView = btnDone
        //        }
        
    }
    
    func btnDone_Clicked() -> Void
    {
        self.resignFirstResponder()
    }
    // MARK:- Data Containers
    
    
    //MARK: Validation
    
    // var maxCharacter:NSInteger = -1
    
    var validationType:ToDoTextFieldValidationType = ToDoTextFieldValidationType.none{
        didSet{
            // Notification When Validation Type Change
            switch validationType
            {
            case ToDoTextFieldValidationType.none:
                self.keyboardType = UIKeyboardType.default
                
                break;
            case ToDoTextFieldValidationType.name:
                self.keyboardType = UIKeyboardType.alphabet
                
                break;
            case ToDoTextFieldValidationType.email:
                self.keyboardType = UIKeyboardType.emailAddress
                self.autocorrectionType = UITextAutocorrectionType.no
                break;
            case ToDoTextFieldValidationType.password:
                self.keyboardType = UIKeyboardType.default
                
                break;
                
            case ToDoTextFieldValidationType.numbers:
                self.keyboardType = UIKeyboardType.phonePad
                self.addDoneButtonAsInputAccessoryView()
                break;
            case ToDoTextFieldValidationType.currency:
                self.keyboardType = UIKeyboardType.decimalPad
                self.addDoneButtonAsInputAccessoryView()
                self.inputAccessoryView = btnDone
                break;
                
            case ToDoTextFieldValidationType.minMaxNumber:
                self.keyboardType = UIKeyboardType.decimalPad
                self.addDoneButtonAsInputAccessoryView()
                break;
            case ToDoTextFieldValidationType.characters:
                self.keyboardType = UIKeyboardType.alphabet
                
                break;
            case ToDoTextFieldValidationType.alphaNumeric:
                self.keyboardType = UIKeyboardType.namePhonePad
                
                break;
            case ToDoTextFieldValidationType.alphaNumeric_WithSpace:
                self.keyboardType = UIKeyboardType.namePhonePad
                
                break;
            case ToDoTextFieldValidationType.amountValidation:
                self.addDoneButtonAsInputAccessoryView()
                self.keyboardType = UIKeyboardType.decimalPad
                break
            case ToDoTextFieldValidationType.numericOnly:
                self.keyboardType = UIKeyboardType.numberPad
                self.addDoneButtonAsInputAccessoryView()
                break;
                
                
            default:
                break;
            }
        }
    }
    
    
    func addDoneButtonAsInputAccessoryView() -> Void {
        if btnDone == nil {
            btnDone = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
            btnDone!.setTitle("Done", for: UIControlState.normal)
            btnDone!.titleLabel?.font = UIFont.appFont_Regular(fontSize:18.0)
            btnDone!.backgroundColor = UIColor .appThemePurpleColor//.appGrayColor()
            btnDone!.setTitleColor(UIColor.white, for: UIControlState.normal)
            btnDone!.layer.borderColor = UIColor.white.cgColor
            btnDone!.layer.borderWidth = 1
            btnDone?.addTarget(self, action: #selector(btnDone_Clicked(_:)), for: UIControlEvents.touchUpInside)
        }
        self.inputAccessoryView = btnDone
    }
    
    
    @objc func btnDone_Clicked(_ sender:UIButton) -> Void
    {
        self.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let textFieldRef:ToDoTextField = textField as! ToDoTextField
        validationType = textFieldRef.validationType
        maxCharacterLimit = textFieldRef.maxCharacterLimit
        if textFieldRef.maxCharacterLimit != 0
        {
            if textFieldRef.maxCharacterLimit != -1 && !string.isEqual("") {
                if (textFieldRef.text?.characters.count)! >= textFieldRef.maxCharacterLimit
                {
                    return false
                }
            }
        }
        
        if let gmtTextFieldRef = textField as? ToDoTextField{
            if range.location == 0 && range.length == 0 && string.isEqual(" ")
            {
                return false
            }
            
            // Get Validation Type From TextField
            let validationTypeRef:ToDoTextFieldValidationType
            validationTypeRef = gmtTextFieldRef.validationType
            
            
            switch validationTypeRef  {
            case ToDoTextFieldValidationType.none:
                break
            case ToDoTextFieldValidationType.name:
                let aSet = CharacterSet(charactersIn:" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
                let compSepByCharInSet =  string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
                
            case ToDoTextFieldValidationType.email:
                let charactersToBlock = CharacterSet(charactersIn:"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@._").inverted
                let compSepByCharInSet =  string.components(separatedBy: charactersToBlock).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                let resultingString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
                
                if resultingString.length>0 {
                    let firstChar:unichar = resultingString .character(at: 0)
                    let letters = CharacterSet(charactersIn:"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@._")
                    if letters.contains(UnicodeScalar(firstChar)!){
                        // if letters .contains(firstChar){
                        // if letters .characterIsMember(firstChar) {
                        
                    }else{
                        return false;
                    }
                }
                
                if resultingString.length>1 {
                    let lastChar1:unichar = resultingString .character(at: resultingString.length - 1)
                    let lastChar2:unichar = resultingString .character(at: resultingString.length - 2)
                    
                    let letter1 = CharacterSet(charactersIn:"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
                    if !letter1.contains(UnicodeScalar(lastChar1)!) && !letter1.contains(UnicodeScalar(lastChar2)!){
                        //if !letter1 .characterIsMember(lastChar1) && !letter1 .characterIsMember(lastChar2) {
                        return false;
                    }
                }
                return string == numberFiltered
                
            case ToDoTextFieldValidationType.password:
                
                break
            case ToDoTextFieldValidationType.numbers:
                let resultingString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
                if resultingString.length > 0
                {
                    
                    //let firstChar = resultingString.character(at: 0)
                    
                    //allow only first latter as +
                    if let stringValue = resultingString as? String {
                        if stringValue.characters.count > 1 {
                            
                            let steChar = stringValue.characters.last
                            if steChar == "+"{
                                return false
                            }
                        }else{
                            if stringValue == "+" {
                                maxCharacterLimit = maxCharacterLimit+1
                            }
                        }
                    }
                    
                    resultingString.hasPrefix("0")
                    
                    //             //NOT ALLOW FIRST CHARACTER AS 0
                    //             let strChar = Character(UnicodeScalar(firstChar))
                    if resultingString.hasPrefix("0") == true {
                        return false
                    }
                }
                if resultingString.length > 1 {
                    let lastChar1: unichar = resultingString.character(at: resultingString.length - 1)
                    let lastChar2: unichar = resultingString.character(at: resultingString.length - 2)
                    let letter1: CharacterSet = CharacterSet(charactersIn: "0123456789")
                    
                    if !letter1.contains(UnicodeScalar(lastChar1)!) && !letter1.contains(UnicodeScalar(lastChar2)!) {
                        // The first character is a letter in some alphabet
                        return false
                    }
                }
                let aSet = CharacterSet(charactersIn:"0123456789+-").inverted
                let compSepByCharInSet =  string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                
                return string == numberFiltered
                
            case ToDoTextFieldValidationType.characters:
                let aSet = CharacterSet.letters.inverted
                let compSepByCharInSet = string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
            case ToDoTextFieldValidationType.alphaNumeric:
                let aSet = CharacterSet.alphanumerics.inverted
                let compSepByCharInSet = string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
            case ToDoTextFieldValidationType.alphaNumeric_WithSpace:
                let aSet = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ").inverted
                let compSepByCharInSet =  string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
            case ToDoTextFieldValidationType.characters_WithSpace:
                let aSet = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
                let compSepByCharInSet = string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
                
            case ToDoTextFieldValidationType.alphaNumeric_WithSpace_SpecialCharacter:
                let aSet = CharacterSet(charactersIn:" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_+|{}:>?/.,;'[]=-`'\\\"").inverted
                let compSepByCharInSet =  string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
                
            case ToDoTextFieldValidationType.amountValidation:
                
                
                if (textField.text?.contains("."))! && string == "."
                {
                    return false
                }
                
                let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
                
                let seperate:[String] = newString .components(separatedBy: ".")
                if seperate.count >= 2 {
                    let strSeperate : NSString =  NSString(format: "%@", seperate[1]) as NSString
                    
                    return !(strSeperate.length > 2)
                    
                }
                break;
                
            case ToDoTextFieldValidationType.currency:
                if (textField.text? .contains("0"))! && string == "0"
                {
                    return false
                }
                
                let aSet = CharacterSet(charactersIn:"1234567890.").inverted
                let compSepByCharInSet =  string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
            case ToDoTextFieldValidationType.numericOnly:
                
                let aSet = CharacterSet(charactersIn:"0123456789").inverted
                let compSepByCharInSet =  string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
                
            case ToDoTextFieldValidationType.minMaxNumber:
                
                let aSet = CharacterSet(charactersIn:"1234567890").inverted
                let compSepByCharInSet =  string.components(separatedBy: aSet).filter{!$0.isEmpty}
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
                
            }
            return true
        }else{
            return true
        }
    }
    
    func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        // Default
        return super.canPerformAction(action, withSender: sender)
    }
    
}
