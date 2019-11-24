//
//  Fonts.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 21/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import Foundation

enum Fonts {
	case SFProDisplayBold
	case SFProDisplaySemibold
	case SFProDisplayRegular
	
	var fontName: String {
		switch self {
		case .SFProDisplayBold:
			return "SF-Pro-Display-Bold"
		case .SFProDisplaySemibold:
			return "SF-Pro-Display-Semibold"
		case .SFProDisplayRegular:
			return "SF-Pro-Display-Regular"
		}
	}
}
