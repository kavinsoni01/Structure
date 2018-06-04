//
//  Extension_UIViewController.swift
//  Coll
//
//  Created by agilemac-30 on 05/03/18.
//  Copyright © 2018 agilemac-30. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBar(_ visible: Bool = true, titleColor color : UIColor = UIColor.white, barTintColor: UIColor) {
        self.navigationController?.navigationBar.barTintColor = barTintColor

        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: color]
    }
    
    func setNavigationClearColor(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
//    func setupNavigationBar(_ visible: Bool = false , color: UIColor = UIColor.statusBarBGColor, viewTitle: String)
//    {
//
//
//        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//
//        if let img = self.navigationController?.navigationBar.applyNavigationBarGradient(colours: [.gradientFirstColor, .gradientSecondColor], style: .leftToRight)
//        {
//            self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: img)
//        }
//        //self.navigationController?.navigationBar.mask?.applyGradient(colours: [UIColor.gradientFirstColor, UIColor.gradientSecondColor])
//
//
//
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//
//       // self.navigationController?.navigationBar.barTintColor = color
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
//                                                                        NSAttributedStringKey.font : UIFont.appFont_Bold(fontSize: 20)]
//        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
//     //   self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        self.navigationController?.setNavigationBarHidden(!visible, animated: false)
//
//        if color == UIColor.clear {
//            self.navigationController?.navigationBar.isTranslucent = true
//        }
//        else {
//            self.navigationController?.navigationBar.isTranslucent = false
//        }
//
//
//        let titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.width - 120, height: self.view.frame.height))
//        titleLabel.textColor = UIColor.white
//        titleLabel.text = viewTitle
//        titleLabel.textAlignment = .center
//        titleLabel.font = UIFont.appFont_Bold(fontSize: 20)
//        navigationItem.titleView = titleLabel
//
//
//
//        /*
//         if menuButton {
//         self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .plain, target: self, action: #selector(self.handleMenuTap(_:)))
//         }
//         */
//    }
    
    func setupNavigationBar(_ visible: Bool = false , color: UIColor = UIColor.statusBarBGColor, viewTitle: String, isHomeBar: Bool)
    {
        
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        if let img = self.navigationController?.navigationBar.applyNavigationBarGradient(colours: [.gradientFirstColor, .gradientSecondColor], style: .leftToRight)
        {
            self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: img)
        }
        //self.navigationController?.navigationBar.mask?.applyGradient(colours: [UIColor.gradientFirstColor, UIColor.gradientSecondColor])
        
        
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                                        NSAttributedStringKey.font : UIFont.appFont_Bold(fontSize: 20)]
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
        
        self.navigationController?.setNavigationBarHidden(!visible, animated: false)
        
        if color == UIColor.clear {
            self.navigationController?.navigationBar.isTranslucent = true
        }
        else {
            self.navigationController?.navigationBar.isTranslucent = false
        }
        
//        self.navigationController?.navigationBar.backItem?.title = " "
//        let barAppearace = UIBarButtonItem.appearance()
//        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        
        var titleWidth: CGFloat = 50
        
        if isHomeBar == true
        {
           //  titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.frame.width - 120, height: self.view.frame.height))
            
            titleWidth = 120
            
        }
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.frame.width - titleWidth, height: self.view.frame.height))
        //  let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.text = viewTitle
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.appFont_Bold(fontSize: 20)
        //   titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        /*
         if menuButton {
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .plain, target: self, action: #selector(self.handleMenuTap(_:)))
         }
         */
    }
    
    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    // get top most view controller helper method.
    static var topMostViewController : UIViewController {
        get {
            return UIViewController.topViewController(rootViewController: UIApplication.shared.keyWindow!.rootViewController!)
        }
    }
    
    fileprivate static func topViewController(rootViewController: UIViewController) -> UIViewController {
        guard rootViewController.presentedViewController != nil else {
            if rootViewController is UITabBarController {
                let tabbarVC = rootViewController as! UITabBarController
                let selectedViewController = tabbarVC.selectedViewController
                return UIViewController.topViewController(rootViewController: selectedViewController!)
            }
                
            else if rootViewController is UINavigationController {
                let navVC = rootViewController as! UINavigationController
                return UIViewController.topViewController(rootViewController: navVC.viewControllers.last!)
            }
            
            return rootViewController
        }
        
        return topViewController(rootViewController: rootViewController.presentedViewController!)
    }

}
