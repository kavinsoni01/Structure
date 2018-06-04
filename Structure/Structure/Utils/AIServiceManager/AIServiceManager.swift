//
//  AIServiceManager.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 22/06/17.
//  Copyright © 2017 Agile. All rights reserved.
//


import UIKit
import Alamofire

let ServiceManager = AIServiceManager.shared


class AIServiceManager: NSObject {
	
	var request: Alamofire.Request? {
		didSet {
			oldValue?.cancel()
		}
	}
	
	// MARK: - SHARED MANAGER
	static let shared = AIServiceManager()
    func callPostApi(_ url : String, params : [String : Any]?, completionHandler :@escaping (DataResponse<Any>) -> ())
    {
        if IS_INTERNET_AVAILABLE()
        {
            
            DispatchQueue.main.async {
                
                SHOW_CUSTOM_LOADER()
            }
            
            
            /*
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
             */
           // Alamofire.request(url, method: .post, parameters: params,encoding: .JSON,headers: headers).responseJSON(completionHandler: completionHandler)
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: completionHandler)
            
           // Alamofire.request(.POST, url, parameters: params, encoding: .JSON)
               // .responseJSON(completionHandler: completionHandler)
            
            
            
        }
        else
        {
            SHOW_INTERNET_ALERT()
        }
        
    }
    
    func callGetApi(_ url : String, params : [String : Any]?, completionHandler :@escaping (DataResponse<Any>) -> ())
    {
        if IS_INTERNET_AVAILABLE()
        {
            
            DispatchQueue.main.async {
                
                SHOW_CUSTOM_LOADER()
            }
            Alamofire.request(url, method: .get, parameters: params, headers: [:]).responseJSON(completionHandler: completionHandler)
        }
        else
        {
            SHOW_INTERNET_ALERT()
        }
        
    }
	
	
    func apiPostParameters(_ parameters : [String : Any],apiName:String, completetion : @escaping (_ isSuccess:Bool, _ message:String , _ statusCode : Int,_ getData:NSDictionary) -> Void)
    {
        print("API Parameters JSON String : ", getStringFromDictionary(dict: parameters))
        
        self.callPostApi(apiName, params: parameters, completionHandler: { (response) -> Void in
            
            
            
            switch response.result
            {
            case.success(let Json):
                
                if apiName.contains(URL_getNotificationList) ||  apiName.contains(URL_getDuesHistory) || apiName.contains(URL_getCertificateList) || apiName.contains(URL_getResourceList) || apiName.contains(URL_getUserProfileList)
                {
                    
                }
                else
                {
                    HIDE_CUSTOM_LOADER()
                }
                let dictJson = Json as! NSDictionary
                
                print(dictJson)
                
                completetion(true,"",200,dictJson)
                
            case.failure(let error):
                HIDE_CUSTOM_LOADER()
                print(error.localizedDescription)
                if error.localizedDescription == "The network connection was lost." || error.localizedDescription == "The request timed out."
                {
                    
                    completetion(false,"",1005,[:])
                }
                else
                {
                    HIDE_CUSTOM_LOADER()
                    handleError(error as NSError)
                    completetion(false,"",0,[:])
                }
                
                displayAlertWithMessage(error.localizedDescription)
               // showAlertWithTitleFromVC(vc: <#T##UIViewController#>, andMessage: <#T##String#>)
               
                
            }
        })
    }

	//MARK:- GET MISSION
    func apiGetParameters(_ parameters : [String : Any],apiName:String, completetion : @escaping (_ isSuccess:Bool, _ message:String , _ statusCode : Int,_ getData:[NSDictionary]) -> Void)
    {
        
        
        self.callGetApi(apiName, params: parameters, completionHandler: { (response) -> Void in
            
            
            switch response.result
            {
            case.success(let Json):
                HIDE_CUSTOM_LOADER()
                let dictJson = Json as! [NSDictionary]
                
                print(dictJson)
                
                completetion(true,"",200,dictJson)
                
            case.failure(let error):
                HIDE_CUSTOM_LOADER()
                print(error.localizedDescription)
                if error.localizedDescription == "The network connection was lost." || error.localizedDescription == "The request timed out."
                {
                    
                    completetion(false,"",1005,[[:]])
                }
                else
                {
                    HIDE_CUSTOM_LOADER()
                    handleError(error as NSError)
                    completetion(false,"",0,[[:]])
                }
                
                displayAlertWithMessage(error.localizedDescription)
                // showAlertWithTitleFromVC(vc: <#T##UIViewController#>, andMessage: <#T##String#>)
                
                
            }
        })
    }
	
	
	//MARK:- ******** COMMON POST METHOD *********
	
	private func callGETApiWithNetCheck(url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
		callGET_POSTApiWithNetCheck(isGet: true, url: url, headersRequired: headersRequired, params: params, completionHandler: completionHandler)
	}

	private func callPOSTApiWithNetCheck(url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
		callGET_POSTApiWithNetCheck(isGet: false, url: url, headersRequired: headersRequired, params: params, completionHandler: completionHandler)
	}
	
	private func callGET_POSTApiWithNetCheck(isGet:Bool, url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
		
		if(!IS_INTERNET_AVAILABLE()){
			SHOW_INTERNET_ALERT()
			completionHandler(nil,false)
			return
		}
		let headers:[String:String] = [:]
		
		
		
		Alamofire.request(url, method: isGet ? .get : .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
			
			switch response.result{
			case .success(let JSON):
				let dictJson = JSON as! NSDictionary
				let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
				let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
				if(status == 103){
					self.handleInvalidAccessToken()
				}else{
					completionHandler(response,true)
				}
			case .failure( _):
				completionHandler(response,true)
			}
		}
	}
	
//	private func callGET_POSTApiWithNetCheck(isGet:Bool, url : String, headersRequired : Bool, params : [String : Any]?, encoding:String, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
//		
//		if(!IS_INTERNET_AVAILABLE()){
//			SHOW_INTERNET_ALERT()
//			completionHandler(nil,false)
//			return
//		}
//		var headers:[String:String] = [:]
//		if headersRequired {
//			headers["user_id"] = SharedUser.idUser
//			headers["device_id"] = SharedUser.deviceId
//			headers["access_token"] = SharedUser.accessToken
//		}
//		print("\n\n\n\n\nURL : \(url) \nPARAM : \(getStringFromDictionary(dict: params!)) \nHEADERS : \(getStringFromDictionary(dict: headers))")
//		
//		let parameterEncoding = encoding == "" ? URLEncoding.default : URLEncoding.queryString
//		
//		Alamofire.request(url, method: isGet ? .get : .post, parameters: params, encoding: parameterEncoding, headers: headers).responseJSON { (response) in
//
//			switch response.result{
//			case .success(let JSON):
//				let dictJson = JSON as! NSDictionary
//				let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
//				let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
//				if(status == 103){
//					self.handleInvalidAccessToken()
//				}else{
//					completionHandler(response,true)
//				}
//			case .failure( _):
//				completionHandler(response,true)
//			}
//		}
//	}
	
	
	private func handleInvalidAccessToken(){
	
		HIDE_CUSTOM_LOADER()
		HIDE_NETWORK_ACTIVITY_INDICATOR()
		
		showAlertWithTitleFromVC(vc: (Constant.appDelegate.window?.rootViewController)!, title:Constant.App.APP_NAME, andMessage: "Session expired ! Just login again", buttons: ["OK"]) { (index) in
            
            /*
			SharedUser.logOutLocally(with: { (isSuccess, message) in
				//Constant.appDelegate.changeRootToLoginVC()
			})
             */
		}
	}
	//MARK:- ******** COMMON MULTIPART METHOD *********
	
	
    func uploadWithAlamofire(_ parameters : [String : Any]? ,apiName:String,newProfileImages:UIImage,isAccessTokenRequired:Bool, completetion : @escaping (_ isSuccess:Bool, _ message:String , _ statusCode : Int ,_ getData : NSDictionary) -> Void)
    {
        
        print(apiName as Any)
        print(parameters as Any)
        
        if IS_INTERNET_AVAILABLE()
        {
            SHOW_CUSTOM_LOADER()
            
            
            
            //var  headers: HTTPHeaders?
            
            if(!isAccessTokenRequired)
            {
               
            }
            else
            {
                
            }
            
            let URL = try! URLRequest(url: apiName, method: .post, headers: [:])
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                
                
               
                    
                    let getImage = newProfileImages
                multipartFormData.append(UIImagePNGRepresentation(getImage)!, withName: "file", fileName: "picture.png", mimeType: "image/png")
                
                
                
                
                
                /*
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    
                }
                 */
                
                if let params = parameters
                {
                    for eachKey in params.keys
                    {
                        if let value = params[eachKey] as? String
                        {
                           
                           print(value)
                            multipartFormData.append(value.data(using: .utf8)!, withName: eachKey)
                        }
                    }
                }
                
            }, with: URL, encodingCompletion: {
                encodingResult in
                switch encodingResult
                {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        //let percentage:Int = Int(Progress.fractionCompleted*100)
                        //let strPercentageComplete = String(format: "Uploading %d %%", percentage)
                        print(Progress.fractionCompleted*10)
                        
                    })
                    
                    
                    
                    upload.responseJSON { response in
                        print("Update My profile response \(response)")
                        
                        HIDE_CUSTOM_LOADER()
                        
                        if (response.result.value as? NSDictionary) != nil
                        {
                            
                            
                            
                        }
                        else
                        {
                            
                            completetion(false,"",1005,[:])
                        }
                        
                    }
                case .failure(let encodingError):
                    // hide progressbas here
                    
                    HIDE_CUSTOM_LOADER()
                    
                    print(encodingError.localizedDescription)
                    
                    if encodingError.localizedDescription == "The network connection was lost." || encodingError.localizedDescription == "The request timed out."
                    {
                        
                        completetion(false,"",1005,[:])
                    }
                    else
                    {
                        handleError(encodingError as NSError)
                        completetion(false,"",0,[:])
                    }
                    
                }
            })
            
        }
        else
        {
            SHOW_INTERNET_ALERT()
        }
        
    }
    
	func callUPLOADApiWithNetCheck(url : String, image:UIImage?, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
		
		if(!IS_INTERNET_AVAILABLE()){
			SHOW_INTERNET_ALERT()
			completionHandler(nil,false)
			return
		}
		
		var headers:[String:String] = [:]
		if headersRequired {
			//headers["user_id"] = SharedUser.idUser
			//headers["device_id"] = SharedUser.deviceId
			//headers["access_token"] = SharedUser.accessToken
		}

		print("\n\n\n\n\nURL : \(url) \nPARAM : \(getStringFromDictionary(dict: params!)) \nHEADERS : \(getStringFromDictionary(dict: headers))")

		//SHOW_NETWORK_ACTIVITY_INDICATOR()
        
        SHOW_CUSTOM_LOADER()

		Alamofire.upload(multipartFormData:{ multipartFormData in

            
            if let image = image {
                if let imageData = UIImageJPEGRepresentation(image, 1) {
                    multipartFormData.append(imageData, withName: "UploadedImage", fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }
            
            /*
            let getImage = image
            multipartFormData.append(UIImagePNGRepresentation(getImage!)!, withName: "file", fileName: "picture.png", mimeType: "image/png")
*/
			if let params = params {
				for eachKey in params.keys
                {
					if let value = params[eachKey] as? String
                    {
						multipartFormData.append(value.data(using: .utf8)!, withName: eachKey)
					}
				}
			}
			
			
		},
		 usingThreshold:UInt64.init(),
		 to:url,
		 method:.post,
		 headers:headers,
		 encodingCompletion: { encodingResult in
			
			//HIDE_NETWORK_ACTIVITY_INDICATOR()
            

			switch encodingResult {
			case .success(let upload, _, _):
				upload.responseJSON { response in
                    HIDE_CUSTOM_LOADER()
					completionHandler(response,true)
				}
			case .failure(let encodingError):
                HIDE_CUSTOM_LOADER()
				print("ERR: UPLOAD: \(encodingError.localizedDescription)")
				completionHandler(nil,true)
			}
		})
	}

	func cancellAllPendingRequests(){
		
		let sessionManager = Alamofire.SessionManager.default;
		
		sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in

			print("\n\n")
			
			dataTasks.forEach({ (task) in
                print("1 id : \(task.taskIdentifier) __ \(String(describing: task.currentRequest)) __ \(String(describing: task.originalRequest))")
			})

			dataTasks.forEach({ (task) in
                print("2 id : \(task.taskIdentifier) __ \(String(describing: task.currentRequest)) __ \(String(describing: task.originalRequest))")
			})

			dataTasks.forEach({ (task) in
                print("3 id : \(task.taskIdentifier) __ \(String(describing: task.currentRequest)) __ \(String(describing: task.originalRequest))")
			})

			
			dataTasks.forEach { $0.cancel() }
			uploadTasks.forEach { $0.cancel() }
			downloadTasks.forEach { $0.cancel() }
		}
	}
	
}
