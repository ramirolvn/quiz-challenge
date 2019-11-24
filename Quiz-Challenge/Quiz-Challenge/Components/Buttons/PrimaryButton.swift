//
//  PrimaryButton.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 21/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configPrimaryButton()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configPrimaryButton()
	}
	
	private func configPrimaryButton() {
		self.layer.cornerRadius = 8
		self.titleLabel?.font = UIFont(name: Fonts.SFProDisplaySemibold.fontName, size: 17.0)
		self.setTitleColor(.white, for: .normal)
		self.tintColor = .white
		self.enable()
	}
	
	func disable() {
		self.isEnabled = false
		self.backgroundColor = Colors.gray
	}
	
	func enable() {
		self.isEnabled = true
		self.backgroundColor = Colors.orange
		
	}
	
}
