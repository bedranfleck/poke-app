//
//  BaseAPI.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Moya

class BaseService<T: TargetType> {
    internal var provider: MoyaProvider<T>
    
    /// Allows the application to run network operations with mock data when running tests without further configuration on test files.
    /// - Parameter operationMode: current operation mode. `stubResponse` is used when running Unit tests. Other stub options may be used optionally.
    init(operationMode: NetworkOperationMode = NetworkOperationMode.currentOperationMode()) {
        switch operationMode {
        case .normal:
            provider = MoyaProvider<T>(plugins: [NetworkLoggerPlugin(verbose: true)])
        case .stubResponse:
            provider = MoyaProvider<T>(stubClosure: {(_: T) -> Moya.StubBehavior in return .immediate})
        default:
            provider = MoyaProvider<T>()
        }
    }
}
