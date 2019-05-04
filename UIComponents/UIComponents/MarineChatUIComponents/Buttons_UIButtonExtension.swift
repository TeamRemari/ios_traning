//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

extension UIButton: SMCMP_Border, SMCMP_RoundedCorner {
    var reply: UIButton {
        return makeButton(with: #imageLiteral(resourceName: "reply"), title: "返信")
    }
    
    var talk: UIButton {
        return makeButton(with: #imageLiteral(resourceName: "talk"), title: "トーク")
    }
    
    var talkWithThisUser: UIButton {
        return makeButton(with: #imageLiteral(resourceName: "talk"), title: "このユーザーとトーク", on: .primary)
    }
    
    var report: UIButton {
        return makeButton(with: #imageLiteral(resourceName: "alert"), title: "通報")
    }
    
    private func makeButton(with image: UIImage, title: String, on background: ButtonIsOn = .surface) -> UIButton {
        let button = UIButton()
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        let titleString = NSAttributedString(string: title, attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue,
             .font: UILabel().cellButtonOnSurface.font!,
             .foregroundColor: background == .surface ? UIColor().alt_040 : UIColor().onPrimary])
        button.tintColor = background == .surface ? UIColor().alt_040 : UIColor().onPrimary
        button.setAttributedTitle(titleString, for: .normal)
        if background == .surface {
            button.addBorder(color: UIColor().dark_012.cgColor, width: 1)
        } else {
            button.backgroundColor = UIColor().primary_050
        }
        button.titleEdgeInsets.left = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.frame = CGRect(origin: .zero, size: CGSize(width: button.intrinsicContentSize.width + button.titleEdgeInsets.left, height: button.intrinsicContentSize.height))
        button.roundCorner(withRadius: 4)
        return button
    }
    
    private enum ButtonIsOn {
        case surface
        case primary
    }
}
