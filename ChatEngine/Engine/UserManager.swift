//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

protocol UserManager {
    associatedtype UserModelType
    associatedtype LoginMethod
    
    func register(user: UserModelType) -> Future<Bool>
    func login(using loginMethod: LoginMethod) -> Future<UserModelType>
    func logout()
    func deleteUser()
}
