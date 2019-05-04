//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

public struct APIEndpoint {
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
}

public extension APIEndpoint {
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        return urlComponent.url
    }
}
