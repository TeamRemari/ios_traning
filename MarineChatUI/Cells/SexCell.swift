//
//  SexCell.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class SexCell: UITableViewCell {
    
    private var selectedSex: Sex = .notSelected
    
    private let sexLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.text = "性別"
        return label
    }()
    
    let sexButtons: [Sex : UIButton] = [
        .male : UIButton.circleShapedButton(sideLength: Length.diameterLarge),
        .female : UIButton.circleShapedButton(sideLength: Length.diameterLarge),
        .notSelected : UIButton.circleShapedButton(sideLength: Length.diameterLarge)
    ]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sexLabel.frame.size = sexLabel.intrinsicContentSize
        sexLabel.center.y = contentView.center.y
        sexLabel.frame.origin.x = Length.horizontalPadding
        
        sexButtons.forEach({
            $0.value.center.y = contentView.center.y
        })
        
        sexButtons[.notSelected]!.frame.origin.x = sexLabel.frame.maxX + Length.spacingLarge
        sexButtons[.male]!.frame.origin.x = sexButtons[.notSelected]!.frame.maxX + Length.spacingLarge
        sexButtons[.female]!.frame.origin.x = sexButtons[.male]!.frame.maxX + Length.spacingLarge
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sexButtons.forEach({
            if $0.key == selectedSex {
                addBorder(to: $0.value)
            }
            $0.value.layer.borderColor = UIColor(red: 136/255, green: 214/255, blue: 1, alpha: 1).cgColor
            $0.value.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        })
        setupColorOfButtons()
        
        contentView.addSubview(sexLabel)
        
        sexButtons.forEach({
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
        guard let tappedSex = sexButtons.first(where: {
            $1 === sender
        })?.key else { return }
        addBorder(to: sender)
        selectedSex = tappedSex
        sexButtons.forEach({
            if $0.key != selectedSex {
                removeBorder(of: $0.value)
            }
        })
    }
    
    private func setupColorOfButtons() {
        sexButtons.forEach {
            if $0.key == .male {
                $0.value.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
            } else if $0.key == .female {
                $0.value.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SexCell {
    enum Sex {
        case male, female, notSelected
    }
}
