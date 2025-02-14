//
//  BaseManager.swift
//  MinterCore
//
//  Created by Alexey Sidorov on 19/02/2018.
//

import Foundation


public enum BaseManagerError : Error {
	/// Error showing that result differs from the expected
	case badResponse
}


/// Base Manager class
open class BaseManager {
	
	// MARK: -
	/// HTTP Client to be used to make requests to the endpoint
	public var httpClient: HTTPClient
	
	public required init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}

}
