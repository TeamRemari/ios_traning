//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class LeftMiddleRight3SlotsView: UIView, SpacingManager{
    var leftView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: leftView) }
    }
    var middleView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: middleView) }
    }
    var rightView = UIView(frame: .zero) {
        didSet { replace(oldValue, with: rightView) }
    }
    
    private var viewHeight: CGFloat {
        return bounds.height - padding.top - padding.bottom
    }
    private var middleViewWidth: CGFloat {
        return rightView.frame.minX - leftView.frame.maxX - spacingLeft - spacingRight
    }
    
    var leftViewWidth: CGFloat = 40 { didSet { triggerReLayout() } }
    var rightViewWidth: CGFloat = 40 { didSet { triggerReLayout() } }
    
    var spacingLeft: CGFloat! { didSet { triggerReLayout() } }
    var spacingRight: CGFloat! { didSet { triggerReLayout() } }
    
    var padding: UIEdgeInsets! { didSet { triggerReLayout() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spacingLeft = small
        spacingRight = small
        padding = UIEdgeInsets(top: tiny, left: small, bottom: tiny, right: small)
        
        addSubview(leftView)
        addSubview(rightView)
        addSubview(middleView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLeftView()
        layoutRightView()
        layoutMiddleView()
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
                                height: viewHeight)
    }
    
    private func layoutRightView() {
        rightView.frame = CGRect(x: frame.maxX - rightViewWidth - padding.right,
                                 y: padding.top,
                                 width: rightViewWidth,
                                 height: viewHeight)
    }
    
    private func layoutMiddleView() {
        middleView.frame = CGRect(x: leftView.frame.maxX + spacingLeft,
                                y: padding.top,
                                width: middleViewWidth,
                                height: viewHeight)
    }
    
    private func triggerReLayout() {
        setNeedsLayout()
        layoutIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
