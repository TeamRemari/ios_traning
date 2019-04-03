//
//  PostCell.swift
//  QiitaAPI_TableView
//
//  Created by Sho Morita on 2019/04/03.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

/*
 コメント
 
 1. UIを作ってるのに、addSubViewしてないから見えない。UITableViewCellなのでcontentViewにaddSubViewすることで表示される。contentViewにaddSubViewするタイミングはinit
 2. コードでUIを作った場合、layoutSubViewsの中でレイアウトをする。layoutSubViewsはXcodeがUIのframeを更新するタイミングだ！と思った時に呼ばれる。例えばcellの高さを呼ぶメソッドがViewControllerから呼ばれ高さが決まった時、画面が回転した時などなど。
     何回も呼ばれるので、オートレイアウトの場合はここでやっちゃダメだけど、frameの場合はここが楽
 3. userImageView.frame.origin.x + userImageView.bounds.width + 12は、userImageView.frame.maxX + 12と同義
 4. Cellなんで、boundsではなくcontentView.bounds
 5. userNameLabel.frame.origin.y + userNameLabel.bounds.height + 8は userNameLabel.frame.maxY + 8と同義
 6. layoutIfNeeded() setNeedsLayout()を呼ぶと、layoutSubViewsが呼ばれる
 */

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
    
    let tagNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    private let userImageView: UIImageView = {
        let sideLength: CGFloat = 60
        let img = UIImageView()
        img.frame.size = CGSize(width: sideLength, height: sideLength)
        img.clipsToBounds = true
        img.layer.cornerRadius = sideLength / 2
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(tagNameLabel)
        contentView.addSubview(userImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.frame.origin = CGPoint(x: contentView.bounds.origin.x + 12, y: contentView.bounds.origin.y + 12)
        userNameLabel.frame.origin = CGPoint(x: userImageView.frame.maxX + 12,
                                             y: userImageView.frame.origin.y)
        userNameLabel.frame.size.height = userNameLabel.intrinsicContentSize.height
        userNameLabel.frame.size.width = contentView.bounds.width - userNameLabel.frame.origin.x
        postTitleLabel.frame.origin = CGPoint(x: userNameLabel.frame.origin.x,
                                              y: userNameLabel.frame.maxY + 8)
        postTitleLabel.preferredMaxLayoutWidth = contentView.bounds.width - userNameLabel.frame.origin.x
        postTitleLabel.frame.size = postTitleLabel.intrinsicContentSize
        
        tagNameLabel.frame.origin = CGPoint(x: userNameLabel.frame.origin.x,
                                            y: postTitleLabel.frame.maxY)
        tagNameLabel.preferredMaxLayoutWidth = contentView.bounds.width - userNameLabel.frame.origin.x
        tagNameLabel.frame.size = postTitleLabel.intrinsicContentSize
    }
    
    func setupCell(with feedItem: FeedItem) {
        postTitleLabel.text = feedItem.title
        userNameLabel.text = feedItem.user.id
        setUserImageFromUrl(url: feedItem.user.profile_image_url)
        feedItem.tags.forEach({
            tagNameLabel.text! += $0.name + " "
        })
        layoutIfNeeded()
        setNeedsLayout()
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
    
}

