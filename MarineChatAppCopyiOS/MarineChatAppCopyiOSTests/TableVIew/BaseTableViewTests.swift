//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatAppCopyiOS

class BaseTableViewTests: XCTestCase {
    
    func test_Init_SeparatorStyleIsNone() {
        let sut = BaseTableView()
        XCTAssertEqual(sut.separatorStyle, .none)
    }
    
    func test_Init_DoesNotAllowSelection() {
        let sut = BaseTableView()
        XCTAssertFalse(sut.allowsSelection)
    }

}
