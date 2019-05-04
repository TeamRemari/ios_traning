//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatCopyAppEngine

final class UserRegistrationFlowTests: XCTestCase {
    
    let uploaderSpy = UserUploaderSpy()
    let databaseSpy = DatabaseSpy()
    
    func test_Start_RegistersUserUsingTheUserModel() {
        makeSUT(userName: "Foo").start()
        XCTAssertEqual(uploaderSpy.userNameSpy, "Foo")
    }
    
    func test_Start_WhenRegistrationFails_DoesNotSaveAnythingToDatabase() {
        makeSUT().start()
        uploaderSpy.promise.reject(with: FakeError())
        XCTAssertEqual(databaseSpy.savedCount, 0)
        XCTAssertNil(databaseSpy.accessTokenSpy)
    }
    
    func test_Start_WhenRegistrationSuceeds_SaveAccessTokenToDatabase() {
        let fakeAccesstoken = "fakeAccessToken"
        makeSUT().start()
        uploaderSpy.promise.resolve(with: fakeAccesstoken)
        XCTAssertEqual(databaseSpy.savedCount, 1)
        XCTAssertEqual(databaseSpy.accessTokenSpy, fakeAccesstoken)
    }

    // MARK: Helper
    
    private func makeSUT(userName: String = "") -> UserRegistrationFlow<FakeUserModel, UserUploaderSpy, String> {
        let fakeUser = FakeUserModel(name: userName)
        return UserRegistrationFlow(user: fakeUser, uploader: uploaderSpy, dataSavingService: databaseSpy)
    }
    
    class DatabaseSpy: DataSavingService {
        var accessTokenSpy: String?
        var savedCount = 0
        
        func save<T>(_ object: T) {
            accessTokenSpy = object as? String
            savedCount += 1
        }
    }
    
    class UserUploaderSpy: UserInfoUploader {
        var userNameSpy: String?
        var promise = Promise<String>()
        func upload(_ user: FakeUserModel) -> Future<String> {
            userNameSpy = user.name
            return promise
        }
    }
    
    struct FakeQuery {}
    
    struct FakeUserModel {
        var name = ""
    }
    
    struct FakeError: Error {}
}
