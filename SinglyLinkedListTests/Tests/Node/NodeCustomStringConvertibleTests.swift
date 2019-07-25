//
//  NodeCustomStringConvertibleTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class NodeCustomStringConvertibleTests: XCTestCase {

    // MARK: - Methods

    func testDescription() {
        let intPayload0 = 0
        let intNode0 = Node(payload: intPayload0)
        let intPointer0 = Unmanaged.passRetained(intNode0).toOpaque()
        XCTAssertEqual(intNode0.description, "The node \(intPointer0) has the payload \(intPayload0) and no next node.", "The node has an unexpected description value.")

        let intPayload1 = 1
        let intNode1 = Node(payload: intPayload1)
        intNode0.nextNode = intNode1
        let intPointer1 = Unmanaged.passRetained(intNode1).toOpaque()
        XCTAssertEqual(intNode0.description,
                       "The node \(intPointer0) has the payload \(intPayload0) and the next node with the payload \(intPayload1).",
                       "The node has an unexpected description value.")
        XCTAssertEqual(intNode1.description, "The node \(intPointer1) has the payload \(intPayload1) and no next node.", "The node has an unexpected description value.")

        let stringPayload0 = "0"
        let stringNode0 = Node(payload: stringPayload0)
        let stringPointer0 = Unmanaged.passRetained(stringNode0).toOpaque()
        XCTAssertEqual(stringNode0.description,
                       "The node \(stringPointer0) has the payload \(stringPayload0) and no next node.",
                       "The node has an unexpected description value.")

        let stringPayload1 = "1"
        let stringNode1 = Node(payload: stringPayload1)
        stringNode0.nextNode = stringNode1
        let stringPointer1 = Unmanaged.passRetained(stringNode1).toOpaque()
        XCTAssertEqual(stringNode0.description,
                       "The node \(stringPointer0) has the payload \(stringPayload0) and the next node with the payload \(stringPayload1).",
                       "The node has an unexpected description value.")
        XCTAssertEqual(stringNode1.description,
                       "The node \(stringPointer1) has the payload \(stringPayload1) and no next node.",
                       "The node has an unexpected description value.")
    }

}
