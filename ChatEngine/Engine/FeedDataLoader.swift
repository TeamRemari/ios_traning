//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

public protocol FeedDataLoader {
    associatedtype FeedItemModel
    
    func loadFeed() -> Future<[FeedItemModel]>
}
