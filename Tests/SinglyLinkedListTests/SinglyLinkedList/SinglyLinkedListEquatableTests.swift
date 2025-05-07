//
//  SinglyLinkedListEquatableTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct SinglyLinkedListEquatableTests {

    // MARK: - Methods

    @Test
    func equal_ofTwoEmptyLists_isTrue() {
        #expect(SinglyLinkedList<Int>() == SinglyLinkedList<Int>())
    }

    @Test
    func equal_ofOneEmptyList_andOneNonEmptyList_isFalse() {
        let payload = 1
        let node = SinglyLinkedListNode(payload: payload)
        let list = SinglyLinkedList(firstNode: node)

        let emptyList = SinglyLinkedList<Int>()

        #expect(list != emptyList)
    }

    @Test
    func equal_ofLists_ofEqualNodesCount_andDifferentNodesPayloads_isFalse() {
        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1)
        let list1 = SinglyLinkedList(firstNode: node1)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2)
        let list2 = SinglyLinkedList(firstNode: node2)

        #expect(list1 != list2)
    }

    @Test
    func equal_ofLists_ofEqualNodesCount_andEqualNodesPayloads_isTrue() {
        let payload = 1

        let node1 = SinglyLinkedListNode(payload: payload)
        let list1 = SinglyLinkedList(firstNode: node1)

        let node2 = SinglyLinkedListNode(payload: payload)
        let list2 = SinglyLinkedList(firstNode: node2)

        #expect(list1 == list2)
    }

    @Test
    func equal_ofLists_ofEqualNodesCount_andEqualNodesPayloads_inDifferentOrder_isFalse() {
        let payload1 = 1
        let node11 = SinglyLinkedListNode(payload: payload1)

        let payload2 = 2

        let node12 = SinglyLinkedListNode(payload: payload2)
        node11.nextNode = node12

        let list1 = SinglyLinkedList(firstNode: node11)

        let node21 = SinglyLinkedListNode(payload: payload2)

        let node22 = SinglyLinkedListNode(payload: payload1)
        node21.nextNode = node22

        let list2 = SinglyLinkedList(firstNode: node21)

        #expect(list1 != list2)
    }

}
