//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol FeedTableViewCellPresenter {
    associatedtype CellType
    associatedtype ModelType
    var reuseIdentifier: String { get }
    func configure(_ cell: CellType, with model: ModelType) -> UITableViewCell
}
