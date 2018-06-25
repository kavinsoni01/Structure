//
//  StatusModel.swift
//  Collabor
//
//  Created by Kavin Soni on 29/12/17.
//  Copyright © 2017 Kavin Soni. All rights reserved.
//

import UIKit

class StatusModel: NSObject {
    
    
    var statusid:String = ""
    var statusimg:String = ""
    var userId:String = ""
    var viewer:String = ""
    var createdate:String = ""
    var viewercount:String = ""
    var link:String = ""
    var viewerdetail:[NSDictionary] = []
    
    
    override init() {
        super.init()
    }
    
    init(withContent content:NSDictionary) {
        super.init()
       // print(content)
        if let value = content.value(forKey: "statusid") as? String{
            self.statusid = value
        }
        if let value = content.value(forKey: "statusimg") as? String{
            self.statusimg = value
        }
        if let value = content.value(forKey: "link") as? String{
            self.link = value
        }
        
        if let value = content.value(forKey: "user_id") as? String{
            self.userId = value
        }
        if let value = content.value(forKey: "viewer") as? String{
            self.viewer = value
        }
        if let value = content.value(forKey: "viewerdetail") as? [NSDictionary]{
            self.viewerdetail = value
        }
        
        if let value = content.value(forKey: "createdate") as? String{
            self.createdate = value
        }
        if let value = content.value(forKey: "viewercount") as? String{
            self.viewercount = value
        }

    }
}
