//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatAppCopyiOS

class BaseSectionViewControllerTests: XCTestCase {

    func test_ViewDidLoad_HasTableView() {
        let sut = BaseSectionViewController()
        _ = sut.view
        
        XCTAssertNotNil(sut.feedTableView)
    }
    
    func test_ViewDidLoad_FeedTableViewIsAddedToViewsSubview() {
        let sut = BaseSectionViewController()
        _ = sut.view
        
        XCTAssertNotNil(sut.feedTableView.superview)
    }
    
    func test_ViewDidLoad_HasCurrectFeedTableViewLayoutTrait() {
        let sut = BaseSectionViewController(layoutTrait: .compactWidth)
        _ = sut.view
        
        XCTAssertEqual(sut.layoutTrait, .compactWidth)
    }
    
    func test_ViewDidLoad_WhenLayoutTraitIsFullWidth_FeedTableViewHasSameWidthAsView() {
        let sut = BaseSectionViewController(layoutTrait: .fullWidth)
        _ = sut.view
        
        XCTAssertEqual(sut.view?.bounds.width, sut.feedTableView.bounds.width)
        
        sut.view.bounds.size.width = 1000
        sut.viewDidLayoutSubviews()
        
        XCTAssertEqual(sut.view?.bounds.width, sut.feedTableView.bounds.width)
    }
    
    func test_ViewDidLoad_WhenLayoutTraitIsCompactWidth_FeedTableViewHas768pxMax() {
        let sut = BaseSectionViewController(layoutTrait: .compactWidth)
        _ = sut.view
        sut.view?.bounds.size.width = 1000
        sut.viewDidLayoutSubviews()
        
        XCTAssertEqual(sut.feedTableView.bounds.width, 768)
        XCTAssertTrue(sut.feedTableView.bounds.width < sut.view.bounds.width)
        
        sut.view?.bounds.size.width = 700
        sut.viewDidLayoutSubviews()
        
        XCTAssertTrue(sut.feedTableView.bounds.width < 768)
        XCTAssertEqual(sut.feedTableView.bounds.width, sut.view.bounds.width)
    }
    
    func test_ViewDidApear_TabBarHasCurrectTintColor() {
        let tintColor = UIColor.green
        let tintColor2 = UIColor.blue
        let sut = BaseSectionViewController(tabBarTintColor: tintColor)
        let sut2 = BaseSectionViewController(tabBarTintColor: tintColor2)
        let sut3 = BaseSectionViewController()
        _ = sut.view
        _ = sut2.view
        let tabBar = UITabBarController()
        tabBar.setViewControllers([sut, sut2, sut3], animated: false)
        tabBar.selectedIndex = 0
        sut.viewDidAppear(false)
        XCTAssertEqual(sut.tabBarController?.tabBar.tintColor, tintColor)
        tabBar.selectedIndex = 1
        sut2.viewDidAppear(false)
        XCTAssertEqual(sut2.tabBarController?.tabBar.tintColor, tintColor2)
        tabBar.selectedIndex = 2
        sut3.viewDidAppear(false)
        XCTAssertNotEqual(sut3.tabBarController?.tabBar.tintColor, tintColor)
        XCTAssertNotEqual(sut3.tabBarController?.tabBar.tintColor, tintColor2)
    }
}

//tabBarController?.tabBar.tintColor = ThemeColor.main
