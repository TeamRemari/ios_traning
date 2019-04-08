//
//  BaseNavController.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/08.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class BaseNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = ThemeColor.main
        navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.tintColor = ThemeColor.main
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
