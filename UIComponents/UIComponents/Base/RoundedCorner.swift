//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol SMCMP_RoundedCorner: UIView {
    func roundCorner()
    func roundCorner(withRadius radius: CGFloat)
}

extension SMCMP_RoundedCorner {
    func roundCorner() {
        if bounds.height == 0 || bounds.width == 0 {
            return
        }
        let shorterSide = bounds.width > bounds.height ? bounds.height : bounds.width
        clipsToBounds = true
        layer.cornerRadius = shorterSide / 2
    }
    
    func roundCorner(withRadius radius: CGFloat) {
        if bounds.height == 0 || bounds.width == 0 {
            return
        }
        let shorterSide = bounds.width > bounds.height ? bounds.height : bounds.width
        let maximumCornerRadius = shorterSide / 2
        guard radius <= maximumCornerRadius else { return }
        clipsToBounds = true
        layer.cornerRadius = radius
    }
}
