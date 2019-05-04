//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

enum UserState<UserModelType> {
    case registered(UserModelType)
    case notRegistered
}
