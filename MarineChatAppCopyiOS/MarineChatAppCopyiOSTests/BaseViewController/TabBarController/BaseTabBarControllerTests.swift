//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatAppCopyiOS

class BaseTabBarControllerTests: XCTestCase {
    
    func test_ViewDidLoad_TabBarHasCurrectBackgroundColor() {
        let backgroundColor = UIColor.gray
        let sut = BaseTabBarController(tabBarBackgroundColor: backgroundColor)
        _ = sut.view
        
        XCTAssertEqual(sut.tabBar.backgroundColor, backgroundColor)
    }
    
    func test_ViewDidLoad_TabBarShadowImageAndBackgroundImageIsNotNil() {
        let sut = BaseTabBarController()
        _ = sut.view
        
        XCTAssertNotNil(sut.tabBar.shadowImage)
        XCTAssertNotNil(sut.tabBar.backgroundImage)
    }
}
