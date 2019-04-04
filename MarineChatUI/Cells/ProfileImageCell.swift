//
//  ProfileImageCell.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol ProfileImageCellDelegate: class {
    func profileImageIsTapped(tableViewCell: ProfileImageCell)
}

class ProfileImageCell: UITableViewCell {
    
    weak var delegate: ProfileImageCellDelegate?
    
    let profileImage = UIButton.circleShapedButton(sideLength: Length.diameterNormal)
    
    private let descriptionLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.text = "プロフィール画像"
        label.frame.size = label.intrinsicContentSize
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.frame.origin.x = Length.horizontalPadding
        
        profileImage.center.y = contentView.center.y
        descriptionLabel.frame.origin.x = profileImage.frame.maxX + Length.spacingNormal
        descriptionLabel.center.y = profileImage.center.y
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImage.addTarget(self, action: #selector(profileImageIsTapped), for: .touchUpInside)
        
        [profileImage, descriptionLabel].forEach({
            contentView.addSubview($0)
        })
    }
    
    @objc private func profileImageIsTapped() {
        delegate?.profileImageIsTapped(tableViewCell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
