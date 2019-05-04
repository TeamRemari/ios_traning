//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class Cell_Vertical_TextField_1Line: TopBottom2SlotsCell{
    
    private class BorderTextView: UITextView, SMCMP_Border {}
    
    lazy var textView: UITextView = {
        let tf = BorderTextView()
        tf.tintColor = UIColor().primary_050
        tf.addBorder(color: UIColor().dark_012.cgColor, width: 1)
        return tf
    }()
    
    lazy var label: UILabel = {
        let label = UILabel().cellCaption
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        padding.top = small
        topViewHeight = 80
        spacing = x_tiny
        
        topView.addSubview(textView)
        bottomView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = topView.bounds
        label.frame = bottomView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
