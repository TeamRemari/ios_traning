//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

final class UserRegistrationFlow<UserModelType, Uploader: UserInfoUploader, AccessTokenType> where UserModelType == Uploader.UserModelType,
    AccessTokenType == Uploader.AccessTokenType{
    
    private let user: UserModelType
    private let uploader: Uploader
    private let dataSavingService: DataSavingService
    
    init(user: UserModelType,
         uploader: Uploader,
         dataSavingService:DataSavingService) {
        self.user = user
        self.uploader = uploader
        self.dataSavingService = dataSavingService
    }
    
    func start() {
        uploader.upload(user).observe { (result) in
            switch result {
            case .success(let token):
                self.dataSavingService.save(token)
            case .failure(_):
                return
            }
        }
    }
}
