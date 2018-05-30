//
//  Transaction.swift
//  MinterCore
//
//  Created by Alexey Sidorov on 19/02/2018.
//

import Foundation
import ObjectMapper

open class Transaction {

	let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss+zzzz", locale: Locale.current.identifier)
	
	public enum TransactionType: String {
		case sendCoin = "sendCoin"
	}
	
	public init() {
		
	}
	
	public var hash: String?
	public var type: TransactionType?
	public var from: String?
	public var to: String?
	public var coinSymbol: String?
	public var value: Double?
	public var date: Date?
}

class TransactionMappable : Transaction, Mappable {
	
	//MARK: - Mappable
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		self.hash <- map["hash"]
		self.type <- map["type"]
		self.from <- map["from"]
		self.to <- map["data.to"]
		self.coinSymbol <- map["data.coin"]
		self.value <- map["data.value"]
		self.date <- (map["date"], DateFormatterTransform(dateFormatter: dateFormatter))
	}

	//MARK: -
}
