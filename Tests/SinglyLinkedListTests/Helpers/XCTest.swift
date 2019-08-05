//
//  XCTest.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 17.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import XCTest

// MARK: - Methods

// TODO: Think of composition.
// TODO: Think of nesting.
/**
 Check whether a specific call throws an error, raise a test fault if it occurred and executes a closure with the result of that call.
 
 Uses `XCTest`'s `XCTAssertNoThrow` macro under the hood.
 
 - Parameters:
    - expression: Expression to be checked whether it throws an error.
    - message: Commentary to present if an error was thrown.
    - file: File where this assert failed.
    - line: Line on which this assert failed.
    - validateResult: Closure to be executed if the call succeeded.
    - value: Result of the call.
 */
func assertNoThrow<T>(_ expression: @autoclosure () throws -> T,
                      _ message: String = "",
                      file: StaticString = #file,
                      line: UInt = #line,
                      also validateResult: (_ value: T) -> Void) {
    func executeAndAssignResult(_ expression: @autoclosure () throws -> T, to: inout T?) rethrows {
        to = try expression()
    }

    var result: T?
    XCTAssertNoThrow(try executeAndAssignResult(expression(), to: &result), message, file: file, line: line)
    if let r = result {
        validateResult(r)
    }
}
