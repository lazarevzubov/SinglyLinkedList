//
//  NodeEquatableTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct NodeEquatableTests {

    // MARK: - Methods

    @Test
    func nodes_equal_whenPayloads_equal() {
        let payload = 1
        let node1 = SinglyLinkedListNode(payload: payload)
        let node2 = SinglyLinkedListNode(payload: payload)

        #expect(node1 == node2)
    }

    @Test
    func nodes_notEqual_whenPayloads_notEqual() {
        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2)

        #expect(node1 != node2)
    }

}
