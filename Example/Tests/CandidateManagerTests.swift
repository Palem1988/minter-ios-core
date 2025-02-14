//
//  CandidateManagerTests.swift
//  MinterCore_Tests
//
//  Created by Alexey Sidorov on 19/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import MinterCore

class CandidateManagerTestsSpec : BaseQuickSpec {

	let http = APIClient()
	var manager: CandidateManager?

	override func spec() {
		super.spec()

		describe("CandidateManager") {
			it("CandidateManager can be initialized") {
				let manager = CandidateManager(httpClient: self.http)

				expect(manager).toNot(beNil())
			}

			it("CandidateManager can request candiadte data") {
				self.manager = CandidateManager(httpClient: self.http)

				waitUntil(timeout: 10.0) { done in
					self.manager?.candidate(publicKey: "Mp0d29a83e54653a1d5f34e561e0135f1e81cbcae152f1f327ab36857a7e32de4c", completion: { (response, error) in

						expect(error).to(beNil())
						expect(response).toNot(beNil())

						done()
					})
				}
			}

			it("CandidateManager can request incorrect candiadte") {
				self.manager = CandidateManager(httpClient: self.http)
				
				waitUntil(timeout: 10.0) { done in
					self.manager?.candidate(publicKey: "112", completion: { (response, error) in
						
						expect(error).toNot(beNil())
						expect(response).to(beNil())
						
						done()
					})
				}
			}
			
			it("CandidateManager can retreive candidates") {
				self.manager = CandidateManager(httpClient: self.http)

				waitUntil(timeout: 10.0) { done in
					self.manager?.candidates(includeStakes: false, completion: { (response, error) in

						expect(error).to(beNil())
						expect(response).toNot(beNil())

						done()
					})
				}
			}
			
		}
	}
}
