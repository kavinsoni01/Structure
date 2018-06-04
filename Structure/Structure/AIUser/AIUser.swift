//
//  AIUser.swift
//  Smeety
//
//  Created by agile on 16/03/17.
//  Copyright © 2017 Viral Shah. All rights reserved.
//

import UIKit
import Foundation




class AIUser: NSObject,NSCoding {
    
    var selectLocalId:String = ""
    var smartLocalName:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var isPersonalInfoVerified = ""
    var mobileNumber = ""
    var isMobileVerified = ""
    var emailValue = ""
    var emailVerified = ""
    var memberGuid = ""
    
    var isUserActive = ""
    var isAccountVerified = ""
    
    var address = ""
    var classification = ""
    var currentinitiation = ""
    var dispatched = ""
    var employer = ""
    var paidthru = ""
    var profilepicURL = ""
    
    var deviceToken = ""
    
    var currentUser:AIUser!
    
    public func encode(with aCoder: NSCoder)
    {
        
        
        //aCoder.encode(self.user_Id , forKey: "user_id")
        aCoder.encode(self.selectLocalId, forKey: "selectLocalId")
        //
        aCoder.encode(self.smartLocalName, forKey: "smartLocalName")
        aCoder.encode(self.firstName, forKey: "firstName")
        aCoder.encode(self.lastName, forKey: "lastName")
        aCoder.encode(self.isPersonalInfoVerified, forKey: "isPersonalInfoVerified")
        
        aCoder.encode(self.mobileNumber, forKey: "mobileNumber")
        aCoder.encode(self.isMobileVerified, forKey: "isMobileVerified")
        aCoder.encode(self.emailValue, forKey: "emailValue")
        aCoder.encode(self.emailVerified, forKey: "emailVerified")
        aCoder.encode(self.memberGuid, forKey: "memberGuid")
        
        
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.classification, forKey: "classification")
        aCoder.encode(self.currentinitiation, forKey: "currentinitiation")
        aCoder.encode(self.dispatched, forKey: "dispatched")
        aCoder.encode(self.employer, forKey: "employer")
        aCoder.encode(self.paidthru, forKey: "paidthru")
        
        aCoder.encode(self.isUserActive, forKey: "isUserActive")
        aCoder.encode(self.isAccountVerified, forKey: "isAccountVerified")
        
        aCoder.encode(self.profilepicURL, forKey: "profilepicURL")
        
        aCoder.encode(self.deviceToken, forKey: "deviceToken")
        
        //
        
    }
    
    required init(coder aDecoder : NSCoder) {
        
        // self.user_Id  = (aDecoder.decodeObject(forKey: "user_id") as? String)!
        
        if (aDecoder.decodeObject(forKey: "selectLocalId") as? String) != nil
        {
            self.selectLocalId = aDecoder.decodeObject(forKey: "selectLocalId") as! String
        }
        if (aDecoder.decodeObject(forKey: "smartLocalName") as? String) != nil
        {
            self.smartLocalName = aDecoder.decodeObject(forKey: "smartLocalName") as! String
        }
        if (aDecoder.decodeObject(forKey: "firstName") as? String) != nil
        {
            
            self.firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        }
        
        if (aDecoder.decodeObject(forKey: "lastName") as? String) != nil
        {
            self.lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        }
        if (aDecoder.decodeObject(forKey: "isPersonalInfoVerified") as? String) != nil
        {
            self.isPersonalInfoVerified = aDecoder.decodeObject(forKey: "isPersonalInfoVerified") as! String
        }
        if (aDecoder.decodeObject(forKey: "mobileNumber") as? String) != nil
        {
            self.mobileNumber = aDecoder.decodeObject(forKey: "mobileNumber") as! String
        }
        if (aDecoder.decodeObject(forKey: "isMobileVerified") as? String) != nil
        {
            self.isMobileVerified = aDecoder.decodeObject(forKey: "isMobileVerified") as! String
        }
        if (aDecoder.decodeObject(forKey: "emailValue") as? String) != nil
        {
            self.emailValue = aDecoder.decodeObject(forKey: "emailValue") as! String
        }
        if (aDecoder.decodeObject(forKey: "emailVerified") as? String) != nil
        {
            self.emailVerified = aDecoder.decodeObject(forKey: "emailVerified") as! String
        }
        if (aDecoder.decodeObject(forKey: "memberGuid") as? String) != nil
        {
            self.memberGuid = aDecoder.decodeObject(forKey: "memberGuid") as! String
        }
        
        
        if (aDecoder.decodeObject(forKey: "address") as? String) != nil
        {
            self.address = aDecoder.decodeObject(forKey: "address") as! String
        }
        if (aDecoder.decodeObject(forKey: "classification") as? String) != nil
        {
            self.classification = aDecoder.decodeObject(forKey: "classification") as! String
        }
        if (aDecoder.decodeObject(forKey: "currentinitiation") as? String) != nil
        {
            self.currentinitiation = aDecoder.decodeObject(forKey: "currentinitiation") as! String
        }
        if (aDecoder.decodeObject(forKey: "dispatched") as? String) != nil
        {
            self.dispatched = aDecoder.decodeObject(forKey: "dispatched") as! String
        }
        if (aDecoder.decodeObject(forKey: "employer") as? String) != nil
        {
            self.employer = aDecoder.decodeObject(forKey: "employer") as! String
        }
        if (aDecoder.decodeObject(forKey: "paidthru") as? String) != nil
        {
            self.paidthru = aDecoder.decodeObject(forKey: "paidthru") as! String
        }
        if (aDecoder.decodeObject(forKey: "isUserActive") as? String) != nil
        {
            self.isUserActive = aDecoder.decodeObject(forKey: "isUserActive") as! String
        }
        if (aDecoder.decodeObject(forKey: "isAccountVerified") as? String) != nil
        {
            self.isAccountVerified = aDecoder.decodeObject(forKey: "isAccountVerified") as! String
        }
        if (aDecoder.decodeObject(forKey: "profilepicURL") as? String) != nil
        {
            self.profilepicURL = aDecoder.decodeObject(forKey: "profilepicURL") as! String
            
        }
        if (aDecoder.decodeObject(forKey: "deviceToken") as? String) != nil
        {
            self.deviceToken = aDecoder.decodeObject(forKey: "deviceToken") as! String
            
        }
        
        //
        
        
    }
    
    
    
    
    //MARK: - SHARED USER
    
    static let sharedManager : AIUser =
    {
        let instance = AIUser()
        
        //        if ((Static.instance?.isLoggedin()) == true) {
        //            Static.instance?.loadSavedUser()
        //        }
        //
        if ((instance.isLoggedin()) == true) {
            instance.loadSavedUser()
        }
        return instance
    }()
    
    
    override init() {
        
    }
    
    
    func  setvalueUserWithdetails(dict : NSDictionary ) -> Void {
        
        self.firstName = dict.object_forKeyWithValidationForClass_String(aKey: "firstname")
        
        self.lastName = dict.object_forKeyWithValidationForClass_String(aKey: "lastname")
        
        self.address = dict.object_forKeyWithValidationForClass_String(aKey: "address")
        
        self.emailValue = dict.object_forKeyWithValidationForClass_String(aKey: "email")
        
        self.mobileNumber = dict.object_forKeyWithValidationForClass_String(aKey: "mobilephone")
        
        self.employer = dict.object_forKeyWithValidationForClass_String(aKey: "employer")
        
        self.currentinitiation = dict.object_forKeyWithValidationForClass_String(aKey: "currentinitiation")
        
        self.classification = dict.object_forKeyWithValidationForClass_String(aKey: "classification")
        
        self.dispatched = dict.object_forKeyWithValidationForClass_String(aKey: "dispatched")
        
        self.paidthru = dict.object_forKeyWithValidationForClass_String(aKey: "paidthru")
        
        let imageName = dict.object_forKeyWithValidationForClass_String(aKey: "imagename")
        
        if imageName != ""
        {
            self.profilepicURL = URL_image_base + imageName
        }
        
        self.smartLocalName = dict.object_forKeyWithValidationForClass_String(aKey: "local_name")
        
        self.saveInDefaults()
        
    }
    
    
    
    //MARK: - CHECK LOGIN STATUS
    var isUserLoggedIn:Bool {
        get {
            return UserDefaults.standard.object(forKey: KEY_IS_USER_LOGGED_IN) != nil ? true : false
        }
    }
    
    func isLoggedin() -> Bool
    {
        return UserDefaults.standard.object(forKey: KEY_IS_USER_LOGGED_IN) != nil ? true : false
    }
    
    // MARK: - SAVE
    func saveInDefaults() -> Void{
        UserDefaults.standard.set(AIUser.sharedManager.selectLocalId, forKey: KEY_IS_USER_LOGGED_IN)
        let encodeData  = NSKeyedArchiver.archivedData(withRootObject: self)
        
        UserDefaults.standard.set(encodeData, forKey: AIUSER_CURRENTUSER_STORE)
        UserDefaults.standard.synchronize()
    }
    
    // MARK :- Load User
    
    func loadUser() -> AIUser?
    {
        let encodedObject : Data? = UserDefaults.standard.object(forKey: AIUSER_CURRENTUSER_STORE) as? Data
        
        if encodedObject != nil {
            
            let object : AIUser? = NSKeyedUnarchiver.unarchiveObject(with: encodedObject! as Data) as? AIUser
            return object
        }
        return nil
        
    }
    
    func loadSavedUser() -> Void
    {
        let objuser : AIUser? = self .loadUser()
        self.selectLocalId = (objuser?.selectLocalId)!
        
        if let memberId = objuser?.memberGuid
        {
            memberGuid = memberId
        }
        if let fName = objuser?.firstName
        {
            firstName = fName
        }
        if let lName = objuser?.lastName
        {
            lastName = lName
        }
        if let personalInfo = objuser?.isPersonalInfoVerified
        {
            isPersonalInfoVerified = personalInfo
        }
        if let mobile = objuser?.mobileNumber
        {
            mobileNumber = mobile
        }
        if let mobileVerify = objuser?.isMobileVerified
        {
            isMobileVerified = mobileVerify
        }
        
        if let value = objuser?.emailValue
        {
            emailValue = value
        }
        if let emailVerify = objuser?.emailVerified
        {
            emailVerified = emailVerify
        }
        
        if let add = objuser?.address
        {
            address = add
        }
        if let classificationValue = objuser?.classification
        {
            classification  = classificationValue
        }
        
        if let curntinitiation = objuser?.currentinitiation
        {
            currentinitiation = curntinitiation
        }
        if let dispatchedValue = objuser?.dispatched
        {
            dispatched = dispatchedValue
        }
        
        if let employerValue = objuser?.employer
        {
            employer = employerValue
        }
        if let paidThroughValue = objuser?.paidthru
        {
            paidthru = paidThroughValue
        }
        
        if let activeUser = objuser?.isUserActive
        {
            isUserActive = activeUser
        }
        if let verifiedUser = objuser?.isAccountVerified
        {
            isAccountVerified = verifiedUser
        }
        if let imgUrl = objuser?.profilepicURL
        {
            profilepicURL = imgUrl
        }
        if let deviceId = objuser?.deviceToken
        {
            deviceToken =  deviceId
        }
        if let localName = objuser?.smartLocalName
        {
            smartLocalName = localName
        }
    }
    
    // MARK: - LOGOUT
    
    func logout() -> Void
    {
        selectLocalId = ""
        smartLocalName = ""
        firstName = ""
        lastName = ""
        isPersonalInfoVerified = ""
        mobileNumber = ""
        isMobileVerified = ""
        emailValue = ""
        emailVerified = ""
        memberGuid = ""
        
        isUserActive = ""
        isAccountVerified = ""
        
        address = ""
        classification = ""
        currentinitiation = ""
        dispatched = ""
        employer = ""
        paidthru = ""
        profilepicURL = ""
        
        
        UserDefaults.standard.removeObject(forKey: KEY_IS_USER_LOGGED_IN)
        UserDefaults.standard.removeObject(forKey: AIUSER_CURRENTUSER_STORE)
        
        UserDefaults.standard.synchronize()
        AIUser.sharedManager.currentUser = nil
        // NEED TO RESET THE VALUES OF SHARED INSTANCE HERE
    }
    
}


