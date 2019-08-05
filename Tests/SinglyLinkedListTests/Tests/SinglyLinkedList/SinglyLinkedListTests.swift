//
//  SinglyLinkedListTests.swift
//  SinglyLinkedListTests
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class SinglyLinkedListTests: XCTestCase {

    // MARK: - Methods

    func testType() {
        XCTAssertTrue(type(of: SinglyLinkedList<Int>()) == type(of: SinglyLinkedList<Int>()))
        XCTAssertTrue(type(of: SinglyLinkedList<Int>()) != type(of: SinglyLinkedList<String>()))
    }

    func testFirstNode() {
        let list1 = SinglyLinkedList<Int>()
        XCTAssertNil(list1.firstNode, "The list initialized as empty unexpectedly has a first node.")

        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list2 = SinglyLinkedList(firstNode: firstNode)
        XCTAssertTrue(list2.firstNode === firstNode, "The list has unexpected first node reference.")
    }

    func testLastNode() {
        var list = SinglyLinkedList<Int>(firstNode: nil)
        XCTAssertNil(list.lastNode(), "The empty list has an existing last node.")

        let node = SinglyLinkedListNode(payload: 1)
        list.firstNode = node
        XCTAssertTrue(list.firstNode === list.lastNode(), "The list with a single node has different references to the first and the last nodes.")

        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        list.firstNode = firstNode
        XCTAssertTrue(list.lastNode() === thirdNode, "The list has an unexpected last node reference.")
    }

    func testInsertAtBeginning() {
        var list = SinglyLinkedList<Int>(firstNode: nil)

        let node = SinglyLinkedListNode(payload: 1)
        list.insertAtBeginning(node)
        XCTAssertTrue(list.firstNode === node, "The list has the first node different from the just inserted at the beginning.")

        let newNode = SinglyLinkedListNode(payload: 2)
        list.insertAtBeginning(newNode)
        XCTAssertTrue(list.firstNode === newNode, "The list has the first node different from the just inserted at the beginning.")
        XCTAssertTrue(list.firstNode?.nextNode === node, "The just inserted at the beginning node's next node doesn't reference to the previous first node.")
    }

    func testInsertAfter() {
        let node1 = SinglyLinkedListNode(payload: 1)
        let list = SinglyLinkedList<Int>(firstNode: node1)

        let node2 = SinglyLinkedListNode(payload: 2)
        list.insert(node2, after: node1)
        XCTAssertTrue(list.firstNode === node1, "The list has the first node different from the one having been initialized with.")
        XCTAssertTrue(list.firstNode?.nextNode === node2, "The list's first node points as the next one not the node having been inserted after.")
        XCTAssertNil(list.firstNode?.nextNode?.nextNode, "The list has an unexpected nodes count after inserting a node.")

        let node3 = SinglyLinkedListNode(payload: 3)
        list.insert(node3, after: node1)
        XCTAssertTrue(list.firstNode === node1, "The list has the first node different from the one having been initialized with.")
        XCTAssertTrue(list.firstNode?.nextNode === node3, "The list's first node points as the next one not the node having been inserted after.")
        XCTAssertTrue(list.firstNode?.nextNode?.nextNode === node2, "An inserted node points as the next one not the next node of the one having been inserted after.")
        XCTAssertNil(list.firstNode?.nextNode?.nextNode?.nextNode, "The list has an unexpected nodes count after inserting a node.")

        let node0 = SinglyLinkedListNode(payload: 0)
        let node4 = SinglyLinkedListNode(payload: 4)
        list.insert(node4, after: node0)
        XCTAssertTrue(list.firstNode === node1, "The list is unexpectedly modified after inserting a node after one not belonging to the list.")
        XCTAssertTrue(list.firstNode?.nextNode === node3, "The list's first node points as the next one not the node having been inserted after.")
        XCTAssertTrue(list.firstNode?.nextNode?.nextNode === node2, "An inserted node points as the next one not the next node of the one having been inserted after.")
        XCTAssertNil(list.firstNode?.nextNode?.nextNode?.nextNode, "The list has an unexpected nodes count after inserting a node.")

        let node5 = SinglyLinkedListNode(payload: 5)
        let node6 = SinglyLinkedListNode(payload: 6)
        list.insert(node6, after: node5)
        XCTAssertTrue(node5.nextNode === node6, "The node is not added as the next one of the node after which it was inserted.")
        XCTAssertTrue(list.firstNode === node1, "The list is unexpectedly modified after inserting a node after one not belonging to the list.")
        XCTAssertTrue(list.firstNode?.nextNode === node3, "The list is unexpectedly modified after inserting a node after one not belonging to the list.")
        XCTAssertTrue(list.firstNode?.nextNode?.nextNode === node2, "The list is unexpectedly modified after inserting a node after one not belonging to the list.")
        XCTAssertNil(list.firstNode?.nextNode?.nextNode?.nextNode, "The list is unexpectedly modified after inserting a node after one not belonging to the list.")
    }

    func testInsertAtEnd() {
        var list = SinglyLinkedList<Int>()

        let node1 = SinglyLinkedListNode(payload: 1)
        list.insertAtEnd(node1)
        XCTAssertTrue(list.firstNode === node1, "An unexpected first node after a node is inserted at the end of the empty list.")

        let node2 = SinglyLinkedListNode(payload: 2)
        list.insertAtEnd(node2)
        XCTAssertTrue(list.firstNode === node1, "The first node is changed unexpectedly after inserting a node at the end of the list.")
        XCTAssertTrue(list.firstNode?.nextNode === node2, "An unexpected next node reference of the previously last node after a node is inserted at the end of the list.")
    }

    func testRemoveFirst() {
        var list = SinglyLinkedList<Int>(firstNode: nil)

        list.removeFirst()
        XCTAssertNil(list.firstNode, "An initially empty list has the first node after attempt to remove it.")

        let node = SinglyLinkedListNode(payload: 1)
        list.insertAtBeginning(node)
        list.removeFirst()
        XCTAssertNil(list.firstNode, "A single node list has the first node after removing it.")

        let node1 = SinglyLinkedListNode(payload: 1)
        let node2 = SinglyLinkedListNode(payload: 2)
        list.insertAtBeginning(node2)
        list.insertAtBeginning(node1)
        list.removeFirst()
        XCTAssertTrue(list.firstNode === node2, "An unexpected new first node reference after removing the first node")
    }

    func testRemoveAfter() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        list.remove(after: node1)
        XCTAssertTrue(list.firstNode === node1, "The first node is changed unexpectedly after the node after it is deleted.")
        XCTAssertTrue(list.firstNode?.nextNode === node3, "The node after which the node is deleted has an unexpected next node reference.")
        XCTAssertNil(list.firstNode?.nextNode?.nextNode, "An unexpected nodes count after deleting a node.")

        list.remove(after: node1)
        XCTAssertTrue(list.firstNode === node1, "The first node is changed unexpectedly after the node after it is deleted.")
        XCTAssertNil(list.firstNode?.nextNode, "An unexpected nodes count after deleting a node.")
    }
    
    func testRemoveLast() {
        var list = SinglyLinkedList<Int>(firstNode: nil)

        list.removeLast()
        XCTAssertNil(list.firstNode, "An initially empty list has the first node after attempt to remove the last node.")
        XCTAssertNil(list.lastNode(), "An initially empty list has the last node after attempt to remove it.")

        let node = SinglyLinkedListNode(payload: 1)
        list.insertAtBeginning(node)
        list.removeLast()
        XCTAssertNil(list.firstNode, "A single node list has the first node after removing the last node.")
        XCTAssertNil(list.lastNode(), "A single node list has the last node after removing it.")

        let node1 = SinglyLinkedListNode(payload: 1)
        let node2 = SinglyLinkedListNode(payload: 2)
        let node3 = SinglyLinkedListNode(payload: 3)
        list.insertAtBeginning(node3)
        list.insertAtBeginning(node2)
        list.insertAtBeginning(node1)
        list.removeLast()
        XCTAssertTrue(list.firstNode === node1, "An unexpected new first node reference after removing the last node")
        XCTAssertTrue(list.lastNode() === node2, "An unexpected new last node reference after removing it")
    }

}
