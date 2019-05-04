//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatAppCopyiOS

class SectionedTableViewDataSourceTests: XCTestCase {
    
    func test_InitWithNoDataSources_NumberOfRowsInSection_Returns0() {
        let sut = SectionedTableViewDataSource()
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 0), 0)
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 1), 0)
    }
    
    func test_InitWith2Sources_NumberOfRowsInSection_Returns4() {
        let sut = SectionedTableViewDataSource(dataSources: [FakeDataSource(), FakeDataSource()])
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 0), 4)
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 1), 4)
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 2), 0)
    }
    
    func test_InitWithNoDataSources_RowForSection_ReturnsDefaultCell() {
        let sut = SectionedTableViewDataSource()
        XCTAssertNil(sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0)) as? FakeCell)
    }
    
    func test_InitWith2DataSources_RowForSection_ReturnsFakeCell() {
        let sut = SectionedTableViewDataSource(dataSources: [FakeDataSource(), FakeDataSource()])
        XCTAssertNotNil(sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0)) as? FakeCell)
        XCTAssertNotNil(sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 1)) as? FakeCell)
        XCTAssertNil(sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 2)) as? FakeCell)
    }
    
    // MARK: Helper
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return FakeCell()
        }
    }
    
    class FakeCell: UITableViewCell {}
}
