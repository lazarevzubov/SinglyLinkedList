//
//  SinglyLinkedListCustomStringConvertibleTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class SinglyLinkedListCustomStringConvertibleTests: XCTestCase {

    // MARK: - Methods

    func testCustomStringConvertible() {
        var intList = SinglyLinkedList<Int>(firstNode: nil)
        XCTAssertEqual(intList.description, "The list has no nodes.", "An empty list has an unexpected description value.")

        let intPayload0 = 0
        let intNode0 = Node(payload: intPayload0)
        intList.firstNode = intNode0
        XCTAssertEqual(intList.description, "The list has nodes:\n\(intNode0.description)", "The list has an unexpected description value.")

        let intPayload1 = 1
        let intNode1 = Node(payload: intPayload1)
        intNode0.nextNode = intNode1
        XCTAssertEqual(intList.description, "The list has nodes:\n\(intNode0.description)\n\(intNode1.description)", "The list has an unexpected description value.")

        var stringList = SinglyLinkedList<String>(firstNode: nil)
        XCTAssertEqual(stringList.description, "The list has no nodes.", "An empty list has an unexpected description value.")

        let stringPayload0 = "0"
        let stringNode0 = Node(payload: stringPayload0)
        stringList.firstNode = stringNode0
        XCTAssertEqual(stringList.description, "The list has nodes:\n\(stringNode0.description)", "The list has an unexpected description value.")

        let stringPayload1 = "1"
        let stringNode1 = Node(payload: stringPayload1)
        stringNode0.nextNode = stringNode1
        XCTAssertEqual(stringList.description, "The list has nodes:\n\(stringNode0.description)\n\(stringNode1.description)", "The list has an unexpected description value.")
    }

}
