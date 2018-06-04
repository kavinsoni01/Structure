//
//  UIAlertControllerExtension.swift
//  B4_RealEstate
//
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    
    static func displayNoInternetAlert() {
        UIAlertController.displayAlertFromController(withTitle: Constant.App.APP_NAME, withmessage: Message.msgInternetConnectionMessage, otherButtonTitles: [ButtonTitle.btnOK], completionHandler: nil)
    }
    
    static func displayAlertWithMessage(title: String = Constant.App.APP_NAME ,message strMessage: String) {
        UIAlertController.displayAlertFromController(withTitle: title, withmessage: strMessage, otherButtonTitles: ["Ok"], completionHandler: nil)
    }
    
    //MARK:- displayAlertFromController
    static func displayAlertFromController(viewController: UIViewController = UIViewController.topMostViewController,
                                           withTitle title:String?,
                                           withmessage message:String?,
                                           otherButtonTitles otherTitles:[String]?,
                                           isNeedToHighLightCancelButton isHighLighted: Bool = true,
                                           completionHandler : ((_ index : NSInteger) -> Void)?) {
        
        if viewController.presentedViewController is UIAlertController {
            let lastalert = viewController.presentedViewController as! UIAlertController
            lastalert.dismiss(animated: false, completion: nil)
        }
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        //customize Title
        if ((title != nil) && (title?.count != 0)) {
            let attributeTitle = NSMutableAttributedString(string: title!, attributes: [NSAttributedStringKey.font : UIFont.appFont_Regular(fontSize: 18.0)])
            alert.setValue(attributeTitle, forKey: "attributedTitle")
        }
        
        //customize Message
        if ((message != nil) && (message?.count != 0)) {
            let attributeTitle = NSMutableAttributedString(string: message!, attributes: [NSAttributedStringKey.font : UIFont.appFont_Regular(fontSize: 13.0)])
            alert.setValue(attributeTitle, forKey: "attributedMessage")
        }
        
        for indexpos in (0...(otherTitles?.count)! - 1) {
            let  strbtntitle = otherTitles![indexpos] as String
            var style: UIAlertActionStyle = .default
            if (strbtntitle as NSString).isEqual(to: "Cancel") && isHighLighted {
                style = .cancel
            }
            else if (strbtntitle as NSString).isEqual(to: "Delete") && isHighLighted {
                style = .destructive
            }
            
            let action : UIAlertAction = UIAlertAction(title: strbtntitle as String, style: style, handler: { (action1 : UIAlertAction) in
                if (completionHandler != nil) {
                    completionHandler!(indexpos)
                }
            })
            alert.addAction(action)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func textfieldValueChange(_ txtFled: UITextField) {
        for action in self.actions {
            if let title = action.title, title == ButtonTitle.btnOK {
                action.isEnabled = txtFled.text!.count > 0
            }
        }
    }
    
    static func displayAlertFromControllerWithTextField(viewController: UIViewController = UIViewController.topMostViewController,
                                           withTitle title:String?,
                                           withmessage message:String?,
                                           otherButtonTitles otherTitles:[String]?,
                                           completionHandler : ((_ index : NSInteger,_ text: String) -> Void)?) {
        
        if viewController.presentedViewController is UIAlertController {
            let lastalert = viewController.presentedViewController as! UIAlertController
            lastalert.dismiss(animated: false, completion: nil)
        }
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        //customize Title
        if ((title != nil) && (title?.count != 0)) {
            let attributeTitle = NSMutableAttributedString(string: title!, attributes: [NSAttributedStringKey.font : UIFont.appFont_Bold(fontSize: 18.0)])
            alert.setValue(attributeTitle, forKey: "attributedTitle")
        }
        
        //customize Message
        if ((message != nil) && (message?.count != 0)) {
            let attributeTitle = NSMutableAttributedString(string: message!, attributes: [NSAttributedStringKey.font : UIFont.appFont_Regular(fontSize: 14.0)])
            alert.setValue(attributeTitle, forKey: "attributedMessage")
        }
        
        alert.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Reason"
            textField.addTarget(alert, action: #selector(alert.textfieldValueChange(_:)), for: UIControlEvents.editingChanged)
        })
        
        for indexpos in (0...(otherTitles?.count)! - 1) {
            let  strbtntitle = otherTitles![indexpos] as String
            var style: UIAlertActionStyle = .default
            if (strbtntitle as NSString).isEqual(to: "Cancel") {
                style = .cancel
            }
            else if (strbtntitle as NSString).isEqual(to: "Delete") {
                style = .destructive
            }
            
            let action : UIAlertAction = UIAlertAction(title: strbtntitle as String, style: style, handler: { (action1 : UIAlertAction) in
                
                if (completionHandler != nil) {
                    if indexpos == 1 {
                        if let textFields = alert.textFields, let textField = textFields.first {
                            completionHandler!(indexpos, textField.text!)
                        }
                        else {
                            completionHandler!(indexpos, "")
                        }
                    }
                    else {
                        completionHandler!(indexpos, "")
                    }
                    
                    
                }
            })
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            if let title = action.title, title == ButtonTitle.btnOK {
                action.isEnabled = false
                action.setValue(UIColor.yellow, forKey: "titleTextColor")
            }
            
            alert.addAction(action)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- displayActionsheetFromController
    static func displayActionsheetFromController(viewController : UIViewController = UIViewController.topMostViewController,
                                                 withTitle title:String?,
                                                 withmessage message:String?,
                                                 otherButtonTitles otherTitles:[String]?,
                                                 completionHandler : ((_ index : NSInteger) -> Void)?) {
        
        if viewController.presentedViewController is UIAlertController {
            let lastalert = viewController.presentedViewController as! UIAlertController
            lastalert.dismiss(animated: false, completion: nil)
        }
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        
        //customize Title
        if ((title != nil) && (title?.count != 0)) {
            let attributeTitle = NSMutableAttributedString(string: title!, attributes: [NSAttributedStringKey.font : UIFont.appFont_Regular(fontSize: 12.0)])
            alert.setValue(attributeTitle, forKey: "attributedTitle")
        }
        
        //customize Message
        if ((message != nil) && (message?.count != 0)) {
            let attributeTitle = NSMutableAttributedString(string: message!, attributes: [NSAttributedStringKey.font : UIFont.appFont_Regular(fontSize: 18.0)])
            alert.setValue(attributeTitle, forKey: "attributedMessage")
        }
        
        for indexpos in (0...(otherTitles?.count)! - 1) {
            let  strbtntitle = otherTitles![indexpos] as String
            var style: UIAlertActionStyle = .default
            if (strbtntitle as NSString).isEqual(to: "Cancel") {
                style = .cancel
            }
            else if (strbtntitle as NSString).isEqual(to: "Delete") {
                style = .destructive
            }
            
            let action : UIAlertAction = UIAlertAction(title: strbtntitle as String, style: style, handler: { (action1 : UIAlertAction) in
                if (completionHandler != nil) {
                    completionHandler!(indexpos)
                }
            })
            alert.addAction(action)
        }
        viewController.present(alert, animated: true, completion: nil)
        
    }
}
