//
//  NicknameCell.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class NicknameCell: UITableViewCell {
    
    private let nickNameLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.text = "ニックネーム"
        return label
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "入力してください"
        tf.textAlignment = .right
        return tf
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nickNameLabel.frame.origin.x = Length.horizontalPadding
        nickNameLabel.center.y = contentView.center.y
        nickNameLabel.frame.size = nickNameLabel.intrinsicContentSize
        textField.frame.origin = .init(x: nickNameLabel.frame.maxX + Length.spacingNormal, y: nickNameLabel.frame.minY)
        textField.frame.size = .init(width: contentView.bounds.width - textField.frame.minX - Length.horizontalPadding, height: nickNameLabel.bounds.size.height)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [nickNameLabel, textField].forEach({
            contentView.addSubview($0)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

