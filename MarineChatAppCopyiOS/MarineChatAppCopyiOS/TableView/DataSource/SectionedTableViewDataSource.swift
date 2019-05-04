//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class SectionedTableViewDataSource: NSObject {
    private var dataSources = [UITableViewDataSource]()
    
    convenience init(dataSources: [UITableViewDataSource]) {
        self.init()
        self.dataSources = dataSources
    }
}

extension SectionedTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataSources.count > section else {
            return 0
        }
        let dataSource = dataSources[section]
        return dataSource.tableView(tableView, numberOfRowsInSection: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        guard dataSources.count > section else {
            return UITableViewCell()
        }
        let dataSource = dataSources[section]
        return dataSource.tableView(tableView, cellForRowAt: IndexPath(row: indexPath.row, section: 0))
    }
}
