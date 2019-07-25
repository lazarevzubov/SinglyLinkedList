//
//  SinglyLinkedListCollectionTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class SinglyLinkedListCollectionTests: XCTestCase {

    // MARK: - Methods

    func testSubscript() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        
        XCTAssertEqual(list[0], firstNode)
        XCTAssertEqual(list[1], secondNode)
        XCTAssertEqual(list[2], thirdNode)
        
        // TODO: Test index out of range after improvements.
    }

    func testFormIndex() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let startingValue = 0
        let offset = 1

        var index = startingValue
        list.formIndex(&index, offsetBy: offset)
        XCTAssertEqual(index, startingValue + offset, "Resulted index value doesn't equal a sum of initial index value and offset.")
    }

    func testLimitedFormIndex() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let startingValue = 0
        let offset = 1
        let limit = 1
        var index = startingValue

        XCTAssertTrue(list.formIndex(&index, offsetBy: offset, limitedBy: limit), "Resulted index is limited by a vlue less than a passed one.")
        XCTAssertEqual(index, startingValue + offset, "Resulted index value doesn't equal a sum of initial index value and offset.")

        XCTAssertFalse(list.formIndex(&index, offsetBy: offset, limitedBy: limit), "Resulted index is limited by a vlue higher than a passed one.")
    }

    func testUnderestimatedCount() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        XCTAssertEqual(list.underestimatedCount, 3, "The list's underestimated count is different from the nodes count.")

        let emptyList = SinglyLinkedList<String>()
        XCTAssertEqual(emptyList.underestimatedCount, 0, "An empty list's underestimated count is not zero.")
    }

    func testCount() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        XCTAssertEqual(list.count, 3, "The list's count is different from the actual nodes number.")

        let emptyList = SinglyLinkedList<String>()
        XCTAssertEqual(emptyList.count, 0, "An empty list's count is not zero.")
    }

    func testEmpty() {
        let emptyList = SinglyLinkedList<Int>()
        XCTAssertTrue(emptyList.isEmpty, "Empty list is unexpectedly not empty.")

        let secondNode = Node(payload: 2)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        XCTAssertFalse(list.isEmpty, "A list with two nodes is unexpectedly not empty.")
    }

    func testFirst() {
        let emptyList = SinglyLinkedList<Int>()
        XCTAssertNil(emptyList.first, "The list initialized as empty unexpectedly has a first node.")
        
        let secondNode = Node(payload: 2)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        XCTAssertEqual(list.first, firstNode)
    }

}
