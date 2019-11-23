//
//  CodeChallengeRequests.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 23/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import Foundation

enum CodeChallengeService {
	case allWords
}

extension CodeChallengeService: Service {
	var baseURL: String {
		return "https://codechallenge.arctouch.com"
	}
	
	var path: String {
		switch self {
		case .allWords:
			return "/quiz/1"
		}
	}
	
	var parameters: [String: Any]? {
		let params: [String: Any] = [String: Any]()
		
		switch self {
		case .allWords: break
		}
		return params
	}
	
	var method: ServiceMethod {
		return .get
	}
}
