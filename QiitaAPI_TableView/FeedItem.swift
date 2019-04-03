//
//  ItemsFeed.swift
//  QiitaAPI_TableView
//
//  Created by Sho Morita on 2019/04/02.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

struct FeedItem: Decodable {
    let title: String
    let user: UserInfo
    let tags: [Tag]
    
    struct UserInfo: Decodable {
        let id: String
        let profile_image_url: String
    }
    
    struct Tag: Decodable {
        let name: String
    }
}
