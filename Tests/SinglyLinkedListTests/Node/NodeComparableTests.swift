//
//  NodeComparableTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct NodeComparableTests {

    // MARK: - Methods

    @Test
    func node_withHigherPayload_more_thanNode_withLowerPayload() {
        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2)

        #expect(node1 < node2)
    }

    @Test
    func node_withLowerPayload_lower_thanNode_withHigherPayload() {
        let payload1 = 2
        let node1 = SinglyLinkedListNode(payload: payload1)

        let payload2 = 1
        let node2 = SinglyLinkedListNode(payload: payload2)

        #expect(node1 > node2)
    }

}
