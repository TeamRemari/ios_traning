//
//  AgeCell.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class AgeCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    private let ageData: [Int] = Array(1...130)
    
    private let ageLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.text = "年齢"
        return label
    }()
    
    private let picker = UIPickerView()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "未設定"
        tf.textAlignment = .right
        tf.tintColor = .clear
        return tf
    }()
    
    private let pickerAccessoryViewDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("完了", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = .white
        button.sizeToFit()
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ageLabel.frame.origin.x = Length.horizontalPadding
        ageLabel.center.y = contentView.center.y
        ageLabel.frame.size = ageLabel.intrinsicContentSize
        textField.frame.origin = .init(x: ageLabel.frame.maxX + Length.spacingNormal, y: ageLabel.frame.minY)
        textField.frame.size = .init(width: contentView.bounds.width - textField.frame.minX - Length.horizontalPadding, height: ageLabel.bounds.size.height)
        
        if !picker.isHidden {
            pickerAccessoryViewDoneButton.frame.origin.x = contentView.bounds.width - pickerAccessoryViewDoneButton.bounds.width - Length.horizontalPadding
            pickerAccessoryViewDoneButton.center.y = textField.inputAccessoryView!.center.y
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        picker.delegate = self
        picker.dataSource = self
        textField.inputView = picker
        textField.inputAccessoryView = makePickerAccessoryView()
        [ageLabel, textField].forEach({
            contentView.addSubview($0)
        })
        
        pickerAccessoryViewDoneButton.addTarget(self, action: #selector(donePicking), for: .touchUpInside)
    }
    
    @objc private func donePicking() {
        textField.endEditing(true)
    }
    
    private func makePickerAccessoryView() -> UIView {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 30)
        view.addSubview(pickerAccessoryViewDoneButton)
        pickerAccessoryViewDoneButton.frame.origin.x = contentView.bounds.width - pickerAccessoryViewDoneButton.bounds.width - Length.horizontalPadding
        pickerAccessoryViewDoneButton.center.y = view.center.y
        return view
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(ageData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = String(ageData[row])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
