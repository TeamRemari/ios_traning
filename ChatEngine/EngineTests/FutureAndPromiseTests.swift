//  Copyright © 2019 Sho Morita. All rights reserved.
//

import XCTest
@testable import MarineChatCopyAppEngine

final class FutureAndPromiseTests: XCTestCase {

    func test_Observe_WhenResultIsSetAlready_ExcutesObserver() {
        var num: Int?
        let input = 1
        let promise: Promise = Promise<Int>(value: input)
        let future: Future = promise
        future.observe { (result) in
            if case Result.success(let resultNum) = result {
                num = resultNum
            }
        }
        
        XCTAssertNotNil(num)
        XCTAssertEqual(num, input)
    }
    
    func test_Observe_WhenPromiseIsResolvedAfterwards_ExcutesObserver() {
        var num: Int?
        let input = 1
        let promise: Promise = Promise<Int>()
        let future: Future = promise
        future.observe { (result) in
            if case Result.success(let resultNum) = result {
                num = resultNum
            }
        }
        promise.resolve(with: input)
        
        XCTAssertNotNil(num)
        XCTAssertEqual(num, input)
    }
    
    func test_Observe_WhenPromiseIsNotResolvedOrRejected_ObserverIsNotExcuted() {
        var num: Int?
        let promise: Promise = Promise<Int>()
        let future: Future = promise
        future.observe { (result) in
            if case Result.success(let resultNum) = result {
                num = resultNum
            }
        }
        
        XCTAssertNil(num)
    }
    
    func test_Observe_WhenPromiseIsRejectedAfterwards_ExcutesObserverWithError() {
        var outputError: Error?
        let input = FakeError()
        let promise: Promise = Promise<Int>()
        let future: Future = promise
        future.observe { (result) in
            if case Result.failure(let error) = result {
                outputError = error
            }
        }
        promise.reject(with: input)
        
        XCTAssertNotNil(outputError)
        XCTAssertTrue(outputError is FakeError)
    }
    
    func test_Observe_When3ObserversAreRegistered_CallsAllOfThem() {
        var num1: Int?
        var num2: Int?
        var num3: Int?
        let input = 1
        let promise: Promise = Promise<Int>()
        let future: Future = promise
        future.observe { (result) in
            if case Result.success(let resultNum) = result {
                num1 = resultNum
            }
        }
        future.observe { (result) in
            if case Result.success(let resultNum) = result {
                num2 = resultNum
            }
        }
        future.observe { (result) in
            if case Result.success(let resultNum) = result {
                num3 = resultNum
            }
        }
        promise.resolve(with: input)
        
        XCTAssertNotNil(num1)
        XCTAssertNotNil(num2)
        XCTAssertNotNil(num3)
        XCTAssertEqual(num1, input)
        XCTAssertEqual(num2, input)
        XCTAssertEqual(num3, input)
    }
    
    
    
    // MARK: Helper
    
    struct FakeError: Error {}
}
