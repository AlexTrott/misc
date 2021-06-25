//
//  XCBaseTestCase.swift
//  UnitTestsTests
//
//  Created by Alex Trott on 23/05/2021.
//

import XCTest
@testable import UnitTests

class XCBaseTestCase: XCTestCase {

    private(set) var category: XCTestable = .notSet

    override func setUpWithError() throws {
        try super.setUpWithError()
        try XCTSkipUnless(
            shouldExecuteTest(),
            "SKIP: Skipping Test"
        )
    }
}

private extension XCBaseTestCase {

    var executionList: NSDictionary? {
         if let path = Bundle.main.path(forResource: "TestExecutor", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
         }
        return nil
    }

    var launchArguments: [String] {
        guard let executionList = executionList else { return [] }
        guard let something = executionList["Tests"] as? [String] else { return [] }
        return something
    }

    var categoryIsSet: Bool {
        category != .notSet
    }

    var shouldExecuteFullTestSuite: Bool {
        launchArguments.contains("-fullSuite")
    }

    var shouldExcuteTestSuite: Bool {
        launchArguments.contains(category.rawValue)
    }

    func shouldExecuteTest() -> Bool {
        if !categoryIsSet { XCTFail("Test Category not set") }
        if shouldExecuteFullTestSuite { return true }
        if category.isCore { return true }
        if shouldExcuteTestSuite { return true }
        return false
    }
}
