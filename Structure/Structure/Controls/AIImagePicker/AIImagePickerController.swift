//
//  AIImagePickerController.swift
//  CarSumers
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2018 agile. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

enum AIImagePickerOption:Int{
    
    case
    camera,
    savedPhotosAlbum,
    photoLibrary,
    askForOption
    
    var name:String {
        switch self {
        case .photoLibrary:
            return "Photo Library"
        case .camera:
            return "Camera"
        case .savedPhotosAlbum:
            return "Saved Photos Album"
        case .askForOption:
            return "Ask for option"
        }
    }
}
struct ButtonTitle {
    static let btnOK = "OK"
    static let btnCancel = "Cancel"
    static let btnYes = "YES"
    static let btnNo = "NO"
    static let btnDismiss = "Dismiss"
    static let btnSetting = "Setting"
    static let btnSpam = "Report Spam"
    static let btnBlock = "Block User"
    static let btnLogin = "LOGIN"
    static let btnSignup = "SIGNUP"
    static let btnterms = "TERMS & CONDITIONS"
    static let btnforgotPassword = "Forgot Password?"
    static let btnSubmit = "SUBMIT"
}

// MARK: App Message
struct Message {
    static let msgDeviceNotCompatible = "Device is not compatible for the required operation."
    static let photoAcessPermissionDecined = "\(Constant.App.APP_NAME) does not have access to your photos or videos. To enable access, tap Settings and turn on Photos."
    static let msgPhotoPermssionDenied = "App needs permission to take photo from your library, go to settings and allow access"
    static let msgInternetConnectionMessage = "Please check your internet connection and try again!"
}

class AIImagePickerController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- PROPERTIES
    var blockCompletion:((_ isCancelled:Bool,_ pickedImage:UIImage?) -> Void)?
    var option:AIImagePickerOption = .photoLibrary
    var notifyCompleitonOnDismiss: Bool = false
    
    // MARK: - SHARED MANAGER
    static let shared = AIImagePickerController()
    
    
    //MARK:- SHOW IMAGE PICKER
    
    
    func showImagePickerFrom(vc: UIViewController = UIViewController.topMostViewController, withOption option:AIImagePickerOption, isAllowEdditting isEdit: Bool, notifyCompleitonOnDismiss isOnDismiss: Bool = false, andCompletion completion:@escaping ((_ isCancelled:Bool,_ pickedImage:UIImage?) -> Void)) {
        
        //Resign keyboard
        vc.view.endEditing(true)
        
        self.notifyCompleitonOnDismiss = isOnDismiss
        self.blockCompletion = completion
        if(option == .askForOption){
            let options:[String] = [AIImagePickerOption.camera.name, AIImagePickerOption.savedPhotosAlbum.name, AIImagePickerOption.photoLibrary.name, ButtonTitle.btnCancel]
            UIAlertController.displayActionsheetFromController(withTitle: "Choose Option", withmessage: nil, otherButtonTitles: options, completionHandler: { (index) in
                guard index != 3 else {
                    if(self.blockCompletion != nil){
                        self.blockCompletion!(false, nil)
                    }
                    return
                }
                
                self.option = AIImagePickerOption(rawValue: index)!
                self.checkPermissionAndProceedFurther(vc: vc, isAllowEdditting: isEdit)
            })
        } else {
            self.option = option
            self.checkPermissionAndProceedFurther(vc: vc, isAllowEdditting: isEdit)
        }
    }
    
    //MARK:- Private methods
    fileprivate func openSettingAlert(wirhMessage msg: String, viewController vc:UIViewController) {
        UIAlertController.displayAlertFromController(viewController: vc, withTitle: Constant.App.APP_NAME, withmessage: msg, otherButtonTitles: [ButtonTitle.btnCancel, ButtonTitle.btnSetting], completionHandler: { (index) in
            if index == 1 {
                if let url = URL(string: UIApplicationOpenSettingsURLString) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        })
    }
    
    private func checkPermissionAndProceedFurther(vc:UIViewController, isAllowEdditting isEdit: Bool){
        
        if self.option == AIImagePickerOption.camera {
            if !UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear) {
                UIAlertController.displayAlertFromController(viewController: vc, withTitle: Constant.App.APP_NAME, withmessage: Message.msgDeviceNotCompatible, otherButtonTitles: [ButtonTitle.btnOK], completionHandler: { (index) in
                    if(self.blockCompletion != nil){
                        self.blockCompletion!(false, nil)
                    }
                })
                return
            }
            
            self.sourceType = .camera
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            if cameraAuthorizationStatus == .notDetermined {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { // in half a second...
                    AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                        guard granted else {
                            
                            DispatchQueue.main.async(execute: {
                                //UI Related Function
                                self.dismiss(animated: true, completion: {
                                    self.openSettingAlert(wirhMessage: Message.msgPhotoPermssionDenied, viewController: vc)
                                })
                            });
                            return
                        }
                    }
                }
            }
            else if cameraAuthorizationStatus == .denied || cameraAuthorizationStatus == .restricted {
                self.openSettingAlert(wirhMessage: Message.msgPhotoPermssionDenied, viewController: vc)
                return
            }
        }
        else if (self.option == AIImagePickerOption.photoLibrary) || (self.option == AIImagePickerOption.savedPhotosAlbum) {
            self.sourceType = (self.option == AIImagePickerOption.photoLibrary) ? .photoLibrary : .savedPhotosAlbum
            
            let status = PHPhotoLibrary.authorizationStatus()
            if status == PHAuthorizationStatus.notDetermined {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // in half a second...
                    PHPhotoLibrary.requestAuthorization() { (status) -> Void in
                        if status == PHAuthorizationStatus.restricted || status == PHAuthorizationStatus.denied  {
                            self.dismiss(animated: true, completion: {
                                self.openSettingAlert(wirhMessage: Message.msgPhotoPermssionDenied, viewController: vc)
                            })
                        }
                    }
                }
            }
            else if status == PHAuthorizationStatus.restricted || status == PHAuthorizationStatus.denied {
                self.openSettingAlert(wirhMessage: Message.msgPhotoPermssionDenied, viewController: vc)
                return
            }
        }
        
        if UIImagePickerController.isSourceTypeAvailable(self.sourceType) {
            self.delegate = self
            self.allowsEditing = isEdit
            vc.present(self, animated: true, completion: nil)
        } else {
            UIAlertController.displayAlertFromController(viewController: vc, withTitle: Constant.App.APP_NAME, withmessage: Message.msgDeviceNotCompatible, otherButtonTitles: [ButtonTitle.btnOK], completionHandler: { (index) in
                if(self.blockCompletion != nil){
                    self.blockCompletion!(false, nil)
                }
            })
        }
    }
    
    //MARK:- DELEGATE
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imageKey = picker.allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage
        if self.notifyCompleitonOnDismiss {
            picker.dismiss(animated: true, completion: {
                if let pickedImage = info[imageKey] as? UIImage {
                    if(self.blockCompletion != nil){
                        self.blockCompletion!(true, pickedImage)
                    }
                }else{
                    if(self.blockCompletion != nil){
                        self.blockCompletion!(true, nil)
                    }
                }
            })
        }
        else {
            if let pickedImage = info[imageKey] as? UIImage {
                if(self.blockCompletion != nil){
                    self.blockCompletion!(true, pickedImage)
                }
            }else{
                if(self.blockCompletion != nil){
                    self.blockCompletion!(true, nil)
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true) {
            if(self.blockCompletion != nil){
                self.blockCompletion!(false, nil)
            }
        }
        /*
         if(self.blockCompletion != nil){
         self.blockCompletion!(false, nil)
         }
         
         dismiss(animated: true) {
         }
         */
    }
}
