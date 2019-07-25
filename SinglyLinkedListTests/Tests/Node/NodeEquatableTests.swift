//
//  NodeEquatableTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class NodeEquatableTests: XCTestCase {

    // MARK: - Methods

    func testEqual() {
        let intPayload01 = 0
        let intNode01 = Node(payload: intPayload01)
        let intPayload02 = 0
        let intNode02 = Node(payload: intPayload02)
        XCTAssertEqual(intNode01, intNode02, "Nodes don't equal each other while their Int payloads do.")

        let intPayload1 = 1
        let intNode1 = Node(payload: intPayload1)
        XCTAssertNotEqual(intNode01, intNode1, "Nodes equal each other while their Int payloads don't.")
        XCTAssertNotEqual(intNode02, intNode1, "Nodes equal each other while their Int payloads don't.")

        let stringPayload01 = "0"
        let stringNode01 = Node(payload: stringPayload01)
        let stringPayload02 = "0"
        let stringNode02 = Node(payload: stringPayload02)
        XCTAssertEqual(stringNode01, stringNode02, "Nodes don't equal each other while their String payloads do.")

        let stringPayload1 = "1"
        let stringNode1 = Node(payload: stringPayload1)
        XCTAssertNotEqual(stringNode01, stringNode1, "Nodes equal each other while their String payloads don't.")
        XCTAssertNotEqual(stringNode02, stringNode1, "Nodes equal each other while their String payloads don't.")
    }

}
