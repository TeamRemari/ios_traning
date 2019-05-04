//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

struct BaseSectionViewControllerPresenter {
    
    private let baseVC: BaseSectionViewController
    private let viewControllerFactory: ViewControllerFactory
    private let tabBarImage: UIImage
    private let titleView: UIView
    
    init(baseVC: BaseSectionViewController,
         factory: ViewControllerFactory,
         tabBarImage: UIImage,
         titleView: UIView) {
        self.baseVC = baseVC
        self.viewControllerFactory = factory
        self.tabBarImage = tabBarImage
        self.titleView = titleView
    }
    
    var viewController: UIViewController {
        baseVC.navigationItem.titleView = titleView
        return pushBaseVCToBaseNavController()
    }
    
    private func pushBaseVCToBaseNavController() -> UINavigationController {
        let baseNavVC = viewControllerFactory.makeBaseNavController(rootViewController: baseVC)
        baseNavVC.tabBarItem.image = tabBarImage.withRenderingMode(.alwaysTemplate)
        return baseNavVC
    }
}
