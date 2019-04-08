//
//  ViewController.swift
//  MarineChatUI
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

private typealias CellsDelegate =
    ProfileImageCellDelegate & NickNameCellDelegate &
    GenderCellDelegate & AgeCellDelegate &
    LocationCellDelegate & BioCellDelegate

final class ViewController: UITableViewController {
    
    private var userProfileInfo = UserProfileInfo() {
        didSet {
            checkIfUserProfileInfoIsCompleted()
        }
    }
    
    private let closeButton = UIBarButtonItem().closeButton()
    private let saveButton = UIBarButtonItem().saveButton()
    
    private let sectionNames = ["情報","自己紹介"]
    
    private lazy var infoCells: [UITableViewCell] = [{
            let cell = ProfileImageCell()
            cell.delegate = self
            return cell
        }(), {
            let cell = NicknameCell()
            cell.delegate = self
            return cell
        }(), {
            let cell = GenderCell()
            cell.delegate = self
            return cell
        }(), {
            let cell = AgeCell()
            cell.delegate = self
            return cell
        }(), {
            let cell = LocationCell()
            cell.delegate = self
            return cell
        }()]
    private lazy var bioCell: UITableViewCell = {
        let cell = BioCell()
        cell.delegate = self
        return cell
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.allowsEditing = true
        ip.delegate = self
        return ip
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserProfileInfoIsCompleted()
        setupNavBar()
        setupTableView()
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
            return bioCell
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
    
    private func checkIfUserProfileInfoIsCompleted() {
        let containsNil = Mirror(reflecting: userProfileInfo).children.contains(where: {
            if case Optional<Any>.none = $0.value  {
                return true
            } else {
                return false
            }
        })
        saveButton.isEnabled = !containsNil
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.titleView = UILabel().barTitle()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = ThemeColor.background
        tableView.allowsSelection = false
    }
    
    private func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func endEditing() {
        tableView.endEditing(true)
    }
}


// Implements all cells delegate methods

extension ViewController: CellsDelegate {
    
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
    
    func ageDidSet(age: Int) {
        userProfileInfo.age = age
    }
    
    func bioDidSet(_ bio: String) {
        if bio == "" {
            userProfileInfo.bio = nil
        } else {
            userProfileInfo.bio = bio
        }
    }
    
    func locationDidSet(_ location: String) {
        userProfileInfo.location = location
    }
    
    func nickNameDidChange(with nickName: String) {
        if nickName == "" {
            userProfileInfo.nickName = nil
        } else {
            userProfileInfo.nickName = nickName
        }
    }
    
    func genderIsSelected(_ gender: GenderCell.Gender) {
        switch gender {
        case .male:
            userProfileInfo.gender = "male"
        case .female:
            userProfileInfo.gender = "female"
        case .notSelected:
            userProfileInfo.gender = nil
        }
    }
}

// UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let profileImageCell = infoCells[0] as? ProfileImageCell {
                profileImageCell.setProfileImage(image)
                
                userProfileInfo.profileImage = image.jpegData(compressionQuality: 0.5)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
