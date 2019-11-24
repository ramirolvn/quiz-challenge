//
//  LoaderView.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 21/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import UIKit

class LoaderView: UIView {
	
	
	@IBOutlet weak var blackView: UIView!
	@IBOutlet weak var activityLoader: UIActivityIndicatorView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.black.withAlphaComponent(0.5)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		blackView.clipsToBounds = true
		blackView.layer.cornerRadius = 12
		activityLoader.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		backgroundColor = UIColor.black.withAlphaComponent(0.5)
	}
	
}
