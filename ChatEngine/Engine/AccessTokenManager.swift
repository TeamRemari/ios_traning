//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

final class AccessTokenManager<AccessTokenType> {
    typealias TokenLoader = () -> AccessTokenState<AccessTokenType>
    
    private let tokenLoader: TokenLoader
    private var loadedToken: AccessTokenType?
    
    var accessToken: AccessTokenType? {
        return loadToken()
    }
    
    init(tokenLoader: @escaping TokenLoader) {
        self.tokenLoader = tokenLoader
    }
    
    private func loadToken() -> AccessTokenType? {
        if let loadedToken = loadedToken {
            return loadedToken
        } else {
            switch tokenLoader() {
            case .hasAccessToken(let token):
                loadedToken = token
                return token
            case .none:
                return nil
            }
        }
    }
    
}
