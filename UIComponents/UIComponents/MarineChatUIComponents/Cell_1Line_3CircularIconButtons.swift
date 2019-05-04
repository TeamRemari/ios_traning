//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

final class Cell_1Line_3CircularIconButtons: LeftRight2SlotsCell {
    
    private class IconButton: UIButton, SMCMP_Circular {}
    
    private lazy var _iconLeft = IconButton()
    private lazy var _iconMiddle = IconButton()
    private lazy var _iconRight = IconButton()
    
    var iconLeft: UIButton { return _iconLeft }
    var iconMiddle: UIButton { return _iconMiddle }
    var iconRight: UIButton { return _iconRight }
    
    lazy var label: UILabel = {
        let label = UILabel().cellSubTitle
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        leftView.addSubview(label)
        [_iconLeft, _iconMiddle, _iconRight].forEach({
            rightView.addSubview($0)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame.size = CGSize(width: label.intrinsicContentSize.width, height: leftView.bounds.height)
        
        let iconSize = CGSize(width: rightView.bounds.height, height: rightView.bounds.height)
        _iconLeft.frame = CGRect(origin: .zero,
                                size: iconSize)
        _iconMiddle.frame = CGRect(origin: CGPoint(x: _iconLeft.frame.maxX + spacing, y: 0),
                                  size: iconSize)
        _iconRight.frame = CGRect(origin: CGPoint(x: _iconMiddle.frame.maxX + spacing, y: 0),
                                 size: iconSize)
        [_iconLeft, _iconMiddle, _iconRight].forEach({$0.becomeCircular()})
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
