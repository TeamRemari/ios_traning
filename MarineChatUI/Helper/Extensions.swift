//
//  Extensions.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/04.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    func closeButton() -> Self {
        return makeBarButtonWithImage(imageName: "closeButton")
    }
    
    func settingButton() -> Self {
        return makeBarButtonWithImage(imageName: "setting")
    }
    
    
    func saveButton() -> Self {
        title = "保存"
        setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: ThemeColor.onMain
            ], for: .normal)
        setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: ThemeColor.onMainDisabled
            ], for: .disabled)
        return self
    }
    
    private func makeBarButtonWithImage(imageName: String) -> Self {
        image = UIImage(imageLiteralResourceName: imageName).withRenderingMode(.alwaysTemplate)
        tintColor = ThemeColor.onMain
        return self
    }
}

extension UILabel{
    func barTitle(_ title: String) -> Self {
        textColor  = ThemeColor.onMain
        font = UIFont.boldSystemFont(ofSize: 20)
        text = title
        return self
    }
}


extension UILabel {
    static func defaultLabelInsideCell() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = ThemeColor.dark054
        return label
    }
}


extension UIButton {
    static func circleShapedButton(sideLength: CGFloat) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.clipsToBounds = true
        button.frame.size = CGSize(width: sideLength, height: sideLength)
        button.layer.cornerRadius = sideLength / 2
        return button
    }
}
