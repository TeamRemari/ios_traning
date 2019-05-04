//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol FeedTableViewDataSource: UITableViewDataSource {
    associatedtype Presenter: FeedTableViewCellPresenter
    var presenters: [Presenter] { get set }
}
