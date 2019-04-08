//
//  BaseTabBarController.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/08.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = ThemeColor.background
    }
    
    private func setupViewControllers() {
        viewControllers = [
            makeNavigationController(viewController: UIViewController(), title: "ホーム", imageName: "home"),
            makeNavigationController(viewController: UIViewController(), title: "探す", imageName: "search"),
            makeNavigationController(viewController: UIViewController(), title: "トーク一覧", imageName: "chat"),
            makeNavigationController(viewController: UIViewController(), title: "お知らせ", imageName: "notification"),
            makeNavigationController(viewController: ProfileViewController(), title: "プロフィール", imageName: "profile")
        ]
    }
    
    private func makeNavigationController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let nav = BaseNavController(rootViewController: viewController)
        nav.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        
        viewController.view.backgroundColor = ThemeColor.background
        viewController.navigationItem.titleView = UILabel().barTitle(title)
        
        
        return nav
    }
}
