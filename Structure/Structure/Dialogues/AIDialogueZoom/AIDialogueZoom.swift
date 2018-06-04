//
//  AIDialogueZoom.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 24/08/17.
//  Copyright © 2017 Agile. All rights reserved.
//

import UIKit

enum AnimationType {
	
	case
	fromTop,
	scale,
	none
}
class AIDialogueZoom: UIView {
	
	//MARK:- OUTLETS
	@IBOutlet private var contentView:UIView!
	@IBOutlet private var viewContainer:UIView!
	@IBOutlet private var btnClose:AIButton!
	
	@IBOutlet private var scrollView:UIScrollView!
	@IBOutlet private var imageView:UIImageView!
	
	
	//MARK:- PROPERTIES
	static let shared = AIDialogueZoom()
	var blockCompletion:(()->Void)?
	
	
	//MARK:- VARIABLES
	var viewTempBG: UIView?
	var animationType:AnimationType = .none
	var scaleValue:CGFloat = 0.01
	
	
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
		Bundle.main.loadNibNamed("AIDialogueZoom", owner: self, options: nil)
		self.addSubview(self.contentView!);

		// CREATING TEMP VIEW FOR BACKGROUND FADE ANIMATION
		self.viewTempBG = UIView(forAutoLayout: ())
		
		
		// UI
		self.contentView!.backgroundColor = Constant.Colors.CLEAR_COLOR
		

		// ANIMATIION TYPE
		self.animationType = .scale
	}
	
	
	// MARK:- BUTTON EVENTS
	@IBAction func btnClosePressed(_ sender: UIButton) {
		hide()
	}
	
	
	// MARK:- SHOW / HIDE DIALOGUE
    func showDialogue(for image:UIImage, with completion:@escaping (()->Void)){
		
		self.imageView.image = image
		self.blockCompletion = completion
		Constant.appDelegate.window?.endEditing(true)
		
		self.show()
	}
	
	
	private func show(){
		
		Constant.appDelegate.window?.addSubview(self.viewTempBG!)
		Constant.appDelegate.window?.addSubview(self)
		
		self.viewTempBG?.autoSetDimensions(to: CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
		self.autoSetDimensions(to: CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
		self.contentView!.autoPinEdgesToSuperviewEdges()
		self.autoCenterInSuperview()

		// SHOULD BE CALLED BEFORE MAKING ANY FRAME RELATED CHANGES
		self.layoutIfNeeded()
		
		self.viewContainer.applyCornerRadius(radius: 15)
		self.btnClose.applyCircle()
		
		
		switch self.animationType {
		case .fromTop:
			self.transform = CGAffineTransform(translationX: 0, y: -self.height)
		case .scale:
			self.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
			self.alpha = 0
		case .none:
			break
		}
		
		UIView.animate(withDuration: 0.3, animations: { () -> Void in
			self.viewTempBG?.backgroundColor = Constant.Colors.BLACK_COLOR.withAlphaComponent(0.3)
			self.transform = CGAffineTransform.identity
			self.alpha = 1
		})
		

	}
	
	func hide(){
		
		UIView.animate(withDuration: 0.3, animations: { () -> Void in
			
			switch self.animationType {
			case .fromTop:
				self.transform = CGAffineTransform(translationX: 0, y: -self.height)
			case .scale:
				self.transform = CGAffineTransform(scaleX: self.scaleValue, y: self.scaleValue)
				self.alpha = 0
			case .none:
				self.alpha = 0
			}
			self.viewTempBG?.backgroundColor = Constant.Colors.CLEAR_COLOR
		}) { (booo:Bool) -> Void in
			self.removeFromSuperview()
			self.viewTempBG?.removeFromSuperview()
			if self.blockCompletion != nil {
				self.blockCompletion!()
			}
		}
	}
}







//class AIDialogueZoom: UIView {
//	
//	//MARK:- OUTLETS
//	@IBOutlet private var contentView:UIView!
//	@IBOutlet private var viewContainer:UIView!
//	@IBOutlet private var btnClose:AIButton!
//	
//	@IBOutlet private var scrollView:UIScrollView!
//	@IBOutlet private var imageView:UIImageView!
//	
//	
//	//MARK:- PROPERTIES
//	static let shared = AIDialogueInfo()
//	var blockCompletion:((Void)->Void)?
//	
//	
//	//MARK:- VARIABLES
//	var viewTempBG: UIView?
//	var animationType:AnimationType = .none
//	var scaleValue:CGFloat = 0.01
//	
//	
//	// MARK:- INIT
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//		self.commonInit()
//	}
//	
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//	
//	private func commonInit()	{
//		
//		// ADDING TEMP BG VIEW FOR COLOR CHANGE ANIMATION
//		self.viewTempBG = UIView(forAutoLayout: ())
//		Constant.appDelegate.window?.addSubview(self.viewTempBG!)
//		self.viewTempBG?.autoPinEdgesToSuperviewEdges()
//		
//		
//		// LOADING NIB FILE
//		Bundle.main.loadNibNamed("AIDialogueZoom", owner: self, options: nil)
//		Constant.appDelegate.window!.addSubview(self)
//		self.autoPinEdgesToSuperviewEdges()
//		self.addSubview(self.contentView!);
//		self.contentView!.autoPinEdgesToSuperviewEdges()
//		
//		// UI
//		self.contentView!.backgroundColor = CLEAR_COLOR
//		
//		
//		
//		// SCROLLVIEW
//		scrollView.minimumZoomScale = MIN_ZOOM_SCALE
//		scrollView.maximumZoomScale = MAX_ZOOM_SCALE
//		scrollView.zoomScale = DEFAULT_ZOOM_SCALE
//		
//		scrollView.delegate = self
//		scrollView.bounces = false
//		scrollView.bouncesZoom = false
//
//		
//		// ANIMATIION TYPE
//		self.animationType = .scale
//		
//		print("\n\nBTN 1 \(self.btnClose.frame)")
//	}
//	
//	
//	override func layoutSubviews() {
//		super.layoutSubviews()
//		
//		self.viewContainer.applyCornerRadius(radius: 15)
//		self.btnClose.applyCircle()
//		print("\n\nBTN 2 \(self.btnClose.frame)")
//		self.show()
//	}
//	
//	// MARK:- BUTTON EVENTS
//	@IBAction func btnClosePressed(_ sender: UIButton) {
//		hide()
//	}
//	
//	
//	// MARK:- SHOW / HIDE DIALOGUE
//	func showDialogue(for image:UIImage, with completion:@escaping ((Void)->Void)){
//		
//		self.imageView.image = image
//		self.blockCompletion = completion
//		Constant.appDelegate.window?.endEditing(true)
//		
//		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
//			self.btnClose.applyCircle()
//		}
//	}
//	
//	
//	private func show(){
//		
//		switch self.animationType {
//		case .fromTop:
//			self.transform = CGAffineTransform(translationX: 0, y: -self.height)
//		case .scale:
//			self.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
//			self.alpha = 0
//		case .none:
//			break
//		}
//		
//		UIView.animate(withDuration: 0.3, animations: { () -> Void in
//			self.viewTempBG?.backgroundColor = BLACK_COLOR.withAlphaComponent(0.3)
//			self.transform = CGAffineTransform.identity
//			self.alpha = 1
//		})
//	}
//	
//	func hide(){
//		
//		UIView.animate(withDuration: 0.3, animations: { () -> Void in
//			
//			switch self.animationType {
//			case .fromTop:
//				self.transform = CGAffineTransform(translationX: 0, y: -self.height)
//			case .scale:
//				self.transform = CGAffineTransform(scaleX: self.scaleValue, y: self.scaleValue)
//				self.alpha = 0
//			case .none:
//				self.alpha = 0
//			}
//			self.viewTempBG?.backgroundColor = CLEAR_COLOR
//		}) { (booo:Bool) -> Void in
//			self.removeFromSuperview()
//			self.viewTempBG?.removeFromSuperview()
//			if self.blockCompletion != nil {
//				self.blockCompletion!()
//			}
//		}
//	}
//}
