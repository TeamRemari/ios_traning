//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class TopBottom2SlotsView: UIView, SpacingManager {
    var topView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: topView) }
    }
    var bottomView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: bottomView) }
    }
    
    var topViewHeight: CGFloat = 100 { didSet { triggerReLayout() } }
    var spacing: CGFloat! { didSet { triggerReLayout() } }
    var padding: UIEdgeInsets! { didSet { triggerReLayout() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        padding = UIEdgeInsets(top: tiny, left: small, bottom: tiny, right: small)
        spacing = small
        
        addSubview(topView)
        addSubview(bottomView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTopView()
        layoutBottomView()
    }
    
    private func replace(_ oldView: UIView, with newView: UIView) {
        guard oldView !== newView else {return}
        oldView.removeFromSuperview()
        addSubview(newView)
        triggerReLayout()
    }
    
    private func layoutTopView() {
        topView.frame = CGRect(x: padding.left,
                               y: padding.top,
                               width: bounds.maxX - padding.left - padding.right,
                               height: topViewHeight)
    }
    
    private func layoutBottomView() {
        bottomView.frame = CGRect(x: padding.left,
                                  y: topView.frame.maxY + spacing,
                                  width: bounds.maxX - padding.left - padding.right,
                                  height: bounds.height - topView.bounds.maxY - padding.bottom)
    }
    
    private func triggerReLayout() {
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
