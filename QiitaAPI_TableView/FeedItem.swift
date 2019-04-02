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
}

struct UserInfo: Decodable {
    let id: String
}
