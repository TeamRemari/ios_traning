//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

protocol FontManager {
    var h1: UIFont { get }
    var h2: UIFont { get }
    var h3: UIFont { get }
    var h4: UIFont { get }
    var h5: UIFont { get }
    var h6: UIFont { get }
    var subtitle1: UIFont { get }
    var subtitle2: UIFont { get }
    var body1: UIFont { get }
    var body2: UIFont { get }
    var button: UIFont { get }
    var caption: UIFont { get }
    var overline: UIFont { get }
}

extension FontManager {
    var h1: UIFont { return UIFont.systemFont(ofSize: 96) }
    var h2: UIFont { return UIFont.systemFont(ofSize: 60) }
    var h3: UIFont { return UIFont.systemFont(ofSize: 48) }
    var h4: UIFont { return UIFont.systemFont(ofSize: 34) }
    var h5: UIFont { return UIFont.systemFont(ofSize: 24) }
    var h6: UIFont { return UIFont.systemFont(ofSize: 20) }
    var subtitle1: UIFont { return UIFont.systemFont(ofSize: 16) }
    var subtitle2: UIFont { return UIFont.systemFont(ofSize: 14) }
    var body1: UIFont { return UIFont.systemFont(ofSize: 16) }
    var body2: UIFont { return UIFont.systemFont(ofSize: 14) }
    var button: UIFont { return UIFont.boldSystemFont(ofSize: 16) }
    var caption: UIFont { return UIFont.systemFont(ofSize: 12) }
    var overline: UIFont { return UIFont.systemFont(ofSize: 10) }
}
