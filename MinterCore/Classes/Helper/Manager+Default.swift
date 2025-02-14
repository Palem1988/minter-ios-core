//
//  Manager+Default.swift
//  MinterCore
//
//  Created by Alexey Sidorov on 20/02/2018.
//

import Foundation

public extension AccountManager {
	
	class var `default`: AccountManager {
		get {
			let httpClient = APIClient.shared
			let manager = self.init(httpClient: httpClient)
			return manager
		}
	}
}

public extension TransactionManager {
	
	class var `default`: MinterCore.TransactionManager {
		get {
			let httpClient = APIClient.shared
			let manager = self.init(httpClient: httpClient)
			return manager
		}
	}
}

public extension CoinManager {
	
	class var `default`: CoinManager {
		get {
			let httpClient = APIClient.shared
			let manager = self.init(httpClient: httpClient)
			return manager
		}
	}
}

public extension StatusManager {
	
	class var `default` : StatusManager {
		get {
			let httpClient = APIClient.shared
			let manager = self.init(httpClient: httpClient)
			return manager
		}
	}
}

public extension CandidateManager {
	
	class var `default` : CandidateManager {
		get {
			let httpClient = APIClient.shared
			let manager = self.init(httpClient: httpClient)
			return manager
		}
	}
}

public extension ValidatorManager {
	
	class var `default` : ValidatorManager {
		get {
			let httpClient = APIClient.shared
			let manager = self.init(httpClient: httpClient)
			return manager
		}
	}
}

public extension BlockManager {
	
	class var `default` : BlockManager {
		get {
			let httpClient = APIClient.shared
			let manager = self.init(httpClient: httpClient)
			return manager
		}
	}
}

public extension EventManager {
	
	class var `default` : EventManager {
		get {
			let httpClient = APIClient.shared
			let manager = self.init(httpClient: httpClient)
			return manager
		}
	}
}
