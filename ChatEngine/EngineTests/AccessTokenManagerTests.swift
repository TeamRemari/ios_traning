//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatCopyAppEngine

private let fakeAccessToken = "fakeAccessToken"

class AccessTokenManagerTests: XCTestCase {
    
    func test_AccessToken_WhenDatabaseHasOne_ReturnsTheToken() {
        let sut = AccessTokenManager<String>(tokenLoader: fakeTokenLoader)

        XCTAssertEqual(sut.accessToken, fakeAccessToken)
    }
    
    func test_AccessToken_WhenDatabaseDoesNotHaveOne_ReturnsNil() {
        let sut = AccessTokenManager<String> {
            return AccessTokenState<String>.none
        }
        
        XCTAssertNil(sut.accessToken)
    }
    
    func test_AccessToken_WhenManagerAlreadyHasOne_DoesNotTryLoadingAgain() {
        var tokenLoadedCount = 0
        let sut = AccessTokenManager<String> { [weak self] in
            tokenLoadedCount += 1
            return self!.fakeTokenLoader()
        }
        XCTAssertNotNil(sut.accessToken)
        XCTAssertNotNil(sut.accessToken)
        XCTAssertEqual(tokenLoadedCount, 1)
    }

    // MARK: Helper
    
    let fakeTokenLoader: () -> AccessTokenState<String> = {
        return AccessTokenState<String>.hasAccessToken(fakeAccessToken)
    }

}
