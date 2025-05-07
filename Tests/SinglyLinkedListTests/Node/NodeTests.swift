//
//  NodeTests.swift
//  SinglyLinkedListTests
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct NodeTests {

    // MARK: - Methods

    @Test
    func payload_asCreated() {
        let payload = 0
        let node = SinglyLinkedListNode(payload: payload)

        #expect(node.payload == payload)
    }

    @Test
    func nextNode_nil_byDefault() {
        let node = SinglyLinkedListNode(payload: 0)
        #expect(node.nextNode == nil)
    }

    @Test
    func nextNode_asCreated() {
        let node1 = SinglyLinkedListNode(payload: 1)
        let node0 = SinglyLinkedListNode(payload: 0, nextNode: node1)

        #expect(node0.nextNode === node1)
    }

    @Test
    func nextNode_nil_afterRemoving() {
        let node1 = SinglyLinkedListNode(payload: 1)

        let node0 = SinglyLinkedListNode(payload: 0, nextNode: node1)
        node0.nextNode = nil

        #expect(node0.nextNode == nil)
    }

}
