//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

protocol HTTPClient {
    associatedtype AccessTokenType
    func get(from endpoint: APIEndpoint)
        -> Future<Data>
    func post(parameters: [String: Any], to endpoint: APIEndpoint)
        -> Future<Data>
}
