//
//  GenericObservable.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 23/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import Foundation

class Observable<ValueType> {
	typealias Observer = (ValueType) -> Void
	
	var observers: [Observer] = []
	var value: ValueType {
		didSet {
			for observer in observers {
				observer(value)
			}
		}
	}
	
	init(_ defaultValue: ValueType) {
		value = defaultValue
	}
	
	func addObserver(_ observer: @escaping Observer) {
		observers.append(observer)
	}
}
