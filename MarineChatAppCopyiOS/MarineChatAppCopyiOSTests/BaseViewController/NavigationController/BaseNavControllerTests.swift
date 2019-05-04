//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatAppCopyiOS

class BaseNavControllerTests: XCTestCase {

    func test_ViewDidLoad_NavigationBarHasCurrectBarTintColor() {
        let tintColor = UIColor.gray
        let sut = BaseNavController(barTintColor: tintColor)
        _ = sut.view
        
        XCTAssertEqual(sut.navigationBar.barTintColor, tintColor)
    }
    
    func test_ViewDidLoad_ShadowImageIsNotNil() {
        let sut = BaseNavController()
        _ = sut.view
        
        XCTAssertNotNil(sut.navigationBar.shadowImage)
    }
    
    func test_ViewDidLoad_HasCurrectPreferredStatusBarStyle() {
        let sut = BaseNavController()
        _ = sut.view
        
        XCTAssertEqual(sut.preferredStatusBarStyle, .lightContent)
    }
}
