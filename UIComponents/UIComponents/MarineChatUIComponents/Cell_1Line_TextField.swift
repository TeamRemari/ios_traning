//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class Cell_1Line_TextField: LeftRight2SlotsCell {
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor().dark_054
        tf.textAlignment = .right
        tf.tintColor = UIColor().primary_050
        return tf
    }()
    
    lazy var label: UILabel = {
        let label = UILabel().cellSubTitle
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        leftView.addSubview(label)
        rightView.addSubview(textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame.size = CGSize(width: label.intrinsicContentSize.width,
                                     height: leftView.bounds.height)
        textField.frame = rightView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
