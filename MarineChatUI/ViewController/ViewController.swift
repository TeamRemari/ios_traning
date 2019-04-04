//
//  ViewController.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let closeButton = UIBarButtonItem().closeButton()
    private let saveButton = UIBarButtonItem().saveButton()
    
    private let sectionNames = ["情報","自己紹介"]
    
    private let infoCells = [ProfileImageCell(), NicknameCell(), SexCell(), AgeCell(), LocationCell()]
    private let introCell = IntroCell()
    
    private lazy var imagePicker: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.allowsEditing = true
        ip.delegate = self
        return ip
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        setupNavBar()
        setupTableView()
        setProfileImageCellDelegate()
        addTapGestureRecognizer()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return infoCells.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return infoCells[indexPath.row]
        } else {
            return introCell
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = ThemeColor.dark054
        label.text = sectionNames[section]
        
        let containerView = UIView()
        containerView.frame.size = CGSize(width: tableView.frame.width, height: label.intrinsicContentSize.height + Length.verticalPadding)
        containerView.addSubview(label)
        
        label.frame.origin.x = containerView.bounds.minX + Length.horizontalPadding
        label.center.y = containerView.center.y
        label.frame.size = label.intrinsicContentSize
        
        return containerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 64
        } else {
            return 300
        }
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.titleView = UILabel().barTitle()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    }
    
    private func setProfileImageCellDelegate() {
        guard let profileImageCell = infoCells[0] as? ProfileImageCell else {return}
        profileImageCell.delegate = self
    }
    
    private func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func endEditing() {
        tableView.endEditing(true)
    }
}

// ProfileImageCellDelegate

extension ViewController: ProfileImageCellDelegate {
    func profileImageIsTapped(tableViewCell: ProfileImageCell) {
        let actionSheet = UIAlertController(title: "画像選択時の注意", message: "卑猥な画像を設定した場合、所定の処置を行います。", preferredStyle: .actionSheet)
        actionSheet.addAction(
            UIAlertAction(title: "写真を撮影", style: .default, handler: { [weak self] (_) in
                self?.imagePicker.sourceType = .camera
                self?.present(self!.imagePicker, animated: true, completion: nil)
            })
        )
        actionSheet.addAction(
            UIAlertAction(title: "アルバムから選択", style: .default, handler: { [weak self] (_) in
                self?.imagePicker.sourceType = .photoLibrary
                self?.present(self!.imagePicker, animated: true, completion: nil)
            })
        )
        actionSheet.addAction(
            UIAlertAction(title: "キャンセル", style: .cancel, handler: { (_) in
                actionSheet.dismiss(animated: true, completion: nil)
            })
        )
        present(actionSheet, animated: true, completion: nil)
    }
}

// UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let profileImageCell = infoCells[0] as? ProfileImageCell {
                profileImageCell.profileImage.setImage(image, for: .normal)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
