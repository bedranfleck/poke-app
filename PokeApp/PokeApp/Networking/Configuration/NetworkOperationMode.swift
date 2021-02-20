//
//  NetworkOperationMode.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Foundation

enum NetworkOperationMode {
    case normal
    case stubResponse
    case stubWithDelay(delay : TimeInterval)
    case stubWithError(statusCode: Int?, data: Data?)
    
    static func fromString(type: String) -> NetworkOperationMode {
        switch type {
        case "stub":
            return .stubResponse
        case "normal":
            return .normal
        case "stubDelay":
            return .stubWithDelay(delay: 0.5)
        case "stubWithError":
            return .stubWithError(statusCode: 500, data: nil)
        default:
            return .normal
        }
    }
    
    static func currentOperationMode() -> NetworkOperationMode {
        if Environment.isRunningUnitTests() {
            return .stubResponse
        } else {
            return .normal
        }
    }
    
    func toString() -> String {
        switch self {
        case .stubResponse:
            return "stub"
        case .normal:
            return "normal"
        case .stubWithDelay:
            return "stubDelay"
        case .stubWithError:
            return "stubWithError"
        }
    }
    
}

extension NetworkOperationMode: Equatable {
    static func == (lhs: NetworkOperationMode, rhs: NetworkOperationMode) -> Bool {
        switch (lhs, rhs) {
        case (let .stubWithDelay(leftDelay), let .stubWithDelay(rightDelay)):
            return leftDelay == rightDelay
        case (let .stubWithError(leftCode, leftData), let .stubWithError(rightCode, rightData)):
            return leftCode == rightCode && leftData == rightData
        case (.stubResponse, .stubResponse), (.normal, .normal):
            return true
        default:
            return false
        }
    }
}
