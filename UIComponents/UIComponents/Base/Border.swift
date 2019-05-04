//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol SMCMP_Border: UIView {
    func addBorder(color: CGColor, width: CGFloat)
}

extension SMCMP_Border {
    func addBorder(color: CGColor, width: CGFloat) {
        layer.borderColor = color
        layer.borderWidth = width
    }
}
