//
//  NodeTests.swift
//  SinglyLinkedListTests
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class NodeTests: XCTestCase {

    // MARK: - Methods

    func testType() {
        XCTAssertTrue(type(of: Node(payload: 1)) == type(of: Node(payload: 2)))
        XCTAssertTrue(type(of: Node(payload: 1)) != type(of: Node(payload: "2")))
    }

    func testPayload() {
        let intPayload = 0
        let intNode = Node(payload: intPayload)
        XCTAssertEqual(intNode.payload, intPayload, "An unexpected Int payload value.")

        let stringPayload = "Payload"
        let stringNode = Node(payload: stringPayload)
        XCTAssertEqual(stringNode.payload, stringPayload, "An unexpected String payload value.")
    }

    func testNextNode() {
        let nodeWithoutNext = Node(payload: 0)
        XCTAssertNil(nodeWithoutNext.nextNode, "A next node reference unexpectedly exists.")

        let nodeWithNext = Node(payload: 1, nextNode: nodeWithoutNext)
        XCTAssertTrue(nodeWithNext.nextNode === nodeWithoutNext, "A next node reference has an unexpected value.")

        nodeWithNext.nextNode = nil
        XCTAssertNil(nodeWithNext.nextNode, "A next node reference unexpectedly exists.")
    }

}
