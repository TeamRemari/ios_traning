//
//  GenderCell.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol GenderCellDelegate: AnyObject {
    func genderIsSelected(_ gender: GenderCell.Gender)
}

final class GenderCell: UITableViewCell {
    weak var delegate: GenderCellDelegate?
    
    private var selectedGender: Gender = .notSelected {
        didSet {
            if selectedGender != .notSelected {
                delegate?.genderIsSelected(selectedGender)
            }
        }
    }
    
    private let genderLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.text = "性別"
        return label
    }()
    
    private let genderButtons: [Gender : UIButton] = [
        .male : UIButton.circleShapedButton(sideLength: Length.diameterLarge),
        .female : UIButton.circleShapedButton(sideLength: Length.diameterLarge),
        .notSelected : UIButton.circleShapedButton(sideLength: Length.diameterLarge)
    ]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutGenderLabel()
        
        layoutGenderButtons()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupGenderButtons()
        setupColorOfButtons()
        
        contentView.addSubview(genderLabel)
        
        genderButtons.forEach({
            contentView.addSubview($0.value)
        })
    }
    
    private func addBorder(to button: UIButton) {
        button.layer.borderWidth = 2
    }
    
    private func removeBorder(of button: UIButton) {
        button.layer.borderWidth = 0
    }
    
    @objc private func handleButtonTap(_ sender: UIButton) {
        guard let tappedGender = genderButtons.first(where: {
            $1 === sender
        })?.key else { return }
        addBorder(to: sender)
        selectedGender = tappedGender
        genderButtons.forEach({
            if $0.key != selectedGender {
                removeBorder(of: $0.value)
            }
        })
    }
    
    private func setupColorOfButtons() {
        genderButtons.forEach {
            if $0.key == .male {
                $0.value.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
            } else if $0.key == .female {
                $0.value.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1)
            }
        }
    }
    
    private func layoutGenderLabel() {
        genderLabel.frame.size = genderLabel.intrinsicContentSize
        genderLabel.center.y = contentView.center.y
        genderLabel.frame.origin.x = Length.horizontalPadding
    }
    
    private func layoutGenderButtons() {
        genderButtons.forEach({
            $0.value.center.y = contentView.center.y
        })
        
        genderButtons[.notSelected]!.frame.origin.x = genderLabel.frame.maxX + Length.spacingLarge
        genderButtons[.male]!.frame.origin.x = genderButtons[.notSelected]!.frame.maxX + Length.spacingLarge
        genderButtons[.female]!.frame.origin.x = genderButtons[.male]!.frame.maxX + Length.spacingLarge
    }
    
    private func setupGenderButtons() {
        genderButtons.forEach({
            if $0.key == selectedGender {
                addBorder(to: $0.value)
            }
            $0.value.layer.borderColor = ThemeColor.main.cgColor
            $0.value.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GenderCell {
    enum Gender {
        case male, female, notSelected
    }
}
