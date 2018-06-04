//
//  Extension_UIDevice.swift
//  CommonStructureiOS
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//

import UIKit

extension UIDevice
{
    static var isPortrait : Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
    static var isLandscape : Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
}
