//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

enum AccessTokenState<AccessTokenType> {
    case hasAccessToken(AccessTokenType)
    case none
}
