//
//  SinglyLinkedListEquatableTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class SinglyLinkedListEquatableTests: XCTestCase {

    // MARK: - Methods

    func testEqual() {
        var list01 = SinglyLinkedList<Int>()
        var list02 = SinglyLinkedList<Int>()
        XCTAssertEqual(list01, list02, "Two empty lists aren't equal.")

        let payload01 = 1
        let node011 = Node(payload: payload01)
        list01.insertAtEnd(node011)
        XCTAssertNotEqual(list01, list02, "A non-empty list equals an empty one.")

        let node021 = Node(payload: payload01)
        list02.insertAtEnd(node021)
        XCTAssertEqual(list01, list02, "Two lists with one node each which are equal are unequal.")

        let payload02 = 2
        let node012 = Node(payload: payload02)
        list01.insertAtEnd(node012)
        XCTAssertNotEqual(list01, list02, "Two lists with different nodes count are equal.")

        let payload03 = 3
        let node022 = Node(payload: payload03)
        list02.insertAtEnd(node022)
        XCTAssertNotEqual(list01, list02, "Two lists with the same nodes count and nodes which aren't equal are equal.")

        let payload04 = 4
        let node023 = Node(payload: payload04)
        list02.insertAtEnd(node023)
        XCTAssertNotEqual(list01, list02, "Two lists with different nodes count and nodes which aren't equal are equal.")
    }

    func testOrder() {
        let payload11 = "1"
        let payload12 = "2"
        let node112 = Node(payload: payload12)
        let node111 = Node(payload: payload11, nextNode: node112)
        let list11 = SinglyLinkedList(firstNode: node111)
        let node122 = Node(payload: payload11)
        let node121 = Node(payload: payload12, nextNode: node122)
        let list12 = SinglyLinkedList(firstNode: node121)

        XCTAssertNotEqual(list11, list12, "Two lists with equal nodes in different order are equal.")
    }

}
