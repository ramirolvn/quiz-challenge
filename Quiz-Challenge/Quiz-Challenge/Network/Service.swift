//
//  Service.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 23/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import Foundation

enum ServiceMethod: String {
	case get = "GET"
}

protocol Service {
	var baseURL: String { get }
	var path: String { get }
	var parameters: [String: Any]? { get }
	var method: ServiceMethod { get }
}

extension Service {
	public var urlRequest: URLRequest {
		guard let url = self.url else {
			fatalError("URL could not be built")
		}
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		
		return request
	}
	
	private var url: URL? {
		var urlComponents = URLComponents(string: baseURL)
		urlComponents?.path = path
		
		if method == .get {
			guard let parameters = parameters as? [String: String] else {
				fatalError("parameters for GET http method must conform to [String: String]")
			}
			urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
		}
		
		return urlComponents?.url
	}
}
