//
//  AIDialogueSnackAlert.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 3/30/18.
//  Copyright © 2017 Agile. All rights reserved.
//



import UIKit
import PureLayout

class AIDialogueSnackAlert: UIView {
	
	//MARK:- OUTLETS
	@IBOutlet private var contentView:UIView?
	@IBOutlet weak var lblText: AILabel!
	@IBOutlet weak var topConsLblText: NSLayoutConstraint!
	
	
	
	//MARK:- PROPERTIES
	var dialogCloseCompletionHandler: ((_ completion:Bool) -> (Void))?
	
	
	// MARK:- INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func commonInit()	{
		
		// LOADING NIB FILE
		Bundle.main.loadNibNamed("AIDialogueSnackAlert", owner: self, options: nil)
		Constant.appDelegate.window!.addSubview(self)
		self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsetsMake(64, 0, 0, 0), excludingEdge: ALEdge.bottom)

		self.addSubview(self.contentView!);
		self.contentView!.autoPinEdgesToSuperviewEdges()

		// UI
		self.contentView!.backgroundColor = Constant.Colors.APP_COLOR_GREEN
		self.lblText.textColor = Constant.Colors.WHITE_COLOR
		
		self.topConsLblText.constant = 12
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		// SHOWING DIALOGUE FROM HERE, BECAUSE HERE DIALOGUE WILL HAVE ITS PROPER HEIGHT BASED ON LABEL CONTENT
		self.showDialogue()
	}
	
	
	// MARK:- BUTTON EVENTS
	@IBAction func btnOkPressed(sender: UIButton)	{
		self.hideDialogue(completion: false)
	}
	
	
	// MARK:- SHOW / HIDE DIALOGUE
	func showDialogue(withMessage message:String, andCompletion completion: @escaping (_ completion:Bool) -> Void){

		self.lblText.text = message
		self.dialogCloseCompletionHandler = completion
	}

	
	func showDialogue(withMessage message:String, bgColor:UIColor, topBottomMargin:CGFloat, andCompletion completion: @escaping (_ completion:Bool) -> Void){
		
		self.topConsLblText.constant = topBottomMargin
		self.contentView!.backgroundColor = bgColor
		self.lblText.text = message
		self.dialogCloseCompletionHandler = completion
	}

	

	private func showDialogue(){
		
		self.transform = CGAffineTransform(scaleX: 1, y: 0)
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.transform = CGAffineTransform.identity
		})
		
		
		// HIDING DIALOG AFTER 2 SECONDS
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
			self.hideDialogue(completion: false)
		}
	}
	
	private func hideDialogue(completion:Bool){
		
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.alpha = 0
		}) { (booo:Bool) -> Void in
			self.removeFromSuperview()
			self.dialogCloseCompletionHandler!(completion)
		}
	}
}
