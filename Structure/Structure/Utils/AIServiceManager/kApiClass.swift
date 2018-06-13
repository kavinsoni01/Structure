//
//  kApiClass.swift
//  DriverCity
//
//  Created by Kavin Soni on 28/05/17.
//  Copyright © 2017 Kavin Soni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftLoader
import SystemConfiguration


typealias ApiCallSuccessBlock = (Bool,NSDictionary) -> Void
typealias ApiCallFailureBlock = (Bool,NSError?,NSDictionary?) -> Void
typealias APIResponseBlock = ((_ response: NSDictionary?,_ isSuccess: Bool,_ error: Error?)->())

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


enum kAPIType {
    case login
    case getProfile
    case getInfbrand
    case sendrequest
    case pendingRequest
    case changeRequest
    case register
    case updateProfile
    case addimages
    case friendList
    case payment
    case showProfile
    case getUserProfile
    case deleteProfile
    case viewerdetail
    case addstatus
    case statusview

    case serchAPi
    case forgotpass
    case createjob
    case getjobsignle
    case changeJobStatus
    case addpointApi
    case hisotry
    case changePass

    
    
    func getEndPoint() -> String {
        switch self {
            
            //getprofile/123abc
            //newuser
            //base/1/Influencer
            //sendrequest/1/2/
            //pendingrequest/1
            //changerequest/3/Accept
        case .login:
            return "login"
        case .addstatus:
            return "addstatus"
        case .statusview:
            return "addview"
            
        case .hisotry:
            return "Hisotry"
        case .addimages:
            return "addimages"
        case .viewerdetail:
            return "viewerdetail"
            
        case .updateProfile:
            return "updateuser"
        case .deleteProfile:
            return "deleteac"
        case .addpointApi:
            return "addpoint"
        case .getProfile:
            return "getprofile"
        case .getInfbrand:
            return "GetInfbrand"
        case .sendrequest:
            return "sendrequest"
        case .pendingRequest:
            return "pendingrequest"
        case .changeRequest:
            return "changerequest"
//            chnagepass/insta_id/oldpass/newpass
        case .changePass:
            return "chnagepass"
        case .forgotpass:
            return "forgotpass"
        case .serchAPi:
            return "fillter"
        case .friendList:
            return "fredlist"
        case .payment:
            return "payment"
            
        case .showProfile:
            return "fredlistview"

        case .getUserProfile:
            return "fredlistview"
        case .register:
            return "newuser"
            
        case .createjob:
            return "updatejob/1"
        case .getjobsignle:
            return "getjobsignle"
        case .changeJobStatus:
            return "changeStatus"
            
        }
    }
    
    //    func getAPIKey() -> [String]
    //    {
    //        switch self {
    //
    //        case .login:
    //            return ["login"]
    //
    //        case .getOTPCode:
    //            return ["getOtp"]
    //            }
    //    }
}




class kApiClass: NSObject {
    
    //MARK:- Singleton
    static let shared = kApiClass()
    
    // MARK: - Static Variable
    
    //search no need to pass type
    
//    let baseURL = "http://webasist.in/instagram/Instaapi"
    let baseURL = "http://lilitapp.com/appadmin/Instaapitest"//"http://webasist.in/instagram/Instaapitest"//
    static var previousAPICallRequestParams:(kAPIType,[String:Any]?)?
    
    static var previousAPICallRequestMultiParams:(kAPIType,[[String:Any]]?)?
    
    
    func callAPI(WithType apiType:kAPIType, WithParams params:String, Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if isInternetAvailable() == true {
            
        }else{
            let alertController = UIAlertController(title: "LilitApp", message: "Please check your internet connection.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            return
        }

        
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
//            print("------  Parameters --------")
        print(params)
//            print("------  Parameters --------")
            
            
            let apiUrl:String = "\(self.baseURL)/\(apiType.getEndPoint())/\(params)"
            
//            print(apiUrl)

            SwiftLoader.show(title: "Loading...", animated: true)
            Alamofire.request(apiUrl, method: .get, parameters:[:], encoding: URLEncoding.default, headers:[:]).responseJSON
                { (response) in
            
                    switch response.result{
                        
                    case .success(let json):
                        
                        // You got Success :)
                        print(json)
                        //  print("Response Status Code :: \(response.response?.statusCode)")
                        //                        print(json as! NSDictionary)
                        let mainStatusCode:Int = (response.response?.statusCode)!
                        SwiftLoader.hide()

                        if let jsonResponse = json as? NSDictionary
                        {
                            
//                            print(mainStatusCode)
//                            print(jsonResponse)
                            
                            if jsonResponse.value(forKey: "Status") as! String == "true" ||  jsonResponse.value(forKey: "Status") as! String == "success"{
                                
//                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                
                                   // let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                    successBlock(jsonResponse, true, nil)
//                                }else{
//                                    
//                                    successBlock(nil, true, nil)
//                                    
//                                }
                            }
                            else
                            {
                                
                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                    let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                    
                                    successBlock(resultDict, false, nil)
                                }else{
                                    successBlock(nil, false, nil)
                                }
                                
                            }
                            
                        }else{
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                        
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        SwiftLoader.hide()
                        
//                        print("Response Status Code :: \(response.response?.statusCode)")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
//                        print(datastring ?? "Test")
                        failureBlock(nil,false,error)
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: "LilitApp", message: "Please check your internet connection", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
           
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow

           // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
           // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)

//            (alertController, animated: true, completion: nil)
        }
    }
    
    
    func callAPIPostWithoutLoader(WithType apiType:kAPIType, WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
//            print("------  Parameters --------")
            print(params)
//            print("------  Parameters --------")
            
            
            let apiUrl:String = "\(self.baseURL)/\(apiType.getEndPoint())"
            //SwiftLoader.show(animated: true)
            Alamofire.request(apiUrl, method: .post, parameters:params, encoding: URLEncoding.default, headers:[:]).responseJSON
                { (response) in
                    
                    switch response.result{
                        
                    case .success(let json):
                        
      
                        let mainStatusCode:Int = (response.response?.statusCode)!
                        
                        if let jsonResponse = json as? NSDictionary
                        {

                            
                            if jsonResponse.value(forKey: "Status") as! String == "success"{
                                
                                
                                if (jsonResponse.value(forKey: "data") != nil){
                                    
                                    
                                    successBlock(jsonResponse, true, nil)
                                    
                                    //                                    }
                                }else{
                                    successBlock(nil, true, nil)
                                    
                                }
                                
                         
                            }else{
                                
                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                    let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                    
                                    successBlock(resultDict, false, nil)
                                }else{
                                    successBlock(nil, false, nil)
                                }
                                
                            }
                            
                        }else{
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                        
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        SwiftLoader.hide()
                        
//                        print("Response Status Code :: \(response.response?.statusCode)")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
//                        print(datastring ?? "Test")
                        failureBlock(nil,false,error)
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: "LilitApp", message: "Please check your internet connection", preferredStyle: .alert)
            SwiftLoader.hide()
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    func callAPIPost(WithType apiType:kAPIType, WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
//            print("------  Parameters --------")
            print(params)
//            print("------  Parameters --------")
        SwiftLoader.show(title: "Loading...", animated: true)

            
        let apiUrl:String = "\(self.baseURL)/\(apiType.getEndPoint())"
            //SwiftLoader.show(animated: true)
            Alamofire.request(apiUrl, method: .post, parameters:params, encoding: URLEncoding.default, headers:[:]).responseJSON
                { (response) in
                    
                    switch response.result{

                    case .success(let json):
                       
                        SwiftLoader.hide()

                        
                        // You got Success :)
                        print(json)
                        //  print("Response Status Code :: \(response.response?.statusCode)")
                        //                        print(json as! NSDictionary)
                        let mainStatusCode:Int = (response.response?.statusCode)!
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            
//                            print(mainStatusCode)
//                            print(jsonResponse)
                            
                            if jsonResponse.value(forKey: "Status") as! String == "success"{
                                
                                SwiftLoader.hide()

                                if (jsonResponse.value(forKey: "data") != nil){
                                    
//                                    if let valueArr:NSArray = jsonResponse.value(forKey: "data") as? NSArray {
                                    
                                        successBlock(jsonResponse, true, nil)

//                                    }
                                }else{
                                    successBlock(nil, true, nil)

                                }
                                
//                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
//                                    
//                                    
//                                    let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
//                                }else{
//                                    
//                                    successBlock(nil, true, nil)
//                                    
//                                }
                            }else{
                                
                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                    let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                    
                                    successBlock(resultDict, false, nil)
                                }else{
                                    successBlock(nil, false, nil)
                                }
                                
                            }
                            
                        }else{
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                        
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        SwiftLoader.hide()
                        
//                        print("Response Status Code :: \(response.response?.statusCode)")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
//                        print(datastring ?? "Test")
//                        failureBlock(nil,false,error)
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: "LilitApp", message: "Please check your internet connection", preferredStyle: .alert)
            SwiftLoader.hide()
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    
    
    
    ////********************************************
    
    
    func callAPIWithoutLoader(WithType apiType:kAPIType, WithParams params:String, Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
//            print("------  Parameters --------")
            print(params)
//            print("------  Parameters --------")
            
            
            let apiUrl:String = "\(self.baseURL)/\(apiType.getEndPoint())/\(params)"
            
//            print(apiUrl)
            //SwiftLoader.show(animated: true)
            //            let apiUrl:String = "https://api.instagram.com/v1/users/self"///?access_token=Rgfe_rd=cr&ei=RFE9WdGhIfDy8Ae7pI2YBg&gws_rd=ssl
            Alamofire.request(apiUrl, method: .get, parameters:[:], encoding: URLEncoding.default, headers:[:]).responseJSON
                { (response) in
                    
                    switch response.result{
                        
                    case .success(let json):
                        
                        // You got Success :)
//                        print(json)
                        //  print("Response Status Code :: \(response.response?.statusCode)")
                        //                        print(json as! NSDictionary)
                        let mainStatusCode:Int = (response.response?.statusCode)!
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            
//                            print(mainStatusCode)
//                            print(jsonResponse)
                            
                            if jsonResponse.value(forKey: "Status") as! String == "true"{
                                
                                //                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                
                                // let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                successBlock(jsonResponse, true, nil)
                                //                                }else{
                                //
                                //                                    successBlock(nil, true, nil)
                                //
                                //                                }
                            }else{
                                
                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                    let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                    
                                    successBlock(resultDict, false, nil)
                                }else{
                                    successBlock(nil, false, nil)
                                }
                                
                            }
                            
                        }else{
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                        
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        SwiftLoader.hide()
                        
                        print("Response Status Code :: \(response.response?.statusCode)")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                        print(datastring ?? "Test")
                        failureBlock(nil,false,error)
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: "LilitApp", message: "Please check your internet connection", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    
    

    
    
    
    
    func callGetAPI(WithType apiType:kAPIType, WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
//            print("------  Parameters --------")
            print(params)
//            print("------  Parameters --------")
            
            
            let apiUrl:String = "\(self.baseURL)/\(apiType.getEndPoint())"
            //SwiftLoader.show(animated: true)
            SwiftLoader.show(title: "Loading...", animated: true)
            Alamofire.request(apiUrl, method: .get, parameters:params, encoding: URLEncoding.default, headers:[:]).responseJSON
                { (response) in
                    
                    switch response.result{
                        
                    case .success(let json):
                        SwiftLoader.hide()
                        
                        // You got Success :)
//                        print(json)
                        //  print("Response Status Code :: \(response.response?.statusCode)")
                        //                        print(json as! NSDictionary)
                        let mainStatusCode:Int = (response.response?.statusCode)!
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            
//                            print(mainStatusCode)
//                            print(jsonResponse)
                            
                            if  jsonResponse.value(forKey: "status") as! String == "true" {
                                
                                if ((jsonResponse.value(forKey: "data") as? NSArray) != nil){
                                    
                                    let resultDict = jsonResponse.value(forKey: "data") as? NSArray
                                    let dict:NSDictionary = ["data":resultDict!]
                                    successBlock(dict, true, nil)
                                }else{
                                    
                                    successBlock(nil, true, nil)
                                    
                                }
                            }else{
                                
                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                    let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                    
                                    successBlock(resultDict, false, nil)
                                }else{
                                    successBlock(nil, false, nil)
                                }
                                
                            }
                            
                        }else{
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                        
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        SwiftLoader.hide()
                        
                        print("Response Status Code :: \(response.response?.statusCode)")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                        print(datastring ?? "Test")
                        failureBlock(nil,false,error)
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: "LilitApp", message: "Please check your internet connection", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            SwiftLoader.hide()
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    

    
    //MARK: check internet connection
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
    
    
    func callAPIWithMultipleImage(WithType apiType:kAPIType, imageUpload:NSMutableArray,WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
            print("------  Parameters --------")
            print(params)
            print("------  Parameters --------")
            
            
        let apiUrl:String = "\(self.baseURL)/\(apiType.getEndPoint())"
            print(apiUrl)

            SwiftLoader.show(title: "Loading...", animated: true)

            Alamofire.upload (multipartFormData: { multipartFormData in
                
                
                if imageUpload.count > 0 {
                    
                    if let imageData = UIImageJPEGRepresentation(imageUpload[0] as! UIImage, 0.05) {
                        
                        multipartFormData.append(imageData, withName: "profile_pic[]",fileName: "profile_pic.jpg", mimeType: "image/jpg")
                        
                    }
                }
                
                if imageUpload.count > 1 {
                    
                    if let imageData2 = UIImageJPEGRepresentation(imageUpload[1] as! UIImage, 0.05) {
                        
                        multipartFormData.append(imageData2, withName: "profile_pic[]",fileName: "profile_pic.jpg", mimeType: "image/jpg")
                    }
                }
                
                if imageUpload.count > 2 {
                    
                    if let imageData2 = UIImageJPEGRepresentation(imageUpload[2] as! UIImage, 0.05) {
                        
                        multipartFormData.append(imageData2, withName: "profile_pic[]",fileName: "profile_pic.jpg", mimeType: "image/jpg")
                    }
                }
                
                for (key, value) in params {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            },to:apiUrl)
            { (result) in
                switch result {
                    
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        print(response.result.value ?? "")
                        
                        if let jsonResponse = response.result.value as? NSDictionary
                        {
                            
                            if  jsonResponse.value(forKey: "Status") as! String == "success" {
  
                                    successBlock(nil, true, nil)
                            }else{
                                SwiftLoader.hide()
                                
                                if ((jsonResponse.value(forKey: "data") as? NSDictionary) != nil){
                                    let resultDict = jsonResponse.value(forKey: "data") as? NSDictionary
                                    
                                    successBlock(resultDict, false, nil)
                                }else{
                                    successBlock(nil, false, nil)
                                }
                            }
                            
                        }else{
                            SwiftLoader.hide()
                            
                            let alertController = UIAlertController(title: "LilitApp", message: "Oops! Something went wrong, please try again.", preferredStyle: .alert)
                            
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            
                            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                            
                            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                            
                            print(response)
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                    }
                    
                case .failure(let encodingError):
                    SwiftLoader.hide()
                    
                    print(encodingError)
                }
            }
            
        }else{
            SwiftLoader.hide()
            
            let alertController = UIAlertController(title: "LilitApp", message: "Please check your internet connection", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            // (alertController, animated: true, completion: nil)
        }
    }

    
    
}


