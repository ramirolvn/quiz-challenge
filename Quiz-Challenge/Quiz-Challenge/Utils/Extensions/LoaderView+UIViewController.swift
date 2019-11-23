//
//  LoaderView+UIViewController.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 21/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import UIKit
extension UIViewController {
	
	// MARK: - Activity Indicator
	func startLoad() {
		let nib = UINib(nibName: "LoaderView", bundle: nil)
		let customAlert = nib.instantiate(withOwner: self, options: nil).first as! LoaderView
		
		customAlert.tag = ViewsTag.tagLoaderView
		
		let screen = UIScreen.main.bounds
		customAlert.center = CGPoint(x: screen.midX, y: screen.midY)
		customAlert.frame = screen
		
		self.view.addSubview(customAlert)
	}
	
	func stopLoad() {
		if let view = self.view.viewWithTag(ViewsTag.tagLoaderView) {
			view.removeFromSuperview()
		}
	}
}
