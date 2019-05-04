//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    
    private var tabBarBackgroundColor: UIColor!
    
    convenience init(tabBarBackgroundColor: UIColor) {
        self.init()
        self.tabBarBackgroundColor = tabBarBackgroundColor
        tabBar.backgroundColor = tabBarBackgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
}
