//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

final class AppLaunchFlow<AccessTokenType, UserModelType> {
    typealias AccessTokenLoader = () -> AccessTokenState<AccessTokenType>
    typealias RootViewRenderer = (UserState<UserModelType>) -> Void
    typealias DataLoader = (AccessTokenState<AccessTokenType>, RootViewRenderer) -> Void
    
    private let accessTokenLoader: AccessTokenLoader
    private let dataLoader: DataLoader
    private let rootViewRenderer: RootViewRenderer
    
    init(accessTokenLoader: @escaping AccessTokenLoader,
         dataLoader: @escaping DataLoader,
         rootViewRenderer: @escaping RootViewRenderer) {
        self.accessTokenLoader = accessTokenLoader
        self.dataLoader = dataLoader
        self.rootViewRenderer = rootViewRenderer
    }
    
    func start() {
        let accessTokenState = accessTokenLoader()
        dataLoader(accessTokenState, rootViewRenderer)
    }
}
