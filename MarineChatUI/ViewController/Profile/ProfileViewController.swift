//
//  ProfileViewController.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/08.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let settingButton = UIBarButtonItem().settingButton()
    
    private let profileImage: UIButton = {
        let button = UIButton.circleShapedButton(sideLength: Length.diameterLarge)
        button.layer.borderWidth = 1
        button.layer.borderColor = ThemeColor.dark026.cgColor
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = ThemeColor.dark087
        label.text = "未設定"
        return label
    }()
    
    private let profileDetailLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.text = "未設定"
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ThemeColor.main
        button.tintColor = ThemeColor.onMain
        button.setImage(UIImage(named: "signup")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitle("プロフィールを設定する", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(signUpButtonIsTapped), for: .touchUpInside)
        button.setTitleColor(ThemeColor.onMainDisabled, for: UIControl.State.highlighted)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        [profileImage, nameLabel, profileDetailLabel, signUpButton].forEach({
            view.addSubview($0)
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutProfileImage()
        layoutNameLabel()
        layoutProfileDetailLabel()
        layoutSignupButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = ThemeColor.surface
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = settingButton
        settingButton.target = self
        settingButton.action = #selector(settingButtonTapped)
    }
    
    private func layoutProfileImage() {
        profileImage.frame.origin = CGPoint(x: Length.horizontalPadding, y: view.layoutMargins.top + Length.verticalPadding)
    }
    
    private func layoutNameLabel() {
        nameLabel.frame.size = nameLabel.intrinsicContentSize
        nameLabel.frame.origin.x = profileImage.frame.maxX + Length.horizontalPadding
        nameLabel.frame.origin.y = profileImage.center.y - nameLabel.bounds.height
    }
    
    private func layoutProfileDetailLabel() {
        profileDetailLabel.frame.size = profileDetailLabel.intrinsicContentSize
        profileDetailLabel.frame.origin = .init(x: nameLabel.frame.minX, y: nameLabel.frame.maxY + Length.spacingNormal)
    }
    
    private func layoutSignupButton() {
        signUpButton.sizeToFit()
        signUpButton.frame.origin = .init(x: profileImage.frame.minX, y: profileImage.frame.maxY + Length.spacingLarge)
        signUpButton.frame.size = .init(width: view.bounds.width - signUpButton.frame.minX * 2, height: signUpButton.frame.size.height * 2)
    }
    
    @objc private func settingButtonTapped() {
        present(SignupOrLoginAlertController(calledBy: self), animated: true, completion: nil)
    }
    
    @objc private func signUpButtonIsTapped() {
        let profileSettingView = BaseNavController(rootViewController: ProfileSettingViewController())
        tabBarController?.present(profileSettingView, animated: true, completion: nil)
    }
    
}
