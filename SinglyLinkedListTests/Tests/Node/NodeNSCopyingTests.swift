//
//  NodeNSCopyingTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class NodeNSCopyingTests: XCTestCase {

    // MARK: - Methods

    func testCopy() {
        let payload2 = 2
        let node2 = Node(payload: payload2)
        let payload1 = 1
        let node1 = Node(payload: payload1, nextNode: node2)

        let node1copy = node1.copy() as? Node<Int>
        XCTAssertNotEqual(Unmanaged.passUnretained(node1).toOpaque(), Unmanaged.passUnretained(node1copy!).toOpaque())
        XCTAssertEqual(node1.payload, node1copy?.payload)
        XCTAssertNotEqual(Unmanaged.passUnretained(node1.nextNode!).toOpaque(), Unmanaged.passUnretained((node1copy?.nextNode)!).toOpaque())
        XCTAssertEqual(node1.nextNode?.payload, node1copy?.nextNode?.payload)
    }

}
