//
//  ApiUrls.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation

//MARK:- URL SCHEME:  FACEBOOK, GOOGLE

func getFullUrl(_ urlEndPoint : String) -> String {
    return URL_BASE + urlEndPoint
}

//MARK: - ******************** Development Base URL ********************
//let URL_BASE                    =  "http://sandbox.nexusecare.com/MyHealthCompanionAPI"

//Sandbox New Version 2
let URL_BASE                    =  "https://ezunion.ca/app"
let URL_image_base = "https://ezedge.blob.core.windows.net/ezumemberapp/"

//Liver Server
//let URL_BASE                    =  "http://nexusecare.com/MyHealthCompanionAPI2"

//MARK:- WEB SERVICE

let URL_GetAllLocalList = getFullUrl("/locals")
let URL_sendPersonalInfo = getFullUrl("/setup/1")
let URL_sendmobileInfo = getFullUrl("/setup/2")
let URL_smsVerification = getFullUrl("/setup/3")
let URL_emailVerification = getFullUrl("/setup/4")
let URL_emailCodeVerification = getFullUrl("/setup/5")
let URL_updateProfile = getFullUrl("/member/address")
let URL_accountVerifyAPI = getFullUrl("/verify")
let URL_getUserProfileList = getFullUrl("/member/profile")
let URL_uploadPhoto = getFullUrl("/member/image")
let URL_getNotificationList = getFullUrl("/member/notices")
let URL_getCertificateList = getFullUrl("/member/certs")
let URL_getResourceList = getFullUrl("/member/resources")
let URL_getDuesHistory = getFullUrl("/member/dues")
let URL_addTestProfile = getFullUrl("/member/add/testing")








