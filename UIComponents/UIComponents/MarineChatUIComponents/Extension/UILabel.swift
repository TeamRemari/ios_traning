//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

extension UILabel: FontManager, ColorManager {
    var cellTitle1: UILabel {
        let label = UILabel()
        label.font = h5
        label.textColor = dark_087
        return label
    }
    
    var cellTitle2: UILabel {
        let label = UILabel()
        label.font = h6
        label.textColor = dark_087
        return label
    }
    
    var cellSubTitle: UILabel {
        let label = UILabel()
        label.font = body1
        label.textColor = dark_054
        return label
    }
    
    var cellBody: UILabel {
        let label = UILabel()
        label.font = body2
        label.textColor = dark_087
        return label
    }
    
    var cellButtonOnSurface: UILabel {
        let label = UILabel()
        label.font = button
        label.textColor = dark_054
        return label
    }
    
    var cellButtonOnPrimary: UILabel {
        let label = UILabel()
        label.font = button
        label.textColor = onPrimary
        return label
    }
    
    var cellCaption: UILabel {
        let label = UILabel()
        label.font = caption
        label.textColor = dark_026
        return label
    }
}
