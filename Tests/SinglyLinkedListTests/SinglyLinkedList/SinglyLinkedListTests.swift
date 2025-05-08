//
//  SinglyLinkedListTests.swift
//  SinglyLinkedListTests
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct SinglyLinkedListTests {

    // MARK: - Methods

    @Test
    func firstNode_isNil_inEmptyList() {
        #expect(SinglyLinkedList<Int>().firstNode == nil, "The list initialized as empty unexpectedly has a first node.")
    }

    @Test
    func firstNode_asProvided() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(list.firstNode === node1, "The list has unexpected first node reference.")
    }

    @Test
    func lastNode_isNil_inEmptyList() {
        #expect(SinglyLinkedList<Int>().lastNode() == nil, "The empty list has an existing last node.")
    }

    @Test
    func lastNode_equalFirstNode_inListWithSingleNode() {
        let node = SinglyLinkedListNode(payload: 1)
        let list = SinglyLinkedList(firstNode: node)
        #expect(
            list.firstNode === list.lastNode(), 
            "The list with a single node has different references to the first and the last nodes."
        )
    }

    @Test
    func lastNode_pointsToLastNode() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList<Int>(firstNode: node1)
        #expect(list.lastNode() === node3, "The list has an unexpected last node reference.")
    }

    @Test
    func insertAtBeginning_worksAsExpected_forEmptyList() {
        var list = SinglyLinkedList<Int>(firstNode: nil)

        let node = SinglyLinkedListNode(payload: 1)
        list.insertAtBeginning(node)

        #expect(
            list.firstNode === node,
            "The list has the first node different from the just inserted at the beginning."
        )
    }

    @Test
    func insertAtBeginning_worksAsExpected_forNonEmptyList() {
        let node = SinglyLinkedListNode(payload: 1)
        var list = SinglyLinkedList(firstNode: node)

        let newNode = SinglyLinkedListNode(payload: 2)
        list.insertAtBeginning(newNode)

        #expect(
            list.firstNode === newNode,
            "The list has the first node different from the just inserted at the beginning."
        )
        #expect(
            list.firstNode?.nextNode === node,
            "The just inserted at the beginning node's next node doesn't reference to the previous first node."
        )
    }

    @Test
    func insertAfter_worksAsExpected() {
        let node2 = SinglyLinkedListNode(payload: 2)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        let newNode = SinglyLinkedListNode(payload: 4)
        list.insert(newNode, after: node1)

        #expect(list.firstNode == node1)
        #expect(list.firstNode?.nextNode == newNode)
        #expect(newNode.nextNode == node2)
    }

    @Test
    func insertAtEnd_worksAsExpected() {
        let node1 = SinglyLinkedListNode(payload: 1)
        var list = SinglyLinkedList(firstNode: node1)

        let newNode = SinglyLinkedListNode(payload: 4)
        list.insertAtEnd(newNode)

        #expect(list.firstNode?.nextNode == newNode)
        #expect(list.lastNode() == newNode)
    }

    @Test
    func removeFirst_worksAsExpected_onEmptyList() {
        var list = SinglyLinkedList<Int>(firstNode: nil)
        list.removeFirst()

        #expect(list.isEmpty)
    }

    @Test
    func removeFirst_worksAsExpected_onOneNodeList() {
        let node = SinglyLinkedListNode(payload: 1)
        var list = SinglyLinkedList(firstNode: node)

        list.removeFirst()
        #expect(list.isEmpty)
    }

    @Test
    func removeFirst_worksAsExpected_onRegularList() {
        let node2 = SinglyLinkedListNode(payload: 2)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)
        var list = SinglyLinkedList(firstNode: node1)

        list.removeFirst()
        #expect(list.firstNode == node2)
    }

    @Test
    func removeAfter_worksAsExpected_onEmptyList() {
        let list = SinglyLinkedList<Int>(firstNode: nil)

        let node = SinglyLinkedListNode(payload: 1)
        list.remove(after: node)

        #expect(list.isEmpty)
    }

    @Test
    func removeAfter_worksAsExpected_onOneNodeList() {
        let node = SinglyLinkedListNode(payload: 1)
        let list = SinglyLinkedList(firstNode: node)

        list.remove(after: node)
        #expect(list.firstNode == node)
    }

    @Test
    func removeAfter_worksAsExpected_onRegularList() {
        let node2 = SinglyLinkedListNode(payload: 2)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        list.remove(after: node1)

        #expect(list.firstNode == node1)
        #expect(node1.nextNode == nil)
    }

    @Test
    func removeLast_worksAsExpected_onEmptyList() {
        var list = SinglyLinkedList<Int>(firstNode: nil)
        list.removeLast()

        #expect(list.isEmpty)
    }

    @Test
    func removeLast_worksAsExpected_onOneNodeList() {
        let node = SinglyLinkedListNode(payload: 1)
        var list = SinglyLinkedList(firstNode: node)

        list.removeLast()
        #expect(list.isEmpty)
    }

    @Test
    func removeLast_worksAsExpected_onRegularList() {
        let node2 = SinglyLinkedListNode(payload: 2)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)
        var list = SinglyLinkedList(firstNode: node1)

        list.removeLast()
        #expect(list.firstNode == node1)
    }

}
