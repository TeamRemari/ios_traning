//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class Cell_CircularIconButton_1line: LeftRight2SlotsCell, FontManager, ColorManager {
    
    private class IconButton: UIButton, SMCMP_Circular {}
    
    private lazy var _icon = IconButton()
    
    var icon: UIButton { return _icon }
    lazy var label: UILabel = {
        let label = UILabel().cellSubTitle
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        leftView.addSubview(_icon)
        rightView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _icon.frame = leftView.bounds
        _icon.becomeCircular()
        label.frame = rightView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
