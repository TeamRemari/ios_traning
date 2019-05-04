//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class Vertical4SlotsCell: UITableViewCell, SpacingManager {
    var topView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: topView) }
    }
    var topMiddleView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: topMiddleView) }
    }
    var middleView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: middleView) }
    }
    var bottomView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: bottomView) }
    }
    
    private var viewWidth: CGFloat {
        return contentView.bounds.maxX - padding.left - padding.right
    }
    
    var topViewHeight: CGFloat = 80 { didSet { triggerReLayout() } }
    var topMiddleViewHeight: CGFloat = 50 { didSet { triggerReLayout() } }
    var middleViewHeight: CGFloat = 80 { didSet { triggerReLayout() } }
    var bottomViewHeight: CGFloat = 50 { didSet { triggerReLayout() } }
    var spacing: CGFloat! { didSet { triggerReLayout() } }
    var padding: UIEdgeInsets! { didSet { triggerReLayout() } }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        padding = UIEdgeInsets(top: tiny, left: small, bottom: tiny, right: small)
        spacing = small
        
        contentView.addSubview(topView)
        contentView.addSubview(topMiddleView)
        contentView.addSubview(middleView)
        contentView.addSubview(bottomView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTopView()
        layoutTopMiddleView()
        layoutMiddleView()
        layoutBottomView()
    }
    
    private func replace(_ oldView: UIView, with newView: UIView) {
        guard oldView !== newView else {return}
        oldView.removeFromSuperview()
        contentView.addSubview(newView)
        triggerReLayout()
    }
    
    private func layoutTopView() {
        topView.frame = CGRect(x: padding.left,
                               y: padding.top,
                               width: viewWidth,
                               height: topViewHeight)
    }
    
    private func layoutTopMiddleView() {
        bottomView.frame = CGRect(x: padding.left,
                                  y: topView.frame.maxY + spacing,
                                  width: viewWidth,
                                  height: topMiddleViewHeight)
    }
    
    private func layoutMiddleView() {
        bottomView.frame = CGRect(x: padding.left,
                                  y: topMiddleView.frame.maxY + spacing,
                                  width: viewWidth,
                                  height: middleViewHeight)
    }
    
    private func layoutBottomView() {
        bottomView.frame = CGRect(x: padding.left,
                                  y: middleView.frame.maxY + spacing,
                                  width: viewWidth,
                                  height: bottomViewHeight)
    }
    
    private func triggerReLayout() {
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
