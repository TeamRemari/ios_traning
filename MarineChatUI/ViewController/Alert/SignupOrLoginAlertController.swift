//
//  SignupOrLoginAlertController.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/08.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class SignupOrLoginAlertController: UIAlertController {
    
    private weak var callerVC: UIViewController?
    
    private lazy var signupAction: UIAlertAction = {
        return UIAlertAction(title: "登録する", style: .default, handler: { [weak self] (_) in
            self?.callerVC?.tabBarController?.present(BaseNavController(rootViewController: ProfileSettingViewController()), animated: true, completion: nil)
        })
    }()
    
    private lazy var loginAction: UIAlertAction = {
        return UIAlertAction(title: "ログインする", style: .default, handler: nil)
    }()
    
    private lazy var cancelAction: UIAlertAction = {
        return UIAlertAction(title: "今はしない", style: .cancel, handler: { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        })
    }()
    
    convenience init(calledBy viewController: UIViewController) {
        self.init(title: "この機能を使うにはユーザー登録が必要です", message: nil, preferredStyle: .alert)
        callerVC = viewController
        
        [signupAction, loginAction, cancelAction].forEach({
            addAction($0)
        })
    }
}
