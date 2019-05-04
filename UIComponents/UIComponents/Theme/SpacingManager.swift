//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol SpacingManager {
    var x_tiny: CGFloat { get }
    var tiny: CGFloat { get }
    var small: CGFloat { get }
    var base: CGFloat { get }
    var large: CGFloat { get }
    var x_large: CGFloat { get }
}

extension SpacingManager {
    var x_tiny: CGFloat { return 4 }
    var tiny: CGFloat { return 8 }
    var small: CGFloat { return 16 }
    var base: CGFloat { return 24 }
    var large: CGFloat { return 48 }
    var x_large: CGFloat { return 64 }
}
