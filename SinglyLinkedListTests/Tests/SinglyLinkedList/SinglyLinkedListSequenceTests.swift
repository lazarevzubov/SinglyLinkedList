//
//  SinglyLinkedListSequenceTests.swift
//  SinglyLinkedListTests
//
//  Created by Nikita Lazarev-Zubov on 07.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class SinglyLinkedListSequenceTests: XCTestCase {

    func testIterator() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        var iteration = 1
        for node in list {
            XCTAssertEqual(node.payload, iteration, "An unexpected node while iterating the sequence.")
            iteration += 1
        }
        XCTAssertEqual(iteration, 4, "The iteration indicator stopped on an unexpected value after the iteration is over.")

        XCTAssertEqual(list.firstNode, firstNode, "The list was changed after an iteration.")
        XCTAssertEqual(list.firstNode?.nextNode, secondNode, "The list was changed after an iteration.")
        XCTAssertEqual(list.firstNode?.nextNode?.nextNode, thirdNode, "The list was changed after an iteration.")
        XCTAssertNil(thirdNode.nextNode, "The list was changed after an iteration.")
    }

    func testEnumerated() {
        let thirdNode = SinglyLinkedListNode(payload: 2)
        let secondNode = SinglyLinkedListNode(payload: 1, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 0, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        for (index, node) in list.enumerated() {
            XCTAssertEqual(index, node.payload, "An unexpected enumeration index for a given integer payload following in order.")
        }

        XCTAssertEqual(list.firstNode, firstNode, "The list was changed after an enumerated iteration.")
        XCTAssertEqual(list.firstNode?.nextNode, secondNode, "The list was changed after an enumerated iteration.")
        XCTAssertEqual(list.firstNode?.nextNode?.nextNode, thirdNode, "The list was changed after an enumerated iteration.")
        XCTAssertNil(thirdNode.nextNode, "The list was changed after an enumerated iteration.")
    }

    func testContains() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertTrue(list.contains(firstNode), "An unexpected result of a containing test for a contained node.")
        XCTAssertTrue(list.contains(secondNode), "An unexpected result of a containing test for a contained node.")
        XCTAssertTrue(list.contains(thirdNode), "An unexpected result of a ontaining test for a contained node.")

        let node = SinglyLinkedListNode(payload: 4)
        XCTAssertFalse(list.contains(node), "An unexpected result of a containing test for a non-contained node.")
    }

    func testContainsWhere() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertTrue(list.contains { $0.payload == firstPayload }, "An unexpected result of a containing test for a knowingly satisfying condition.")
        XCTAssertTrue(list.contains { $0.payload == secondPayload }, "An unexpected result of a containing test for a knowingly satisfying condition.")
        XCTAssertTrue(list.contains { $0.payload == thirdPayload }, "An unexpected result of a containing test for a knowingly satisfying condition.")

        XCTAssertFalse(list.contains { $0.payload == 4 }, "An unexpected result of a containing test for a knowingly non-satisfying condition.")
    }

    func testFirst() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.first { $0.payload == firstPayload }, firstNode, "An unexpected result of a searching for a first node with a knowingly satisfying condition.")
        XCTAssertEqual(list.first { $0.payload == secondPayload }, secondNode, "An unexpected result of a searching for a first node with a knowingly satisfying condition.")
        XCTAssertEqual(list.first { $0.payload == thirdPayload }, thirdNode, "An unexpected result of a searching for a first node with a knowingly satisfying condition.")

        XCTAssertNil(list.first { $0.payload == 4 }, "An unknown result of a searching for a first node with a knowingly non-satisfying condition.")
    }

    func testMin() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.min(), firstNode, "An unexpected result of a searchig for a minimal value.")
    }

    func testMinBy() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.min { $0.payload > $1.payload }, thirdNode, "An unexpected result of a searchig for a minimal value with a given predicate.")
        XCTAssertEqual(list.min { $0.payload < $1.payload }, firstNode, "An unexpected result of a searchig for a minimal value with a given predicate.")
    }

    func testMax() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.max(), thirdNode, "An unexpected result of a searchig for a maximal value.")
    }

    func testMaxBy() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.max { $0.payload > $1.payload }, firstNode, "An unexpected result of a searchig for a maximal value with a given predicate.")
        XCTAssertEqual(list.max { $0.payload < $1.payload }, thirdNode, "An unexpected result of a searchig for a maximal value with a given predicate.")
    }

    func testCompactMap() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.compactMap { $0.payload }, [firstNode.payload, secondNode.payload, thirdNode.payload], "An unexpected result of a compact map transformation.")
    }

    func testFlatMap() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.flatMap { [$0.payload] }, [firstNode.payload, secondNode.payload, thirdNode.payload], "An unexpected result of a flat map transformation.")
    }

    func testReduce() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let initialResult = 0
        XCTAssertEqual(list.reduce(initialResult) { $0 + $1.payload }, initialResult + firstPayload + secondPayload + thirdPayload, "An unexpected result of a reduce accumulation.")
    }

    func testReduceInto() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.reduce(into: [Int]()) { $0.append($1.payload) }, [firstPayload, secondPayload, thirdPayload], "An unexpected result of a reduc0e-into accumulation.")
    }

    func testLazy() {
        // TODO: Add implementation.
    }

    func testSorted() {
        let thirdNode = SinglyLinkedListNode(payload: 1)
        let secondNode = SinglyLinkedListNode(payload: 3, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 2, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.sorted(), [thirdNode, firstNode, secondNode], "An unexpected sorting result of the default predicate for a comparable node type.")
    }

    func testSortedBy() {
        let thirdNode = SinglyLinkedListNode(payload: 1)
        let secondNode = SinglyLinkedListNode(payload: 3, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 2, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let expectedAscResult = [thirdNode, firstNode, secondNode]
        XCTAssertEqual(list.sorted { $0.payload < $1.payload }, expectedAscResult, "An unexpected sorting in ascending order result for a comparable node type.")

        let expectedDescResult = Array(expectedAscResult.reversed())
        XCTAssertEqual(list.sorted { $0.payload > $1.payload }, expectedDescResult, "An unexpected sorting in descending order result for a comparable node type.")
    }

    func testReversed() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let expectedResult = [thirdNode, secondNode, firstNode]
        XCTAssertEqual(list.reversed(), expectedResult, "An unexpected result of a constructiong array of nodes in reversed order.")
    }

    func testElementsEqual() {
        let thirdNode1 = SinglyLinkedListNode(payload: 3)
        let secondNode1 = SinglyLinkedListNode(payload: 2, nextNode: thirdNode1)
        let firstNode1 = SinglyLinkedListNode(payload: 1, nextNode: secondNode1)
        let list1 = SinglyLinkedList(firstNode: firstNode1)

        let thirdNode2 = SinglyLinkedListNode(payload: 3)
        let secondNode2 = SinglyLinkedListNode(payload: 2, nextNode: thirdNode2)
        let firstNode2 = SinglyLinkedListNode(payload: 1, nextNode: secondNode2)
        let list2 = SinglyLinkedList(firstNode: firstNode2)
        XCTAssertTrue(list1.elementsEqual(list2), "An elements equal test unexpectedly fails on similar lists.")

        let thirdNode3 = SinglyLinkedListNode(payload: 2)
        let secondNode3 = SinglyLinkedListNode(payload: 1, nextNode: thirdNode3)
        let firstNode3 = SinglyLinkedListNode(payload: 3, nextNode: secondNode3)
        let list3 = SinglyLinkedList(firstNode: firstNode3)
        XCTAssertFalse(list1.elementsEqual(list3), "An elements equal test unexpectedly succeeds on lists with similar nodes in a different order.")

        let secondNode4 = SinglyLinkedListNode(payload: 2)
        let firstNode4 = SinglyLinkedListNode(payload: 1, nextNode: secondNode4)
        let list4 = SinglyLinkedList(firstNode: firstNode4)
        XCTAssertFalse(list1.elementsEqual(list4), "An elements equal test unexpectedly succeeds on lists with one node difference.")
    }

    func testElementsEqualBy() {
        let thirdNode1 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3))
        let secondNode1 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2), nextNode: thirdNode1)
        let firstNode1 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: secondNode1)
        let list1 = SinglyLinkedList(firstNode: firstNode1)

        let thirdNode2 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3))
        let secondNode2 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2), nextNode: thirdNode2)
        let firstNode2 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: secondNode2)
        let list2 = SinglyLinkedList(firstNode: firstNode2)
        XCTAssertTrue(list1.elementsEqual(list2) { $0.payload.value == $1.payload.value }, "An elements equal test unexpectedly fails on similar lists.")

        let thirdNode3 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2))
        let secondNode3 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: thirdNode3)
        let firstNode3 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3), nextNode: secondNode3)
        let list3 = SinglyLinkedList(firstNode: firstNode3)
        XCTAssertFalse(list1.elementsEqual(list3) { $0.payload.value == $1.payload.value },
                       "An elements equal test unexpectedly succeeds on lists with similar nodes in a different order.")

        let secondNode4 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2))
        let firstNode4 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: secondNode4)
        let list4 = SinglyLinkedList(firstNode: firstNode4)
        XCTAssertFalse(list1.elementsEqual(list4) { $0.payload.value == $1.payload.value }, "An elements equal test unexpectedly succeeds on lists with a one node difference.")
    }

    func testStartsWith() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let prefixSecondNode = SinglyLinkedListNode(payload: secondPayload)
        let prefixFirstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: prefixSecondNode)
        let prefixList = SinglyLinkedList(firstNode: prefixFirstNode)
        XCTAssertTrue(list.starts(with: prefixList), "A prefix test unexpectedly fails for a list that is knowingly similar to a prefix.")

        let anotherNode = SinglyLinkedListNode(payload: 4)
        let anotherList = SinglyLinkedList(firstNode: anotherNode)
        XCTAssertFalse(list.starts(with: anotherList), "A prefix test unexpectedly succeeds for a list that contains a different set of nodes.")
    }

    func testStartsWithBy() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let prefixSecondNode = SinglyLinkedListNode(payload: secondPayload)
        let prefixFirstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: prefixSecondNode)
        let prefixList = SinglyLinkedList(firstNode: prefixFirstNode)
        XCTAssertTrue(list.starts(with: prefixList) { $0.payload == $1.payload }, "A prefix test unexpectedly fails for a list that is knowingly similar to a prefix.")

        let anotherNode = SinglyLinkedListNode(payload: 4)
        let anotherList = SinglyLinkedList(firstNode: anotherNode)
        XCTAssertFalse(list.starts(with: anotherList) { $0.payload == $1.payload }, "A prefix test unexpectedly succeeds for a list that contains a different set of nodes.")
    }

    func testLexicographicallyPrecedes() {
        let thirdNode = SinglyLinkedListNode(payload: 5)
        let secondNode = SinglyLinkedListNode(payload: 4, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 3, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let precedentSecondNode = SinglyLinkedListNode(payload: 2)
        let precedentFirstNode = SinglyLinkedListNode(payload: 1, nextNode: precedentSecondNode)
        let precedentList = SinglyLinkedList(firstNode: precedentFirstNode)
        XCTAssertTrue(precedentList.lexicographicallyPrecedes(list),
                      "A lecicographical precedence test unexpectedly fails for a lists which nodes knowingly form a natural sequence regarding its payload.")

        let nonPrecedentSecondNode = SinglyLinkedListNode(payload: 6)
        let nonPrecedentFirstNode = SinglyLinkedListNode(payload: 7, nextNode: nonPrecedentSecondNode)
        let nonPrecedentList = SinglyLinkedList(firstNode: nonPrecedentFirstNode)
        XCTAssertFalse(nonPrecedentList.lexicographicallyPrecedes(list),
                       "A lecicographical precedence test unexpectedly succeeds for a lists which nodes knowingly don't form a natural sequence regarding its payload.")
    }

    func testLexicographicallyPrecedesBy() {
        let thirdNode = SinglyLinkedListNode(payload: NonEquatableInt(value: 5))
        let secondNode = SinglyLinkedListNode(payload: NonEquatableInt(value: 4), nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: NonEquatableInt(value: 3), nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let precedentSecondNode = SinglyLinkedListNode(payload: NonEquatableInt(value: 2))
        let precedentFirstNode = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: precedentSecondNode)
        let precedentList = SinglyLinkedList(firstNode: precedentFirstNode)
        XCTAssertTrue(precedentList.lexicographicallyPrecedes(list) { $0.payload.value < $1.payload.value },
                      "A lecicographical precedence test unexpectedly fails for a lists which nodes knowingly form a natural sequence regarding its payload.")

        let nonPrecedentSecondNode = SinglyLinkedListNode(payload: NonEquatableInt(value: 6))
        let nonPrecedentFirstNode = SinglyLinkedListNode(payload: NonEquatableInt(value: 7), nextNode: nonPrecedentSecondNode)
        let nonPrecedentList = SinglyLinkedList(firstNode: nonPrecedentFirstNode)
        XCTAssertFalse(nonPrecedentList.lexicographicallyPrecedes(list) { $0.payload.value < $1.payload.value },
                       "A lecicographical precedence test unexpectedly succeeds for a lists which nodes knowingly don't form a natural sequence regarding its payload.")
    }

    func testAllSatisfy() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertTrue(list.allSatisfy { $0.payload < thirdPayload + 1 }, "The list's nodes fail a satisfaction check for a predicate which knowingly must pass.")
        XCTAssertFalse(list.allSatisfy { $0.payload > thirdPayload + 1 }, "The list's nodes succeed a satisfaction check for a predicate which knowingly must not pass.")
    }

    func testDropWhile() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(SinglyLinkedList(list.drop { $0.payload < firstPayload }), list, "An unexpected result of dropping by a condition.")
        XCTAssertEqual(SinglyLinkedList(list.drop { $0.payload < thirdPayload }), SinglyLinkedList(firstNode: thirdNode), "An unexpected result of dropping by a condition.")
        XCTAssertEqual(SinglyLinkedList(list.drop { $0.payload < thirdPayload + 1 }), SinglyLinkedList<Int>(), "An unexpected result of dropping by a condition.")

        XCTAssertEqual(list.firstNode, firstNode, "The list was changed after a drop-while sequence is initialized.")
        XCTAssertEqual(list.firstNode?.nextNode, secondNode, "The list was changed after a drop-while sequence is initialized.")
        XCTAssertEqual(list.firstNode?.nextNode?.nextNode, thirdNode, "The list was changed after a drop-while sequence is initialized.")
        XCTAssertNil(thirdNode.nextNode, "The list was changed after a drop-while sequence is initialized.")
    }

    func testDropFirst() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(SinglyLinkedList(list.dropFirst()), SinglyLinkedList(firstNode: secondNode), "An unexpected result of dropping the first node.")

        XCTAssertEqual(list.firstNode, firstNode, "The list was changed after a drop-first sequence is initialized.")
        XCTAssertEqual(list.firstNode?.nextNode, secondNode, "The list was changed after a drop-first sequence is initialized.")
        XCTAssertEqual(list.firstNode?.nextNode?.nextNode, thirdNode, "The list was changed after a drop-first sequence is initialized.")
        XCTAssertNil(thirdNode.nextNode, "The list was changed after a drop-first sequence is initialized.")
    }

    func testDropLast() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.dropLast(), [firstNode, secondNode], "An unexpected result of dropping the last node.")
    }

    func testFilter() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.filter { $0.payload < 3 }, [firstNode, secondNode], "An unexpected result of filtering.")
    }

    func testForEach() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let increment = 1
        list.forEach { $0.payload += increment }
        XCTAssertEqual(list.firstNode?.payload, firstPayload + increment, "")
        XCTAssertEqual(list.firstNode?.nextNode?.payload, secondPayload + increment, "")
        XCTAssertEqual(list.firstNode?.nextNode?.nextNode?.payload, thirdPayload + increment, "")

        XCTAssertEqual(list.firstNode, firstNode, "The list was changed after a for-each iteration.")
        XCTAssertEqual(list.firstNode?.nextNode, secondNode, "The list was changed after a for-each iteration.")
        XCTAssertEqual(list.firstNode?.nextNode?.nextNode, thirdNode, "The list was changed after a for-each iteration.")
        XCTAssertNil(thirdNode.nextNode, "The list was changed after a for-each iteration.")
    }

    func testMap() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.map { String($0.payload) }, [String(firstPayload), String(secondPayload), String(thirdPayload)], "An unexpected result of mapping.")
    }

    func testPrefix() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(SinglyLinkedList(list.prefix(0)), SinglyLinkedList<Int>(), "Non empty prefix list for a zero-length prefix.")

        let firstNode1 = SinglyLinkedListNode(payload: firstPayload)
        let list1 = SinglyLinkedList(firstNode: firstNode1)
        let result = SinglyLinkedList(list.prefix(1))
        XCTAssertEqual(result, list1, "A one item prefix doesn't equal to a list of the initial first node.")

        let secondNode2 = SinglyLinkedListNode(payload: secondPayload)
        let firstNode2 = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode2)
        let list2 = SinglyLinkedList(firstNode: firstNode2)
        XCTAssertEqual(SinglyLinkedList(list.prefix(2)), list2, "A two item prefix doesn't equal to a list of the initial first two nodes.")

        let thirdNode3 = SinglyLinkedListNode(payload: thirdPayload)
        let secondNode3 = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode3)
        let firstNode3 = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode3)
        let list3 = SinglyLinkedList(firstNode: firstNode3)
        XCTAssertEqual(SinglyLinkedList(list.prefix(3)), list3, "A full initial count prefix doesn't equal to the initial list.")
        XCTAssertEqual(SinglyLinkedList(list.prefix(4)), list3, "A more than full initial count prefix doesn't equal to the initial list.")

        XCTAssertEqual(list.firstNode, firstNode, "The list was changed after a prefix list initialization.")
        XCTAssertEqual(list.firstNode?.nextNode, secondNode, "The list was changed after a prefix list initialization.")
        XCTAssertEqual(list.firstNode?.nextNode?.nextNode, thirdNode, "The list was changed after a prefix list initialization.")
        XCTAssertNil(thirdNode.nextNode, "The list was changed after a prefix list initialization.")
    }

    func testPrefixWhile() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.prefix { $0.payload < thirdPayload }, [firstNode, secondNode], "An unexpected resulting array of nodes which prefixes a list with a given predicate.")
        XCTAssertEqual(list.prefix { $0.payload < thirdPayload + 1 },
                       [firstNode, secondNode, thirdNode],
                       "An unexpected resulting array of nodes which prefixes a list with a given predicate.")
        XCTAssertEqual(list.prefix { $0.payload > thirdPayload }, [SinglyLinkedListNode<Int>](), "An unexpected resulting array of nodes which prefixes a list with a given predicate.")
    }

    func testSuffix() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.suffix(0), [SinglyLinkedListNode<Int>](), "Non empty suffix array for a zero-length suffix.")
        XCTAssertEqual(list.suffix(1), [thirdNode], "An unexpected array elements or count for a suffix call.")
        XCTAssertEqual(list.suffix(2), [secondNode, thirdNode], "An unexpected array elements or count for a suffix call.")
        XCTAssertEqual(list.suffix(3), [firstNode, secondNode, thirdNode], "An unexpected array elements or count for a suffix call.")
        XCTAssertEqual(list.suffix(4), [firstNode, secondNode, thirdNode], "An unexpected array elements or count for a suffix call.")
    }

    func testShuffled() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let shuffledNodes = list.shuffled()
        XCTAssertTrue(shuffledNodes.contains(firstNode), "A shuffled nodes array doesn't contain a node from the initial list.")
        XCTAssertTrue(shuffledNodes.contains(secondNode), "A shuffled nodes array doesn't contain a node from the initial list.")
        XCTAssertTrue(shuffledNodes.contains(thirdNode), "A shuffled nodes array doesn't contain a node from the initial list.")
        XCTAssertEqual(shuffledNodes.count, 3, "A shuffled nodes array has a count different from the initial list nodes count.")
    }

    func testShuffledUsing() {
        struct Generator: RandomNumberGenerator {

            // MARK: - Properties

            var current: UInt64 = 0

            // MARK: - Methods

            // MARK: RandomNumberGenerator protocol methods

            func next() -> UInt64 {
                return current + 1
            }

        }

        // MARK: -

        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        var generator = Generator()
        let shuffledNodes = list.shuffled(using: &generator)
        XCTAssertTrue(shuffledNodes.contains(firstNode), "A shuffled nodes array doesn't contain a node from the initial list.")
        XCTAssertTrue(shuffledNodes.contains(secondNode), "A shuffled nodes array doesn't contain a node from the initial list.")
        XCTAssertTrue(shuffledNodes.contains(thirdNode), "A shuffled nodes array doesn't contain a node from the initial list.")
        XCTAssertEqual(shuffledNodes.count, 3, "A shuffled nodes array has a count different from the initial list nodes count.")
    }

    func testSplit() {
        let tenthNode = SinglyLinkedListNode(payload: 2)
        let ninthNode = SinglyLinkedListNode(payload: 9, nextNode: tenthNode)
        let eighthNode = SinglyLinkedListNode(payload: 8, nextNode: ninthNode)
        let seventhNode = SinglyLinkedListNode(payload: 7, nextNode: eighthNode)
        let sixthNode = SinglyLinkedListNode(payload: 2, nextNode: seventhNode)
        let fifthNode = SinglyLinkedListNode(payload: 5, nextNode: sixthNode)
        let fourthNode = SinglyLinkedListNode(payload: 4, nextNode: fifthNode)
        let thirdNode = SinglyLinkedListNode(payload: 3, nextNode: fourthNode)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let unlimitedSplitsOmittingEmpties = list.split { $0.payload == 2 }
        XCTAssertEqual(unlimitedSplitsOmittingEmpties.count, 3, "Unexpected splits count.")
        XCTAssertEqual(unlimitedSplitsOmittingEmpties[0].count, 1, "Slice doesn't match.")
        XCTAssertEqual(unlimitedSplitsOmittingEmpties[1].count, 3, "Slice doesn't match.")
        XCTAssertEqual(unlimitedSplitsOmittingEmpties[2].count, 3, "Slice doesn't match.")

        let limitedSplitsOmittingEmpties = list.split(maxSplits: 1) { $0.payload == 2 }
        XCTAssertEqual(limitedSplitsOmittingEmpties.count, 2, "Unexpected splits count.")
        XCTAssertEqual(limitedSplitsOmittingEmpties[0].count, 1, "Slice doesn't match.")
        XCTAssertEqual(limitedSplitsOmittingEmpties[1].count, 8, "Slice doesn't match.")

        let limitedSplitsNonOmittingEmpties = list.split(omittingEmptySubsequences: false) { $0.payload == 2 }
        XCTAssertEqual(limitedSplitsNonOmittingEmpties.count, 4, "Unexpected splits count.")
        XCTAssertEqual(limitedSplitsNonOmittingEmpties[0].count, 1, "Slice doesn't match.")
        XCTAssertEqual(limitedSplitsNonOmittingEmpties[1].count, 3, "Slice doesn't match.")
        XCTAssertEqual(limitedSplitsNonOmittingEmpties[2].count, 3, "Slice doesn't match.")
        XCTAssertEqual(limitedSplitsNonOmittingEmpties[3].count, 0, "Slice doesn't match.")
    }

    func testSplitWithSeparator() {
        let tenthNode = SinglyLinkedListNode(payload: 2)
        let ninthNode = SinglyLinkedListNode(payload: 9, nextNode: tenthNode)
        let eighthNode = SinglyLinkedListNode(payload: 8, nextNode: ninthNode)
        let seventhNode = SinglyLinkedListNode(payload: 7, nextNode: eighthNode)
        let sixthNode = SinglyLinkedListNode(payload: 2, nextNode: seventhNode)
        let fifthNode = SinglyLinkedListNode(payload: 5, nextNode: sixthNode)
        let fourthNode = SinglyLinkedListNode(payload: 4, nextNode: fifthNode)
        let thirdNode = SinglyLinkedListNode(payload: 3, nextNode: fourthNode)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let unlimitedSplitsOmittingEmpties = list.split(separator: secondNode)
        XCTAssertEqual(unlimitedSplitsOmittingEmpties.count, 3, "Unexpected splits count.")
        XCTAssertEqual(unlimitedSplitsOmittingEmpties[0].count, 1, "Slice doesn't match.")
        XCTAssertEqual(unlimitedSplitsOmittingEmpties[1].count, 3, "Slice doesn't match.")
        XCTAssertEqual(unlimitedSplitsOmittingEmpties[2].count, 3, "Slice doesn't match.")

        let limitedSplitsOmittingEmpties = list.split(separator: secondNode, maxSplits: 1)
        XCTAssertEqual(limitedSplitsOmittingEmpties.count, 2, "Unexpected splits count.")
        XCTAssertEqual(limitedSplitsOmittingEmpties[0].count, 1, "Slice doesn't match.")
        XCTAssertEqual(limitedSplitsOmittingEmpties[1].count, 8, "Slice doesn't match.")

        let limitedSplitsNonOmittingEmpties = list.split(separator: secondNode, omittingEmptySubsequences: false)
        XCTAssertEqual(limitedSplitsNonOmittingEmpties.count, 4, "Unexpected splits count.")
        XCTAssertEqual(limitedSplitsNonOmittingEmpties[0].count, 1, "Slice doesn't match.")
        XCTAssertEqual(limitedSplitsNonOmittingEmpties[1].count, 3, "Slice doesn't match.")
        XCTAssertEqual(limitedSplitsNonOmittingEmpties[2].count, 3, "Slice doesn't match.")
        XCTAssertEqual(limitedSplitsNonOmittingEmpties[3].count, 0, "Slice doesn't match.")
    }

    func testWithContiguousStorage() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertNil(list.withContiguousStorageIfAvailable { $0.count }, "Unimplemented contiguous storage unexpectedly exists.")
    }

    // MARK: -

    private struct NonEquatableInt {

        // MARK: - Properties

        let value: Int

    }

}
