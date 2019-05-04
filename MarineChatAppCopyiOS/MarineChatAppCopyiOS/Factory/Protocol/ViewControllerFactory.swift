//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol ViewControllerFactory {
    func makeBaseTabBarController() -> UITabBarController
    func makeBaseNavController(rootViewController: UIViewController) -> UINavigationController
}
