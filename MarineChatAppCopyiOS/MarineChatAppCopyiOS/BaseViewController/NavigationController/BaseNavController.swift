//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class BaseNavController: UINavigationController {
    
    private var barTintColor: UIColor!
    
    convenience init(rootViewController: UIViewController = UIViewController(), barTintColor: UIColor) {
        self.init(rootViewController: rootViewController)
        self.barTintColor = barTintColor
        self.navigationBar.barTintColor = barTintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.tintColor = barTintColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
