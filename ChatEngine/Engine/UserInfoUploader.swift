//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

protocol UserInfoUploader {
    associatedtype UserModelType
    associatedtype AccessTokenType
    func upload(_ user: UserModelType) -> Future<AccessTokenType>
}
