//
//  BioCell.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/04.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol BioCellDelegate: AnyObject {
    func bioDidSet(_ bio: String)
}

final class BioCell: UITableViewCell {
    weak var delegate: BioCellDelegate?
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = ThemeColor.dark012.cgColor
        tv.layer.borderWidth = 1
        tv.tintColor = ThemeColor.main
        return tv
    }()
    
    private let maxWordCount = 100
    
    private let blankTextViewPlaceHolder = "どんな人？"
    
    private lazy var countLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.textAlignment = .right
        label.text = "\(maxWordCount)/\(maxWordCount)"
        return label
    }()
    
    override func layoutSubviews() {
        layoutTextView()
        layoutCountLabel()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textView.delegate = self
        [textView, countLabel].forEach({
            contentView.addSubview($0)
        })
        textViewIsBlank()
    }
    
    private func textViewIsBlank() {
        textView.text = blankTextViewPlaceHolder
        textView.textColor = ThemeColor.dark026
        countLabel.text = "0/\(maxWordCount)"
    }
    
    private func layoutTextView() {
        textView.frame = CGRect(x: Length.horizontalPadding, y: Length.verticalPadding, width: contentView.bounds.width - Length.horizontalPadding * 2, height: 250)
    }
    
    private func layoutCountLabel() {
        countLabel.frame = CGRect(origin: .init(x: textView.frame.maxX - countLabel.intrinsicContentSize.width - Length.horizontalPadding, y: textView.frame.maxY + Length.spacingSmall), size: .init(width: countLabel.intrinsicContentSize.width + Length.horizontalPadding, height: countLabel.intrinsicContentSize.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BioCell: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let wordCount = textView.text.count
        countLabel.text = "\(wordCount)/\(maxWordCount)"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == blankTextViewPlaceHolder {
            textView.text = ""
            textView.textColor = ThemeColor.dark087
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.bioDidSet(textView.text)
        if textView.text.count == 0 {
            textViewIsBlank()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard textView.text != nil && range.lowerBound < maxWordCount else {
            return false
        }
        return true
    }
}
