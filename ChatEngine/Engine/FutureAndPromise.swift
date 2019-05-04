//  Copyright © 2019 Sho Morita. All rights reserved.
//

import Foundation

public class Future<Value> {
    public typealias ResultType = Result<Value, Error>
    
    fileprivate var result: ResultType? {
        didSet {
            result.map(report)
        }
    }
    private lazy var callbacks = [(ResultType) -> Void]()
    
    public func observe(with callback: @escaping (ResultType) -> Void) {
        callbacks.append(callback)
        result.map(callback)
    }
    
    private func report(result: ResultType) {
        callbacks.forEach { $0(result) }
    }
}


public final class Promise<T>: Future<T> {
    public init(value: T? = nil) {
        super.init()
        guard let value = value else {return}
        result = ResultType.success(value)
    }

    public func resolve(with value: T) {
        result = .success(value)
    }

    public func reject(with error: Error) {
        result = .failure(error)
    }
}
