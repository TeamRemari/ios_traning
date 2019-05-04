//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol SMCMP_Circular: UIView {
    func becomeCircular()
}

extension SMCMP_Circular {
    func becomeCircular() {
        if bounds.height == 0 || bounds.width == 0 {
            return
        }
        clipsToBounds = true
        let diameter: CGFloat = bounds.width > bounds.height ? bounds.height : bounds.width
        bounds.size = CGSize(width: diameter, height: diameter)
        layer.cornerRadius = CGFloat(diameter / 2)
    }
}
