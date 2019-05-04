//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatAppCopyiOS

class BaseSectionViewControllerPresenterTests: XCTestCase {
    
    let fakeViewController = BaseSectionViewController()
    
    func test_ViewController_ViewControllerHasBaseNavController() {
        _ = makeSUT().viewController
        
        XCTAssertNotNil(fakeViewController.navigationController as? BaseNavController)
    }
    
    func test_ViewController_NavigationControllerHasCurrectTabBarItemImage() {
        let image = UIImage()
        _ = makeSUT(image: image).viewController
        
        let presentedImage = fakeViewController.navigationController?.tabBarItem.image
        
        XCTAssertTrue(image.withRenderingMode(.alwaysTemplate) === presentedImage!)
        XCTAssertEqual(presentedImage?.renderingMode, .alwaysTemplate)
    }
    
    func test_ViewController_NavigationControllerHasCurrectTitleView() {
        let titleLabel = UILabel()
        _ = makeSUT(title: titleLabel).viewController
        
        let presentedTitleLabel = fakeViewController.navigationItem.titleView
        
        XCTAssertTrue(presentedTitleLabel === titleLabel)
    }
    
    // MARK: Helper
    
    private func makeSUT(image: UIImage = UIImage(), title: UILabel = UILabel()) -> BaseSectionViewControllerPresenter {
        return BaseSectionViewControllerPresenter(baseVC: fakeViewController, factory: ViewControllerFactoryMock(), tabBarImage: image, titleView: title)
    }
    
    class ViewControllerFactoryMock: ViewControllerFactory {
        func makeBaseTabBarController() -> UITabBarController {
            return UITabBarController()
        }
        
        func makeBaseNavController(rootViewController: UIViewController) -> UINavigationController {
            let navVC = BaseNavController(rootViewController: rootViewController, barTintColor: UIColor.white)
            return navVC
        }
    }
}
