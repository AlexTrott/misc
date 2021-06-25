//
//  Features.swift
//  UnitTestsTests
//
//  Created by Alex Trott on 23/05/2021.
//

import Foundation

enum XCTestable: String {

    case registration
    case login

    case feature1
    case feature2
    case feature3

    case notSet

    var isCore: Bool {
        switch self {
        case .registration, .login:
            return true
        default:
            return false
        }
    }

    var testName: String {
        return "testable;\(self.rawValue)"
    }
}
