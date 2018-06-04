//
//  UIIMage.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIImage {
    func trim(trimRect :CGRect) -> UIImage {
        if CGRect(origin: CGPoint.zero, size: self.size).contains(trimRect) {
            if let imageRef = self.cgImage?.cropping(to: trimRect) {
                return UIImage(cgImage: imageRef)
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(trimRect.size, true, self.scale)
        self.draw(in: CGRect(x: -trimRect.minX, y: -trimRect.minY, width: self.size.width, height: self.size.height))
        let trimmedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let image = trimmedImage else { return self }
        
        return image
    }
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage
    {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    class func convertGradientToImage(colors: [UIColor], frame: CGRect) -> UIImage {
        
        // start with a CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        // add colors as CGCologRef to a new array and calculate the distances
        var colorsRef : [CGColor] = []
        var locations : [NSNumber] = []
        
        for i in 0 ... colors.count-1
        {
            colorsRef.append(colors[i].cgColor as CGColor)
            //locations.append(NSNumber(Float(i)/NSNumber(Float(colors.count))))
        }
        
        gradientLayer.colors = colorsRef
        gradientLayer.locations = locations
        
        // now build a UIImage from the gradient
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // return the gradient image
        return gradientImage!
    }
    
}
