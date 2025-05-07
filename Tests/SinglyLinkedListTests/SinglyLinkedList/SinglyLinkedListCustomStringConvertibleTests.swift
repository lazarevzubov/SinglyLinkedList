//
//  SinglyLinkedListCustomStringConvertibleTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct SinglyLinkedListCustomStringConvertibleTests {

    // MARK: - Methods

    @Test
    func customStringConvertible_whenList_isEmpty() {
        #expect(SinglyLinkedList<Int>(firstNode: nil).description == "The list has no nodes.")
    }

    @Test
    func customStringConvertible_whenList_isNotEmpty() {
        let payload0 = 0
        let node0 = SinglyLinkedListNode(payload: payload0)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1)
        node0.nextNode = node1

        let list = SinglyLinkedList(firstNode: node0)
        #expect(list.description == "The list has nodes:\n\(node0.description)\n\(node1.description)")
    }

}
