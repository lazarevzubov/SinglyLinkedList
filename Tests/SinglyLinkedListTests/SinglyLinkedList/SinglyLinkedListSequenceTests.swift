//
//  SinglyLinkedListSequenceTests.swift
//  SinglyLinkedListTests
//
//  Created by Nikita Lazarev-Zubov on 07.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct SinglyLinkedListSequenceTests {

    // MARK: - Methods

    @Test
    func iterator_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        var iteration = 1
        for node in list {
            #expect(node.payload == iteration, "An unexpected node is encountered while iterating the sequence.")
            iteration += 1
        }
        #expect(iteration == 4, "The iteration indicator stopped on an unexpected value after the iteration is over.")

        #expect(list.firstNode == node1, "The list was changed after the iteration.")
        #expect(list.firstNode?.nextNode == node2, "The list was changed after the iteration.")
        #expect(list.firstNode?.nextNode?.nextNode == node3, "The list was changed after the iteration.")
        #expect(node3.nextNode == nil, "The list was changed after the iteration.")
    }

    @Test
    func enumerated_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 2)
        let node2 = SinglyLinkedListNode(payload: 1, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 0, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        for (index, node) in list.enumerated() {
            #expect(
                index == node.payload,
                "An unexpected enumeration index for a given integer payload following in order."
            )
        }

        #expect(list.firstNode == node1, "The list was changed after the enumerated iteration.")
        #expect(list.firstNode?.nextNode == node2, "The list was changed after the enumerated iteration.")
        #expect(list.firstNode?.nextNode?.nextNode == node3, "The list was changed after the enumerated iteration.")
        #expect(node3.nextNode == nil, "The list was changed after the enumerated iteration.")
    }

    @Test
    func contains_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(list.contains(node1), "An unexpected result of a containing test for a contained node.")
        #expect(list.contains(node2), "An unexpected result of a containing test for a contained node.")
        #expect(list.contains(node3), "An unexpected result of a containing test for a contained node.")

        let node = SinglyLinkedListNode(payload: 4)
        #expect(!list.contains(node), "An unexpected result of a containing test for a non-contained node.")
    }

    @Test
    func containsWhere_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.contains { $0.payload == payload1 },
            "An unexpected result of a containing test for a knowingly satisfying condition."
        )
        #expect(
            list.contains { $0.payload == payload2 },
            "An unexpected result of a containing test for a knowingly satisfying condition."
        )
        #expect(
            list.contains { $0.payload == payload3 },
            "An unexpected result of a containing test for a knowingly satisfying condition."
        )

        #expect(
            !list.contains { $0.payload == 4 },
            "An unexpected result of a containing test for a knowingly non-satisfying condition."
        )
    }

    @Test
    func first_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.first { $0.payload == payload1 } == node1,
            "An unexpected result of a searching for a first node with a knowingly satisfying condition."
        )
        #expect(
            list.first { $0.payload == payload2 } == node2,
            "An unexpected result of a searching for a first node with a knowingly satisfying condition."
        )
        #expect(
            list.first { $0.payload == payload3 } == node3,
            "An unexpected result of a searching for a first node with a knowingly satisfying condition."
        )

        #expect(
            list.first { $0.payload == 4 } == nil,
            "An unknown result of a searching for a first node with a knowingly non-satisfying condition."
        )
    }

    @Test
    func min_returnNodeWithMinPayload() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(list.min() == node1, "An unexpected result of a searching for a minimal value.")
    }

    @Test
    func minBy_returnNodeWithMinPayload_takingConditionIntoAccount() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(
            list.min { $0.payload > $1.payload } == node3,
            "An unexpected result of a searching for a minimal value with a given predicate."
        )
    }

    @Test
    func max_returnNodeWithMaxPayload() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(list.max() == node3, "An unexpected result of a searching for a maximal value.")
    }

    @Test
    func maxBy_returnNodeWithMaxPayload_takingConditionIntoAccount() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(
            list.max { $0.payload > $1.payload } == node1,
            "An unexpected result of a searching for a maximal value with a given predicate."
        )
    }

    @Test
    func compactMap_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(
            list.compactMap { $0.payload } == [
                node1.payload,
                node2.payload,
                node3.payload
            ],
            "An unexpected result of a compact map transformation."
        )
    }

    @Test
    func testFlatMap_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(
            list.flatMap { [$0.payload] } == [
                node1.payload,
                node2.payload,
                node3.payload
            ],
            "An unexpected result of a flat map transformation."
        )
    }

    @Test
    func reduce_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        let initialResult = 0
        #expect(
            list.reduce(initialResult) { $0 + $1.payload } == (initialResult + payload1 + payload2 + payload3),
            "An unexpected result of a reduce accumulation."
        )
    }

    @Test
    func reduceInto_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.reduce(into: [Int]()) { $0.append($1.payload) } == [
                payload1,
                payload2,
                payload3
            ],
            "An unexpected result of a reduce-into accumulation."
        )
    }

    @Test
    func lazy_worksAsExpected() {
        // TODO: Add implementation.
    }

    @Test
    func sorted_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 1)
        let node2 = SinglyLinkedListNode(payload: 3, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 2, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(
            list.sorted() == [
                node3,
                node1,
                node2
            ],
            "An unexpected sorting result of the default predicate for a comparable node type."
        )
    }

    @Test
    func sortedBy_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 1)
        let node2 = SinglyLinkedListNode(payload: 3, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 2, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(
            list.sorted { $0.payload < $1.payload } == [
                node3,
                node1,
                node2
            ],
            "An unexpected sorting in ascending order result for a comparable node type."
        )
    }

    @Test
    func reversed_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(
            list.reversed() == [
                node3,
                node2,
                node1
            ],
            "An unexpected result of a constructiong array of nodes in reversed order."
        )
    }

    @Test
    func elementsEqual_true_whenLists_similar() {
        let node31 = SinglyLinkedListNode(payload: 3)
        let node21 = SinglyLinkedListNode(payload: 2, nextNode: node31)
        let node11 = SinglyLinkedListNode(payload: 1, nextNode: node21)

        let list1 = SinglyLinkedList(firstNode: node11)

        let node32 = SinglyLinkedListNode(payload: 3)
        let node22 = SinglyLinkedListNode(payload: 2, nextNode: node32)
        let node12 = SinglyLinkedListNode(payload: 1, nextNode: node22)

        let list2 = SinglyLinkedList(firstNode: node12)

        #expect(list1.elementsEqual(list2), "An elements equal test unexpectedly fails on similar lists.")
    }

    @Test
    func elementsEqual_false_whenNodes_inDifferentOrder() {
        let node31 = SinglyLinkedListNode(payload: 3)
        let node21 = SinglyLinkedListNode(payload: 2, nextNode: node31)
        let node11 = SinglyLinkedListNode(payload: 1, nextNode: node21)

        let list1 = SinglyLinkedList(firstNode: node11)

        let node32 = SinglyLinkedListNode(payload: 2)
        let node22 = SinglyLinkedListNode(payload: 1, nextNode: node32)
        let node12 = SinglyLinkedListNode(payload: 3, nextNode: node22)

        let list2 = SinglyLinkedList(firstNode: node12)

        #expect(
            !list1.elementsEqual(list2),
            "An elements equal test unexpectedly succeeds on lists with similar nodes in a different order."
        )
    }

    @Test
    func elementsEqual_false_whenNodes_different() {
        let node31 = SinglyLinkedListNode(payload: 3)
        let node21 = SinglyLinkedListNode(payload: 2, nextNode: node31)
        let node11 = SinglyLinkedListNode(payload: 1, nextNode: node21)

        let list1 = SinglyLinkedList(firstNode: node11)


        let node22 = SinglyLinkedListNode(payload: 2)
        let node12 = SinglyLinkedListNode(payload: 1, nextNode: node22)

        let list2 = SinglyLinkedList(firstNode: node12)

        #expect(
            !list1.elementsEqual(list2),
            "An elements equal test unexpectedly succeeds on lists with one node difference."
        )
    }

    @Test
    func elementsEqualBy_true_whenLists_similar() {
        let node31 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3))
        let node21 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2), nextNode: node31)
        let node11 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: node21)

        let list1 = SinglyLinkedList(firstNode: node11)

        let node32 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3))
        let node22 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2), nextNode: node32)
        let node12 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: node22)

        let list2 = SinglyLinkedList(firstNode: node12)

        #expect(
            list1.elementsEqual(list2) { $0.payload.value == $1.payload.value }, 
            "An elements equal test unexpectedly fails on similar lists."
        )
    }

    @Test
    func elementsEqualBy_false_whenNodes_inDifferentOrder() {
        let node31 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3))
        let node21 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2), nextNode: node31)
        let node11 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: node21)

        let list1 = SinglyLinkedList(firstNode: node11)

        let node32 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2))
        let node22 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: node32)
        let node12 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3), nextNode: node22)

        let list2 = SinglyLinkedList(firstNode: node12)

        #expect(
            !list1.elementsEqual(list2) { $0.payload.value == $1.payload.value },
            "An elements equal test unexpectedly succeeds on lists with similar nodes in a different order."
        )
    }

    @Test
    func elementsEqualBy_true_whenNodes_inDifferentOrder() {
        let node31 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3))
        let node21 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2), nextNode: node31)
        let node11 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: node21)

        let list1 = SinglyLinkedList(firstNode: node11)

        let node22 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2))
        let node12 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: node22)

        let list2 = SinglyLinkedList(firstNode: node12)

        #expect(
            !list1.elementsEqual(list2) { $0.payload.value == $1.payload.value },
            "An elements equal test unexpectedly succeeds on lists with a one node difference."
        )
    }

    @Test
    func startsWith_true_whenList_prefix() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        let prefixNode2 = SinglyLinkedListNode(payload: payload2)
        let prefixNode1 = SinglyLinkedListNode(payload: payload1, nextNode: prefixNode2)

        let prefixList = SinglyLinkedList(firstNode: prefixNode1)
        #expect(
            list.starts(with: prefixList),
            "A prefix test unexpectedly fails for a list that is knowingly similar to a prefix."
        )
    }

    @Test
    func startsWith_false_whenList_notPrefix() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        let nonPrefixNode = SinglyLinkedListNode(payload: 4)
        let nonPrefixList = SinglyLinkedList(firstNode: nonPrefixNode)

        #expect(
            !list.starts(with: nonPrefixList),
            "A prefix test unexpectedly succeeds for a list that contains a different set of nodes."
        )
    }

    @Test
    func startsWithBy_true_whenList_prefix() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        let prefixNode2 = SinglyLinkedListNode(payload: payload2)
        let prefixNode1 = SinglyLinkedListNode(payload: payload1, nextNode: prefixNode2)

        let prefixList = SinglyLinkedList(firstNode: prefixNode1)
        #expect(
            list.starts(with: prefixList) { $0.payload == $1.payload },
            "A prefix test unexpectedly fails for a list that is knowingly similar to a prefix."
        )
    }

    @Test
    func startsWithBy_false_whenList_notPrefix() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        let nonPrefixNode = SinglyLinkedListNode(payload: 4)
        let nonPrefixList = SinglyLinkedList(firstNode: nonPrefixNode)

        #expect(
            !list.starts(with: nonPrefixList) { $0.payload == $1.payload },
            "A prefix test unexpectedly succeeds for a list that contains a different set of nodes."
        )
    }

    @Test
    func lexicographicallyPrecedes_true_whenList_havePrecedingNodes() {
        let node3 = SinglyLinkedListNode(payload: 5)
        let node2 = SinglyLinkedListNode(payload: 4, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 3, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        let precedingNode2 = SinglyLinkedListNode(payload: 2)
        let precedingNode1 = SinglyLinkedListNode(payload: 1, nextNode: precedingNode2)

        let precedingList = SinglyLinkedList(firstNode: precedingNode1)
        #expect(
            precedingList.lexicographicallyPrecedes(list),
            Comment(
                rawValue: "A lexicographical precedence test unexpectedly fails for a lists which nodes knowingly form "
                    + "a natural sequence regarding their payload."
            )
        )
    }

    @Test
    func lexicographicallyPrecedes_false_whenList_notHavePrecedingNodes() {
        let node3 = SinglyLinkedListNode(payload: 5)
        let node2 = SinglyLinkedListNode(payload: 4, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 3, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        let nonPrecedingNode2 = SinglyLinkedListNode(payload: 6)
        let nonPrecedingNode1 = SinglyLinkedListNode(payload: 7, nextNode: nonPrecedingNode2)

        let nonPrecedingList = SinglyLinkedList(firstNode: nonPrecedingNode1)
        #expect(
            !nonPrecedingList.lexicographicallyPrecedes(list),
            Comment(
                rawValue: "A lexicographical precedence test unexpectedly succeeds for a lists which nodes knowingly "
                    + "don't form a natural sequence regarding their payload."
            )
        )
    }

    @Test
    func lexicographicallyPrecedesBy_true_whenList_havePrecedingNodes() {
        let node3 = SinglyLinkedListNode(payload: NonEquatableInt(value: 5))
        let node2 = SinglyLinkedListNode(payload: NonEquatableInt(value: 4), nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3), nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        let precedingNode2 = SinglyLinkedListNode(payload: NonEquatableInt(value: 2))
        let precedingNode1 = SinglyLinkedListNode(payload: NonEquatableInt(value: 1), nextNode: precedingNode2)

        let precedingList = SinglyLinkedList(firstNode: precedingNode1)
        #expect(
            precedingList.lexicographicallyPrecedes(list) { $0.payload.value < $1.payload.value },
            Comment(
                rawValue: "A lexicographical precedence test unexpectedly fails for a lists which nodes knowingly form "
                    + "a natural sequence regarding its payload."
            )
        )
    }

    @Test
    func lexicographicallyPrecedesBy_false_whenList_notHavePrecedingNodes() {
        let node3 = SinglyLinkedListNode(payload: NonEquatableInt(value: 5))
        let node2 = SinglyLinkedListNode(payload: NonEquatableInt(value: 4), nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: NonEquatableInt(value: 3), nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        let nonPrecedingNode2 = SinglyLinkedListNode(payload: NonEquatableInt(value: 6))
        let nonPrecedingNode1 = SinglyLinkedListNode(payload: NonEquatableInt(value: 7), nextNode: nonPrecedingNode2)

        let nonPrecedingList = SinglyLinkedList(firstNode: nonPrecedingNode1)
        #expect(
            !nonPrecedingList.lexicographicallyPrecedes(list) { $0.payload.value < $1.payload.value },
            Comment(
                rawValue: "A lecicographical precedence test unexpectedly succeeds for a lists which nodes knowingly "
                    + "don't form a natural sequence regarding its payload."
            )
        )
    }

    @Test
    func allSatisfy_true_forTruthyCondition() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.allSatisfy { $0.payload < payload3 + 1 },
            "The list's nodes fail a satisfaction check for a predicate which knowingly must pass."
        )
    }

    @Test
    func allSatisfy_false_forFalsyCondition() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            !list.allSatisfy { $0.payload > payload3 + 1 },
            "The list's nodes succeed a satisfaction check for a predicate which knowingly must not pass."
        )
    }

    @Test
    func dropWhile_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            SinglyLinkedList(list.drop { $0.payload < payload3 }) == SinglyLinkedList(firstNode: node3),
            "An unexpected result of dropping by a condition."
        )
    }

    @Test
    func dropFirst_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(
            SinglyLinkedList(list.dropFirst()) == SinglyLinkedList(firstNode: node2),
            "An unexpected result of dropping the first node."
        )
    }

    @Test
    func dropLast_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(list.dropLast() == [node1, node2], "An unexpected result of dropping the last node.")
    }

    @Test
    func filter_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        #expect(list.filter { $0.payload < 3 } == [node1, node2], "An unexpected result of filtering.")
    }

    @Test
    func forEach_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        let increment = 1
        list.forEach { $0.payload += increment }

        #expect(list.firstNode?.payload == payload1 + increment, "")
        #expect(list.firstNode?.nextNode?.payload == payload2 + increment, "")
        #expect(list.firstNode?.nextNode?.nextNode?.payload == payload3 + increment, "")
    }

    @Test
    func map_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.map { String($0.payload) } == [
                String(payload1),
                String(payload2),
                String(payload3)
            ],
            "An unexpected result of mapping."
        )
    }

    @Test
    func prefix_ofSize_zero_emptyList() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            SinglyLinkedList(list.prefix(0)) == SinglyLinkedList<Int>(),
            "Non empty prefix list for a zero-length prefix."
        )
    }

    @Test
    func prefix_ofSize_two_listWithTwoFirstNodes() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        let node22 = SinglyLinkedListNode(payload: payload2)

        let node12 = SinglyLinkedListNode(payload: payload1, nextNode: node22)
        let list2 = SinglyLinkedList(firstNode: node12)

        #expect(
            SinglyLinkedList(list.prefix(2)) == list2,
            "A two item prefix doesn't equal to a list of the initial first two nodes."
        )
    }

    @Test
    func prefix_ofSize_moreThanCount_similarList() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        let node32 = SinglyLinkedListNode(payload: payload3)
        let node22 = SinglyLinkedListNode(payload: payload2, nextNode: node32)
        let node12 = SinglyLinkedListNode(payload: payload1, nextNode: node22)

        let list2 = SinglyLinkedList(firstNode: node12)
        #expect(
            SinglyLinkedList(list.prefix(4)) == list2,
            "A more than full initial count prefix doesn't equal to the initial list."
        )
    }

    @Test
    func prefixWhile_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.prefix { $0.payload < payload3 } == [
                node1,
                node2
            ],
            "An unexpected resulting array of nodes which prefixes a list with a given predicate."
        )
    }

    @Test
    func prefixWhile_withCoveringCondition_similarList() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.prefix { $0.payload < payload3 + 1 } == [
                node1,
                node2,
                node3
            ],
            "An unexpected resulting array of nodes which prefixes a list with a given predicate."
        )
    }

    @Test
    func prefixWhile_withNonMatchingCondition_emptyList() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.prefix { $0.payload > payload3 } == [SinglyLinkedListNode<Int>](),
            "An unexpected resulting array of nodes which prefixes a list with a given predicate."
        )
    }

    @Test
    func suffix_ofSize_zero_emptyArray() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.suffix(0) == [SinglyLinkedListNode<Int>](), 
            "Non empty suffix array for a zero-length suffix."
        )
    }

    @Test
    func suffix_worksAsExpected() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.suffix(2) == [
                node2,
                node3
            ],
            "An unexpected array elements or count for a suffix call."
        )
    }

    @Test
    func suffix_withSize_moreThanCount_arrayOfAllNodes() {
        let payload3 = 3
        let node3 = SinglyLinkedListNode(payload: payload3)

        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2, nextNode: node3)

        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        #expect(
            list.suffix(4) == [
                node1,
                node2,
                node3
            ],
            "An unexpected array elements or count for a suffix call."
        )
    }

    @Test
    func shuffled_containsAllNodes() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        let shuffledNodes = list.shuffled()

        #expect(shuffledNodes.contains(node1), "A shuffled nodes array doesn't contain a node from the initial list.")
        #expect(shuffledNodes.contains(node2), "A shuffled nodes array doesn't contain a node from the initial list.")
        #expect(shuffledNodes.contains(node3), "A shuffled nodes array doesn't contain a node from the initial list.")

        #expect(
            shuffledNodes.count == 3, 
            "A shuffled nodes array has a count different from the initial list nodes count."
        )
    }

    @Test
    func shuffledUsing_containsAllNodes() {
        struct Generator: RandomNumberGenerator {

            // MARK: - Properties

            var current: UInt64 = 0

            // MARK: - Methods

            // MARK: RandomNumberGenerator protocol methods

            func next() -> UInt64 {
                current + 1
            }

        }

        // MARK: -

        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)

        var generator = Generator()
        let shuffledNodes = list.shuffled(using: &generator)

        #expect(shuffledNodes.contains(node1), "A shuffled nodes array doesn't contain a node from the initial list.")
        #expect(shuffledNodes.contains(node2), "A shuffled nodes array doesn't contain a node from the initial list.")
        #expect(shuffledNodes.contains(node3), "A shuffled nodes array doesn't contain a node from the initial list.")

        #expect(
            shuffledNodes.count == 3, 
            "A shuffled nodes array has a count different from the initial list nodes count."
        )
    }

    @Test
    func split_withoutLimit_includesAllSlices() {
        let node10 = SinglyLinkedListNode(payload: 2)
        let node9 = SinglyLinkedListNode(payload: 9, nextNode: node10)
        let node8 = SinglyLinkedListNode(payload: 8, nextNode: node9)
        let node7 = SinglyLinkedListNode(payload: 7, nextNode: node8)
        let node6 = SinglyLinkedListNode(payload: 2, nextNode: node7)
        let node5 = SinglyLinkedListNode(payload: 5, nextNode: node6)
        let node4 = SinglyLinkedListNode(payload: 4, nextNode: node5)
        let node3 = SinglyLinkedListNode(payload: 3, nextNode: node4)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        let unlimitedSplitsOmittingEmpties = list.split { $0.payload == 2 }

        #expect(unlimitedSplitsOmittingEmpties.count == 3, "Unexpected splits count.")

        #expect(unlimitedSplitsOmittingEmpties[0].count == 1, "Slice doesn't match.")
        #expect(unlimitedSplitsOmittingEmpties[1].count == 3, "Slice doesn't match.")
        #expect(unlimitedSplitsOmittingEmpties[2].count == 3, "Slice doesn't match.")
    }

    @Test
    func split_withLimit_omittingEmptySlices_includesFirstSlicesUpToLimit() {
        let node10 = SinglyLinkedListNode(payload: 2)
        let node9 = SinglyLinkedListNode(payload: 9, nextNode: node10)
        let node8 = SinglyLinkedListNode(payload: 8, nextNode: node9)
        let node7 = SinglyLinkedListNode(payload: 7, nextNode: node8)
        let node6 = SinglyLinkedListNode(payload: 2, nextNode: node7)
        let node5 = SinglyLinkedListNode(payload: 5, nextNode: node6)
        let node4 = SinglyLinkedListNode(payload: 4, nextNode: node5)
        let node3 = SinglyLinkedListNode(payload: 3, nextNode: node4)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        let limitedSplitsOmittingEmpties = list.split(maxSplits: 1) { $0.payload == 2 }

        #expect(limitedSplitsOmittingEmpties.count == 2, "Unexpected splits count.")

        #expect(limitedSplitsOmittingEmpties[0].count == 1, "Slice doesn't match.")
        #expect(limitedSplitsOmittingEmpties[1].count == 8, "Slice doesn't match.")
    }

    @Test
    func split_withLimit_includingEmptySlices_includesFirstSlicesUpToLimit() {
        let node10 = SinglyLinkedListNode(payload: 2)
        let node9 = SinglyLinkedListNode(payload: 9, nextNode: node10)
        let node8 = SinglyLinkedListNode(payload: 8, nextNode: node9)
        let node7 = SinglyLinkedListNode(payload: 7, nextNode: node8)
        let node6 = SinglyLinkedListNode(payload: 2, nextNode: node7)
        let node5 = SinglyLinkedListNode(payload: 5, nextNode: node6)
        let node4 = SinglyLinkedListNode(payload: 4, nextNode: node5)
        let node3 = SinglyLinkedListNode(payload: 3, nextNode: node4)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        let limitedSplitsNonOmittingEmpties = list.split(omittingEmptySubsequences: false) { $0.payload == 2 }

        #expect(limitedSplitsNonOmittingEmpties.count == 4, "Unexpected splits count.")

        #expect(limitedSplitsNonOmittingEmpties[0].count == 1, "Slice doesn't match.")
        #expect(limitedSplitsNonOmittingEmpties[1].count == 3, "Slice doesn't match.")
        #expect(limitedSplitsNonOmittingEmpties[2].count == 3, "Slice doesn't match.")
        #expect(limitedSplitsNonOmittingEmpties[3].isEmpty, "Slice doesn't match.")
    }

    @Test
    func splitWithSeparator_withoutLimit_includesAllSlices() {
        let node10 = SinglyLinkedListNode(payload: 2)
        let node9 = SinglyLinkedListNode(payload: 9, nextNode: node10)
        let node8 = SinglyLinkedListNode(payload: 8, nextNode: node9)
        let node7 = SinglyLinkedListNode(payload: 7, nextNode: node8)
        let node6 = SinglyLinkedListNode(payload: 2, nextNode: node7)
        let node5 = SinglyLinkedListNode(payload: 5, nextNode: node6)
        let node4 = SinglyLinkedListNode(payload: 4, nextNode: node5)
        let node3 = SinglyLinkedListNode(payload: 3, nextNode: node4)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        let unlimitedSplitsOmittingEmpties = list.split(separator: node2)

        #expect(unlimitedSplitsOmittingEmpties.count == 3, "Unexpected splits count.")

        #expect(unlimitedSplitsOmittingEmpties[0].count == 1, "Slice doesn't match.")
        #expect(unlimitedSplitsOmittingEmpties[1].count == 3, "Slice doesn't match.")
        #expect(unlimitedSplitsOmittingEmpties[2].count == 3, "Slice doesn't match.")
    }

    @Test
    func splitWithSeparator_withLimit_omittingEmptySlices_includesFirstSlicesUpToLimit() {
        let node10 = SinglyLinkedListNode(payload: 2)
        let node9 = SinglyLinkedListNode(payload: 9, nextNode: node10)
        let node8 = SinglyLinkedListNode(payload: 8, nextNode: node9)
        let node7 = SinglyLinkedListNode(payload: 7, nextNode: node8)
        let node6 = SinglyLinkedListNode(payload: 2, nextNode: node7)
        let node5 = SinglyLinkedListNode(payload: 5, nextNode: node6)
        let node4 = SinglyLinkedListNode(payload: 4, nextNode: node5)
        let node3 = SinglyLinkedListNode(payload: 3, nextNode: node4)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        let limitedSplitsOmittingEmpties = list.split(separator: node2, maxSplits: 1)

        #expect(limitedSplitsOmittingEmpties.count == 2, "Unexpected splits count.")

        #expect(limitedSplitsOmittingEmpties[0].count == 1, "Slice doesn't match.")
        #expect(limitedSplitsOmittingEmpties[1].count == 8, "Slice doesn't match.")
    }

    @Test
    func splitWithSeparator_withLimit_includingEmptySlices_includesFirstSlicesUpToLimit() {
        let node10 = SinglyLinkedListNode(payload: 2)
        let node9 = SinglyLinkedListNode(payload: 9, nextNode: node10)
        let node8 = SinglyLinkedListNode(payload: 8, nextNode: node9)
        let node7 = SinglyLinkedListNode(payload: 7, nextNode: node8)
        let node6 = SinglyLinkedListNode(payload: 2, nextNode: node7)
        let node5 = SinglyLinkedListNode(payload: 5, nextNode: node6)
        let node4 = SinglyLinkedListNode(payload: 4, nextNode: node5)
        let node3 = SinglyLinkedListNode(payload: 3, nextNode: node4)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)

        let list = SinglyLinkedList(firstNode: node1)
        let limitedSplitsNonOmittingEmpties = list.split(separator: node2, omittingEmptySubsequences: false)

        #expect(limitedSplitsNonOmittingEmpties.count == 4, "Unexpected splits count.")

        #expect(limitedSplitsNonOmittingEmpties[0].count == 1, "Slice doesn't match.")
        #expect(limitedSplitsNonOmittingEmpties[1].count == 3, "Slice doesn't match.")
        #expect(limitedSplitsNonOmittingEmpties[2].count == 3, "Slice doesn't match.")
        #expect(limitedSplitsNonOmittingEmpties[3].isEmpty, "Slice doesn't match.")
    }

    // MARK: -

    private struct NonEquatableInt {

        // MARK: - Properties

        let value: Int

    }

}
