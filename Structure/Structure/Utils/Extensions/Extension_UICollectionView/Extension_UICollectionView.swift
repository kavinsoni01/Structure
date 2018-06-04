//
//  Extension_UICollectionView.swift
//  My Health Companion
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 agile-m-32. All rights reserved.
//

import UIKit


extension UICollectionView {
    public func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.appFont_Regular(fontSize: Constant.FontSize.fontSizeSixteen)], context: nil)
    }
}
