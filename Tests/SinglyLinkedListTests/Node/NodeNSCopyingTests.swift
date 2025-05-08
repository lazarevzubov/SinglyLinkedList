//
//  NodeNSCopyingTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct NodeNSCopyingTests {

    // MARK: - Methods

    @Test
    func copy_isDifferentObject() throws {
        let node = SinglyLinkedListNode(payload: 1)
        let nodeCopy = try #require(node.copy() as? SinglyLinkedListNode<Int>)

        #expect(Unmanaged.passUnretained(node).toOpaque() != Unmanaged.passUnretained(nodeCopy).toOpaque())
    }

    @Test
    func copy_hasSamePayload() throws {
        let node = SinglyLinkedListNode(payload: 1)
        let nodeCopy = try #require(node.copy() as? SinglyLinkedListNode<Int>)

        #expect(node.payload == nodeCopy.payload)
    }

    @Test
    func copyNextNode_isDifferentObject_thanOriginalNextNode() throws {
        let node1 = SinglyLinkedListNode(payload: 1)
        let node0 = SinglyLinkedListNode(payload: 0, nextNode: node1)

        let node0Copy = try #require(node0.copy() as? SinglyLinkedListNode<Int>)
        let node1Copy = try #require(node0Copy.nextNode)
        #expect(Unmanaged.passUnretained(node1).toOpaque() != Unmanaged.passUnretained(node1Copy).toOpaque())
    }

    @Test
    func copyNextNode_hasSamePayload_asOriginalNextNode() throws {
        let node1 = SinglyLinkedListNode(payload: 1)
        let node0 = SinglyLinkedListNode(payload: 0, nextNode: node1)

        let node0Copy = try #require(node0.copy() as? SinglyLinkedListNode<Int>)
        let node1Copy = try #require(node0Copy.nextNode)
        #expect(node1.payload == node1Copy.payload)
    }

}
