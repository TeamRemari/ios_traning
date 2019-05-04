//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatCopyAppEngine

final class APIEndpointTests: XCTestCase {
    
    func test_URL_returnsCurrectURL() {
        let sut = APIEndpoint(host: "www.google.com", path: "/search",
                              queryItems: [
                                URLQueryItem(name: "q", value: "Foo"),
                                URLQueryItem(name: "test", value: "Bar")
            ])
        let expectedURL = URL(string: "https://www.google.com/search?q=Foo&test=Bar")
        XCTAssertEqual(expectedURL, sut.url)
    }

}
