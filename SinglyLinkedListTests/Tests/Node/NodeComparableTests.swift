//
//  NodeComparableTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class NodeComparableTests: XCTestCase {

    // MARK: - Methods

    func testCompare() {
        let payload1 = 1
        let node11 = Node(payload: payload1)
        let node12 = Node(payload: payload1)
        XCTAssertFalse(node11 > node12, "Nodes with an equal payload are not equal.")
        XCTAssertFalse(node11 < node12, "Nodes with an equal payload are not equal.")

        let payload2 = 2
        let node2 = Node(payload: payload2)
        XCTAssertTrue(node11 < node2, "Nodes compare each other differently from its payload.")
    }

}
