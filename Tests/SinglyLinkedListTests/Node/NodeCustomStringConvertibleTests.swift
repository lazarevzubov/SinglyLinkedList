//
//  NodeCustomStringConvertibleTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct NodeCustomStringConvertibleTests {

    // MARK: - Methods

    @Test
    func description_withPayload_andNoNextNode() {
        let payload = 0
        let node = SinglyLinkedListNode(payload: payload)

        let pointer = Unmanaged.passRetained(node).toOpaque()
        #expect(node.description == "The node \(pointer) has the payload of \(payload) and no next node.")
    }

    @Test
    func description_withPayload_andNextNode() {
        let payload0 = 0
        let node0 = SinglyLinkedListNode(payload: payload0)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1)
        node0.nextNode = node1

        let pointer = Unmanaged.passRetained(node0).toOpaque()
        #expect(
            node0.description 
                == "The node \(pointer) has the payload of \(payload0) and the next node with the payload of \(payload1)."
        )
    }

}
