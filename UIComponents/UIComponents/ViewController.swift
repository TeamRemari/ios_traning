//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit
class ViewController: UITableViewController {

    
    let dummyCircle = UIImage()
    let dummyCircle2 = CircleUIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor().background
        tableView.register(Cell_Vertical_TextField_1Line.self, forCellReuseIdentifier: "cellID")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sut = tableView.dequeueReusableCell(withIdentifier: "cellID") as! Cell_Vertical_TextField_1Line
        sut.label.text = "100/100"
        sut.textView.text = "どんな人?"
        sut.contentView.addSubview(UIButton().talkWithThisUser)
        return sut
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}



