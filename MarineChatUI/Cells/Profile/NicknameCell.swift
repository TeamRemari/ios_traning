//
//  NicknameCell.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol NickNameCellDelegate: AnyObject {
    func nickNameDidChange(with nickName: String)
}

final class NicknameCell: UITableViewCell {
    
    weak var delegate: NickNameCellDelegate?
    
    private let nickNameLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.text = "ニックネーム"
        return label
    }()
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "入力してください"
        tf.textAlignment = .right
        tf.delegate = self
        tf.tintColor = ThemeColor.main
        return tf
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutNickNameLabel()
        layoutTextField()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [nickNameLabel, textField].forEach({
            contentView.addSubview($0)
        })
    }
    
    private func layoutNickNameLabel() {
        nickNameLabel.frame.origin.x = Length.horizontalPadding
        nickNameLabel.center.y = contentView.center.y
        nickNameLabel.frame.size = nickNameLabel.intrinsicContentSize
    }
    
    private func layoutTextField() {
        textField.frame.origin = .init(x: nickNameLabel.frame.maxX + Length.spacingNormal, y: nickNameLabel.frame.minY)
        textField.frame.size = .init(width: contentView.bounds.width - textField.frame.minX - Length.horizontalPadding, height: nickNameLabel.bounds.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NicknameCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let nickName = self.textField.text else { return }
        delegate?.nickNameDidChange(with: nickName)
    }
}

