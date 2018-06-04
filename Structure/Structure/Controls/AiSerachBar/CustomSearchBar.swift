//
//  CustomSearchBar.swift
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Viral Shah. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {

    var preferredFont: UIFont!
    
    var preferredTextColor: UIColor!
    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        
        searchBarStyle = UISearchBarStyle.minimal
        isTranslucent = false
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        backgroundImage = UIImage()
    }
    
    override func draw(_ rect: CGRect) {
        
        if let index = indexOfSearchFieldInSubviews() {
            let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
            
            searchField.frame = CGRect(x: GET_PROPORTIONAL_WIDTH(width: 36), y: 8.0, width: frame.size.width - (GET_PROPORTIONAL_WIDTH(width: 36)*2), height: frame.size.height - 16.0)
            
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            searchField.backgroundColor = UIColor.white
            searchField.textAlignment = .left
            searchField.layer.borderWidth = 2
            searchField.layer.borderColor = UIColor.lightGray.cgColor
            searchField.layer.cornerRadius = 8
            searchField.layer.masksToBounds = true
           
            //change image of search icon
            
            let imageView  = UIImageView.init(image: UIImage(named: "search-1")?.withRenderingMode(.alwaysTemplate))
            imageView.tintColor = UIColor.darkGray
            
            searchField.leftView = nil
            searchField.rightView = imageView
            searchField.rightViewMode = .always            
        }
        
        super.draw(rect)
    }
    
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        
        return index
    }

}
