//
//  PostCell.swift
//  QiitaAPI_TableView
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 1
        return label
    }()
    
    private let tagNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    private let userImageView: UIImageView = {
        let sideLength: CGFloat = 74
        let img = UIImageView()
        img.frame.size = CGSize(width: sideLength, height: sideLength)
        img.clipsToBounds = true
        img.layer.cornerRadius = sideLength / 2
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    func setupCell(with feedItem: FeedItem) {
        postTitleLabel.text = feedItem.title
        userNameLabel.text = feedItem.user.id
        setUserImageFromUrl(url: feedItem.user.profile_image_url)
        feedItem.tags.forEach({
            tagNameLabel.text! += $0.name + " "
        })
        setupSubviews()
    }
    
    private func setUserImageFromUrl(url: String) {
        guard let url = URL(string: url) else { return}
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.userImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    private func setupSubviews() {
        
        
        [postTitleLabel, userNameLabel,tagNameLabel,userImageView].forEach({addSubview($0)})
        
        userImageView.frame.origin = CGPoint(x: bounds.origin.x + 12, y: bounds.origin.y + 12)
        userNameLabel.frame.origin = CGPoint(x: userImageView.frame.origin.x + userImageView.bounds.width + 12,
                                     y: userImageView.frame.origin.y)
        userNameLabel.frame.size.height = userNameLabel.intrinsicContentSize.height
        userNameLabel.frame.size.width = bounds.width - userNameLabel.frame.origin.x
        postTitleLabel.frame.origin = CGPoint(x: userNameLabel.frame.origin.x,
                                              y: userNameLabel.frame.origin.y + userNameLabel.bounds.height + 8)
        postTitleLabel.preferredMaxLayoutWidth = bounds.width - userNameLabel.frame.origin.x
        postTitleLabel.frame.size = postTitleLabel.intrinsicContentSize
        
        tagNameLabel.frame.origin = CGPoint(x: userNameLabel.frame.origin.x,
                                            y: postTitleLabel.frame.origin.y + postTitleLabel.bounds.height)
        tagNameLabel.preferredMaxLayoutWidth = bounds.width - userNameLabel.frame.origin.x
        tagNameLabel.frame.size = postTitleLabel.intrinsicContentSize
        
    }
}

