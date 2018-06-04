//
//  UtilFunctions.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation
import UIKit
import SVProgressHUD



//MARK: - AttributedText

/*
func attributedTexts(_ object : AnyObject , text1: String , text1FontSize : CGFloat, text2: String , text2FontSize : CGFloat) -> NSMutableAttributedString {
	
	let mainFont = object.font
	
	let font1 = mainFont!.withSize(CGFloat(text1FontSize).proportionalFontSize())
	//let attr1 = [NSFontAttributeName: font1]
    
    let attr1 = [NSAttributedStringKey.font: font1]
    
	
	let font2 = font1.withSize(CGFloat(text2FontSize).proportionalFontSize())
	//let attr2 = [NSFontAttributeName: font2]
	let attr2 = [NSAttributedStringKey.font: font2]
    
	let str = NSMutableAttributedString(string: text1, attributes: attr1);
	str.append(NSAttributedString(string: text2, attributes: attr2))
	
	return str
}
*/
let CUSTOM_ERROR_DOMAIN = "CUSTOM_ERROR_DOMAIN"
let CUSTOM_ERROR_USER_INFO_KEY = "CUSTOM_ERROR_USER_INFO_KEY"
let KEY_USER_CURRENT_VIEW_INDEX = "KEY_USER_CURRENT_VIEW_INDEX"

//MARK:- STRING FROM DICT
func getStringFromDictionary(dict:Any) -> String{
	var strJson = ""
	do {
		let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
		strJson = String(data: data, encoding: String.Encoding.utf8)!
	} catch let error as NSError {
		print("json error: \(error.localizedDescription)")
	}
	
	return strJson
}

//MARK: - GET JSON DICTIONARY

func getDictJson(_ dict : Any) -> [String : AnyObject] {
    var dictJson = [String : AnyObject]()
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
        if let dictFromJSON = decoded as? [String:AnyObject] {
            dictJson = dictFromJSON
        }
    } catch {
        print(error.localizedDescription)
    }
    
    return dictJson
}

func displayAlertWithMessage(_ message:String) -> Void {
    
    displayAlertWithTitle(Constant.App.APP_NAME, andMessage: message, buttons: ["Dismiss"], completion: nil)
}
func displayAlertWithTitle(_ title:String, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: Constant.App.APP_NAME, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count    {
        
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),NSAttributedStringKey.foregroundColor : UIColor.black]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    UIApplication.shared.delegate!.window!?.rootViewController!.present(alertController, animated: true, completion:nil)
}


// MARK: - ERROR HANDLING

func handleError(_ errorToHandle : NSError){
    
    if(errorToHandle.domain == CUSTOM_ERROR_DOMAIN)    {
        let dict = errorToHandle.userInfo as NSDictionary
        //displayAlertWithTitle(APP_NAME, andMessage:dict.object(forKey: CUSTOM_ERROR_USER_INFO_KEY) as! String, buttons: [constant.dismissAlertTitle], completion: nil)
        
        showAlertWithTitleFromVC(vc: (Constant.appDelegate.window?.rootViewController)!, andMessage: dict.object(forKey: CUSTOM_ERROR_USER_INFO_KEY) as! String)
        
    }
    else{
        
        if(errorToHandle.code == -999){
            return
        }
        
        showAlertWithTitleFromVC(vc: (Constant.appDelegate.window?.rootViewController)!, andMessage: errorToHandle.localizedDescription)
    }
}



//MARK:- ALERT

func showAlertWithTitleFromVC(vc:UIViewController, andMessage message:String)
{

	showAlertWithTitleFromVC(vc: vc, title:Constant.App.APP_NAME, andMessage: message, buttons: ["Dismiss"]) { (index) in
	}
}
func showAutoDismissAlert(vc:UIViewController,msg:String,time:Double, completion:((_ index:Int) -> Void)!) -> Void
{
    let alert = UIAlertController(title: Constant.App.APP_NAME, message: msg, preferredStyle: .alert)
    vc.present(alert, animated: true, completion: nil)
    
    // change to desired number of seconds (in this case 3 seconds)
    let when = DispatchTime.now() + time
    DispatchQueue.main.asyncAfter(deadline: when){
        // your code with delay
        alert.dismiss(animated: true, completion: nil)
        completion(0)
    }
}


func showAlertWithTitleFromVC(vc:UIViewController, title:String, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
	
	var newMessage = message
	if newMessage == "The Internet connection appears to be offline." {
		newMessage = INTERNET_MESSAGE
	}
	
	
	let alertController = UIAlertController(title: title, message: newMessage, preferredStyle: .alert)
	for index in 0..<buttons.count	{
		
		let action = UIAlertAction(title: buttons[index], style: .default, handler: {
			(alert: UIAlertAction!) in
			if(completion != nil){
				completion(index)
			}
		})
		
		alertController.addAction(action)
	}
	vc.present(alertController, animated: true, completion: nil)
}


//MARK:- ACTION SHEET
func showActionSheetWithTitleFromVC(vc:UIViewController, title:String, andMessage message:String, buttons:[String],canCancel:Bool, completion:((_ index:Int) -> Void)!) -> Void {

	let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
	

	
	for index in 0..<buttons.count	{
		
		let action = UIAlertAction(title: buttons[index], style: .default, handler: {
			(alert: UIAlertAction!) in
			if(completion != nil){
				completion(index)
			}
		})
		
		alertController.addAction(action)
	}
	
	if(canCancel){
		let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {
			(alert: UIAlertAction!) in
			if(completion != nil){
				completion(buttons.count)
			}
		})

		alertController.addAction(action)
	}
	
	vc.present(alertController, animated: true, completion: nil)
}

//MARK:- INTERNET CHECK
func IS_INTERNET_AVAILABLE() -> Bool{
	
	return AIReachabilityManager.shared.isInternetAvailableForAllNetworks()
}


let INTERNET_MESSAGE:String = "Please check your internet connection and try again."
func SHOW_INTERNET_ALERT(){
	showAlertWithTitleFromVC(vc: (Constant.appDelegate.window?.rootViewController)!, title:Constant.App.APP_NAME, andMessage: INTERNET_MESSAGE, buttons: ["Dismiss"]) { (index) in
	}
}



//MARK:- CUSTOM LOADER

func SHOW_CUSTOM_LOADER(){
	SHOW_CUSTOM_LOADER_WITH_TEXT(text: "")
}

func SHOW_CUSTOM_LOADER_WITH_TEXT(text:String){
	
	SVProgressHUD.setDefaultStyle(.custom)
	SVProgressHUD.setDefaultMaskType(.custom)
	SVProgressHUD.setDefaultAnimationType(.flat)
	
	SVProgressHUD.setBackgroundColor(UIColor.clear)
	SVProgressHUD.setRingRadius(30)
	SVProgressHUD.setRingThickness(5)
	SVProgressHUD.setForegroundColor(Constant.Colors.WHITE_COLOR)
	
	if(text.count > 0){
		SVProgressHUD.show(withStatus: text)
	}else{
		SVProgressHUD.show()
	}
}

func HIDE_CUSTOM_LOADER(){
	
//	AIDialogueLoader.shared.hide()
	
	SVProgressHUD.dismiss()
}


//MARK:- NETWORK ACTIVITY INDICATOR

func SHOW_NETWORK_ACTIVITY_INDICATOR(){
	UIApplication.shared.isNetworkActivityIndicatorVisible =  true
}

func HIDE_NETWORK_ACTIVITY_INDICATOR(){
	UIApplication.shared.isNetworkActivityIndicatorVisible =  false
}


//MARK:- USER DEFAULTS

func setUserDefaultsForAny(object: Any, with Key: String) {
    UserDefaults.standard.set(object, forKey: Key)
    UserDefaults.standard.synchronize()
}

func setUserDefaultsFor(object:AnyObject, with key:String) {
	UserDefaults.standard.set(object, forKey: key)
	UserDefaults.standard.synchronize()
}

func getUserDefaultsForKey(key:String) -> AnyObject? {
	return UserDefaults.standard.object(forKey: key) as AnyObject?
}

func removeUserDefaultsFor(key:String) {
	UserDefaults.standard.removeObject(forKey: key)
	UserDefaults.standard.synchronize()
}



//MARK:- PROPORTIONAL SIZE
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

func GET_PROPORTIONAL_WIDTH (width:CGFloat) -> CGFloat {
	return ((SCREEN_WIDTH * width)/750)
}
func GET_PROPORTIONAL_HEIGHT (height:CGFloat) -> CGFloat {
	return ((SCREEN_HEIGHT * height)/1334)
}




//MARK:- SYSTEM VERSION CHECK
func SYSTEM_VERSION_EQUAL_TO(version: String) -> Bool {
	return UIDevice.current.systemVersion.compare(version,
	                                                      options: NSString.CompareOptions.numeric) == ComparisonResult.orderedSame
}

func SYSTEM_VERSION_GREATER_THAN(version: String) -> Bool {
	return UIDevice.current.systemVersion.compare(version,
	                                                      options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending
}

func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
	return UIDevice.current.systemVersion.compare(version,
	                                                      options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending
}

func SYSTEM_VERSION_LESS_THAN(version: String) -> Bool {
	return UIDevice.current.systemVersion.compare(version,
	                                                      options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
}

func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: String) -> Bool {
	return UIDevice.current.systemVersion.compare(version,
	                                                      options: NSString.CompareOptions.numeric) != ComparisonResult.orderedDescending
}


//MARK: - ********** CONVERT DATE COMPONENTS TO DATE **********

func makeDate(year: Int, month: Int, day: Int) -> Date {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
    let components = DateComponents(year: year, month: month, day: day)
    return calendar.date(from: components)!
}
