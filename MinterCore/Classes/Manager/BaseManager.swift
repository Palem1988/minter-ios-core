//
//  BaseManager.swift
//  Alamofire
//
//  Created by Alexey Sidorov on 19/02/2018.
//

import Foundation

public class BaseManager {
	
	//MARK: -
	
	var httpClient: HTTPClient
	
	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}

}
