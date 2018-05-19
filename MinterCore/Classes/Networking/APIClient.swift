//
//  APIClient.swift
//  MinterCore
//
//  Created by Alexey Sidorov on 19/02/2018.
//

import Foundation
import Alamofire

public class APIClient {
	
	//MARK: -
	
	public static let shared = APIClient()
	
	private init() {}
	
	//MARK: -
		
	fileprivate static var configuration = URLSessionConfiguration.default {
		didSet {
			let headers = SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]
			self.configuration.httpAdditionalHeaders = headers
			self.configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
		}
	}

	fileprivate static var AlamofireManager: SessionManager = {
		return SessionManager(configuration: configuration)
	}()

	fileprivate class func updatedManager(_ headers: [AnyHashable: Any?]? = nil) -> SessionManager {
		let defaultHeaders = AlamofireManager.session.configuration.httpAdditionalHeaders
		var newHeaders = defaultHeaders ?? [:]
		
		if headers != nil {
			for (key, value) in headers! {
				if let value = value {
					newHeaders[key] = value
				} else {
					newHeaders.removeValue(forKey: key)
				}
			}
		}
		
		let configuration = AlamofireManager.session.configuration
		configuration.httpAdditionalHeaders = newHeaders
		return SessionManager(configuration: configuration)
	}

	// MARK: - Alamofire helper function.
	fileprivate func performRequest(_ URL: URL, parameters: [String: Any]? = nil, method: HTTPMethod = .get, completion: HTTPClient.CompletionBlock?) {
//		var headers = [String : String]()
//		headers["Accept"] = "application/json, text/plain, */*"
//		headers["Content-Type"] = nil
		
		let encodeUsing: ParameterEncoding = JSONEncoding.default//(method == .post || method == .put) ? JSONEncoding.default : URLEncoding.default
		let manager = APIClient.AlamofireManager
		manager.request(URL, method: method, parameters: parameters, encoding: encodeUsing).responseJSON { response in
			
			var error: Error?
			var resp = HTTPClient.HTTPClientResponse(HTTPClientResponseStatusCode.unknownError, [:])
			
			defer {
				completion?(resp, error)
			}
			
			error = response.error
			
			guard let result = response.result.value as? [String : Any] else {
				return
			}
			
			if let code = result["code"] as? Int, let respData = result["result"] {
				resp = HTTPClient.HTTPClientResponse(HTTPClientResponseStatusCode(rawValue: code) ?? HTTPClientResponseStatusCode.unknown, respData)
			}
		}
	}
}

extension APIClient : HTTPClient {

	// MARK: - Protocol methods
	
	public func postRequest(_ URL: URL, parameters: [String: Any]?, completion: HTTPClient.CompletionBlock?) {
		performRequest(URL, parameters: parameters,  method: .post, completion: completion)
	}
	
	public func getRequest(_ URL: URL, parameters: [String: Any]?, completion: HTTPClient.CompletionBlock?) {
		performRequest(URL, parameters: parameters,  method: .get, completion: completion)
	}
	
	public func putRequest(_ URL: URL, parameters: [String: Any]?, completion: HTTPClient.CompletionBlock?) {
		performRequest(URL, parameters: parameters,  method: .put, completion: completion)
	}
	
	public func deleteRequest(_ URL: URL, parameters: [String: Any]?, completion: HTTPClient.CompletionBlock?) {
		performRequest(URL, parameters: parameters,  method: .delete, completion: completion)
	}
	
}

