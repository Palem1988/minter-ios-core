//
//  CoinManager.swift
//  MinterCore
//
//  Created by Alexey Sidorov on 22/02/2018.
//

import Foundation
import ObjectMapper
import BigInt


public enum CoinManagerError : Error {
	case wrongAmount
	/// Estimate can't be parsed or something
	case noEstimate
}

/// Coin Manager Class cointains methods to work with coins
public class CoinManager : BaseManager {

	/**
	Method retreives coin info
	- Parameters:
	- symbol: Coin symbol e.g. MNT
	- completion: Method which will be called after request finished
	- Precondition: symbol must be uppercased (e.g. MNT)
	*/
	public func info(symbol: String, completion: ((Coin?, Error?) -> ())?) {
		
		let url = MinterAPIURL.coinInfo(coin: symbol).url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var coin: Coin?
			var err: Error?
			
			defer {
				completion?(coin, err)
			}
			
			guard error == nil else {
				err = error
				return
			}
			
			guard let resultPayload = response.data as? [String : Any] else {
				err = BaseManagerError.badResponse
				return
			}
			
			coin = Mapper<CoinMappable>().map(JSON: resultPayload)
		}
	}

}
