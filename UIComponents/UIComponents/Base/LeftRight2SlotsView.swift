//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class LeftRight2SlotsView: UIView, SpacingManager {
    var leftView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: leftView) }
    }
    var rightView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: rightView) }
    }
    
    var leftViewWidth: CGFloat = 40 { didSet { triggerReLayout() } }
    
    var spacing: CGFloat! { didSet { triggerReLayout() } }
    
    var padding: UIEdgeInsets! { didSet { triggerReLayout() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spacing = small
        padding = UIEdgeInsets(top: tiny, left: small, bottom: tiny, right: small)
        
        addSubview(leftView)
        addSubview(rightView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLeftView()
        layoutRightView()
    }
    
    private func replace(_ oldView: UIView, with newView: UIView) {
        guard oldView !== newView else {return}
        oldView.removeFromSuperview()
        addSubview(newView)
        triggerReLayout()
    }
    
    private func layoutLeftView() {
        leftView.frame = CGRect(x: padding.left,
                                y: padding.top,
                                width: leftViewWidth,
                                height: bounds.height - padding.top - padding.bottom)
    }
    
    private func layoutRightView() {
        rightView.frame = CGRect(x: leftView.frame.maxX + spacing,
                                 y: padding.top,
                                 width: bounds.maxX - leftView.frame.maxX - spacing - padding.right,
                                 height: bounds.height - padding.top - padding.bottom)
    }
    
    private func triggerReLayout() {
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
