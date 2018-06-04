//
//  AITableView.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//


import UIKit
import TPKeyboardAvoiding
import SDWebImage

class AITableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- PROPERTIES
    var viewPlaceHolder:AIViewPlaceHolder!
    var refreshControlTable:UIRefreshControl!
    
    
    var isPullToRefreshEnabled:Bool {
        set {
            if newValue == true {
                self.addSubview(refreshControlTable)
            }else{
                refreshControlTable.removeFromSuperview()
            }
        }
        get {
            return self.isPullToRefreshEnabled
        }
    }
    
    // FOR PAGINATION
    var recordLimit:Int = 1
    var recordTotal:Int = 0
    
    var blockRefreshHandler:(()->Void)?
    var blockWillDisplayCellForIndexPath:((_ indexPath:IndexPath)->Void)?
    
    
    //MARK:- INIT
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit(){
        
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        self.estimatedRowHeight = 100
        self.rowHeight = UITableViewAutomaticDimension
        
        self.showsVerticalScrollIndicator = false
        
        self.keyboardDismissMode = .interactive
        
        
        // PLACE HOLDER VIEW
        self.viewPlaceHolder = AIViewPlaceHolder()
        self.viewPlaceHolder.setupPlaceHolderViewWith(message: "NO DATA FOUND", andImageName: "")
        //self.viewPlaceHolder.bgColor = UIColor.backgroundColor
        self.addSubview(self.viewPlaceHolder)
        
        
        // PULL TO REFRESH
        refreshControlTable = UIRefreshControl()
        refreshControlTable.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: Constant.Colors.APP_COLOR_GREEN, NSAttributedStringKey.font:UIFont.appFont_Bold(fontSize: CGFloat(12).proportionalFontSize())])
        refreshControlTable.tintColor = Constant.Colors.APP_COLOR_GREEN
        refreshControlTable.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
    }
    
    @objc func refresh(sender:UIRefreshControl) {
        print("\n\n PULL TO REFRESH")
        
        if self.blockRefreshHandler != nil {
            self.blockRefreshHandler!()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            sender.endRefreshing()
        }
    }
    
    
    //MARK:- SHOW / HIDE LOADER
    func showLoader(){
        self.viewPlaceHolder.showLoader()
    }
    func hideLoader(){
        self.viewPlaceHolder.hideLoader()
    }
    
    
    //MARK:- DELEGATE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.blockWillDisplayCellForIndexPath != nil {
            self.blockWillDisplayCellForIndexPath!(indexPath)
        }
    }
    
    //MARK:- ANIMATE TABLE
    func animateTable() {
        self.reloadData()
        
        let cells = self.visibleCells
        let tableHeight: CGFloat = self.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            
            index += 1
        }
    }
}



class AITableView_TPKeyboard: TPKeyboardAvoidingTableView, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK:- PROPERTIES
    var viewPlaceHolder:AIViewPlaceHolder!
    
    
    //MARK:- INIT
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit(){
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        self.estimatedRowHeight = 100
        self.rowHeight = UITableViewAutomaticDimension
        
        self.showsVerticalScrollIndicator = false
        
        self.keyboardDismissMode = .interactive
        
        
        // PLACE HOLDER VIEW
        self.viewPlaceHolder = AIViewPlaceHolder()
        self.viewPlaceHolder.setupPlaceHolderViewWith(message: "NO DATA FOUND", andImageName: "")
        self.addSubview(self.viewPlaceHolder)
        
    }
    
    
    //MARK:- SHOW / HIDE LOADER
    func showLoader(){
        self.viewPlaceHolder.showLoader()
    }
    func hideLoader(){
        self.viewPlaceHolder.hideLoader()
    }
    
    
    //MARK:- DELEGATE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }

    //MARK:- ANIMATE TABLE
    
    func animateTable() {
        self.reloadData()
        let cells = self.visibleCells
        let tableHeight: CGFloat = self.bounds.size.height
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var index = 0
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            index += 1
        }
    }
}
