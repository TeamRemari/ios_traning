//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

protocol DataLoadingService {
    associatedtype Query
    func loadObjects<T>(matching query: Query) -> [T]?
    func loadObject<T>(withID id: String) -> T?
}

protocol DataSavingService {
    func save<T>(_ object: T)
}

typealias DatabaseManager = DataLoadingService & DataSavingService
