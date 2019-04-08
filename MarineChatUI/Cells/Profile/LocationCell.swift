//
//  LocationCell.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/04.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol LocationCellDelegate: AnyObject {
    func locationDidSet(_ location: String)
}

class LocationCell: UITableViewCell {
    weak var delegate: LocationCellDelegate?
    
    private let locationData: [String] = ["東京都", "大阪府", "福岡県"]
    
    private let locationLabel: UILabel = {
        let label = UILabel.defaultLabelInsideCell()
        label.text = "場所"
        return label
    }()
    
    private let picker = UIPickerView()
    
    private let textField: UITextField = {
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
        layoutLocationLabel()
        layoutTextField()
        
        if !picker.isHidden {
            layoutPickerAccessoryViewDoneButton()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPicker()
        setupTextField()
        
        [locationLabel, textField].forEach({
            contentView.addSubview($0)
        })
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
    
    private func layoutLocationLabel() {
        locationLabel.frame.origin.x = Length.horizontalPadding
        locationLabel.center.y = contentView.center.y
        locationLabel.frame.size = locationLabel.intrinsicContentSize
    }
    
    private func layoutTextField() {
        textField.frame.origin = .init(x: locationLabel.frame.maxX + Length.spacingNormal, y: locationLabel.frame.minY)
        textField.frame.size = .init(width: contentView.bounds.width - textField.frame.minX - Length.horizontalPadding, height: locationLabel.bounds.size.height)
    }
    
    private func layoutPickerAccessoryViewDoneButton() {
        pickerAccessoryViewDoneButton.frame.origin.x = contentView.bounds.width - pickerAccessoryViewDoneButton.bounds.width - Length.horizontalPadding
        pickerAccessoryViewDoneButton.center.y = textField.inputAccessoryView!.center.y
    }
    
    private func setupPicker() {
        picker.delegate = self
        picker.dataSource = self
        pickerAccessoryViewDoneButton.addTarget(self, action: #selector(donePicking), for: .touchUpInside)
    }
    
    private func setupTextField() {
        textField.inputView = picker
        textField.inputAccessoryView = makePickerAccessoryView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let location = locationData[row]
        textField.text = location
        delegate?.locationDidSet(location)
    }
}
