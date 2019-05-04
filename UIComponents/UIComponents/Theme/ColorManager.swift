//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}

protocol ColorManager {
    var dark_087: UIColor { get }
    var dark_054: UIColor { get }
    var dark_026: UIColor { get }
    var dark_012: UIColor { get }
    
    var light_100: UIColor { get }
    var light_070: UIColor { get }
    var light_030: UIColor { get }
    var light_012: UIColor { get }
    
    var primary_050: UIColor { get }
    var accent_050: UIColor { get }
    
    var background: UIColor { get }
    var surface: UIColor { get }
    
    var onPrimary: UIColor { get }
    var onPrimaryDisabled: UIColor { get }
}

extension ColorManager {
    var dark_087: UIColor { return UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.87) }
    var dark_054: UIColor { return UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.54) }
    var dark_026: UIColor { return UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.26) }
    var dark_012: UIColor { return UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.12)}
    
    var alt_040: UIColor { return UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.40) }
    
    var light_100: UIColor { return UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 1) }
    var light_070: UIColor { return UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.7) }
    var light_030: UIColor { return UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.3) }
    var light_012: UIColor { return UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.12) }
    
    var primary_050: UIColor { return UIColor.rgba(red: 136, green: 214, blue: 255, alpha: 1) }
    var accent_050: UIColor { return UIColor.rgba(red: 133, green: 254, blue: 234, alpha: 1) }
    
    var background: UIColor { return UIColor.rgba(red: 244, green: 244, blue: 244, alpha: 1) }
    var surface: UIColor { return light_100 }
    var onPrimary: UIColor { return light_100 }
    var onPrimaryDisabled: UIColor { return light_012 }
}
