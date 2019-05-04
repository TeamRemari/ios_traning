//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatCopyAppEngine

final class AppLaunchFlowTests: XCTestCase {
    
    func test_Start_WhenAccessTokenIsLoaded_LoadDataUsingTheToken() {
        let token = FakeAccessToken(value: "Foo")
        let tokenLoader: FakeAccessTokenLoader = {
            return .hasAccessToken(token)
        }
        var dataLoaderSpy: FakeAccessToken? = nil
        makeSUT(accessTokenLoader: tokenLoader,
                dataLoader: { (tokenState, _) in
                    switch tokenState {
                    case .hasAccessToken(let token):
                        dataLoaderSpy = token
                    default:
                        return
                    }}).start()

        XCTAssertEqual(dataLoaderSpy?.value, "Foo")
    }

    func test_Start_WhenUserIsNotRegistered_RendersTheState() {
        var rendererSpyCount = 0
        let rendererSpy: FakeRootViewRenderer = {
            (userState) in
            if case UserState<FakeUserModel>.notRegistered = userState {
                rendererSpyCount += 1
            }
        }
        makeSUT(rootViewRenderer: rendererSpy).start()
        XCTAssertEqual(rendererSpyCount, 1)
    }
    
    func test_Start_WhenUserIsRegistered_RendersTheState() {
        let fakeTokenLoader: FakeAccessTokenLoader = {
            return .hasAccessToken(FakeAccessToken(value: "Foo"))
        }
        let fakeDataLoader: FakeDataLoader = { (token, renderer) in
            switch token {
            case .hasAccessToken(let token):
                if token.value == "Foo" {
                    renderer(.registered(FakeUserModel()))
                } else { renderer(.notRegistered) }
            case .none:
                renderer(.notRegistered)
            }
        }
        var unregisteredCount = 0
        var registeredCount = 0
        let rendererSpy: FakeRootViewRenderer = {
            (userState) in
            if case UserState<FakeUserModel>.notRegistered = userState {
                unregisteredCount += 1
            }
            if case UserState<FakeUserModel>.registered(_) = userState {
                registeredCount += 1
            }
        }
        makeSUT(accessTokenLoader: fakeTokenLoader,
                dataLoader: fakeDataLoader,
                rootViewRenderer: rendererSpy).start()
        XCTAssertEqual(unregisteredCount, 0)
        XCTAssertEqual(registeredCount, 1)
    }
    
    // MARK: Helper
    
    typealias FakeAccessTokenLoader = () -> AccessTokenState<FakeAccessToken>
    typealias FakeRootViewRenderer = (UserState<FakeUserModel>) -> Void
    typealias FakeDataLoader = (AccessTokenState<FakeAccessToken>, FakeRootViewRenderer) -> Void
    
    func makeSUT(accessTokenLoader: @escaping FakeAccessTokenLoader = {
        return .none},
                 dataLoader: @escaping FakeDataLoader = {
                    (tokenState, completion) in
                    switch tokenState {
                    case .hasAccessToken(_):
                        completion(.registered(FakeUserModel()))
                    case .none:
                        completion(.notRegistered)
                    }
                 },
                 rootViewRenderer: @escaping FakeRootViewRenderer = { _ in}) -> AppLaunchFlow<FakeAccessToken, FakeUserModel> {
        return AppLaunchFlow<FakeAccessToken, FakeUserModel>(accessTokenLoader: accessTokenLoader, dataLoader: dataLoader,rootViewRenderer: rootViewRenderer)
    }
    
    struct FakeUserModel {}
    
    struct FakeAccessToken {
        var value = ""
    }

}
