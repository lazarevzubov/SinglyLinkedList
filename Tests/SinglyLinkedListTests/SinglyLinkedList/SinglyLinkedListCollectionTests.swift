//
//  SinglyLinkedListCollectionTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import Testing

struct SinglyLinkedListCollectionTests {

    // TODO: Test index out of range after improvements.

    // MARK: - Methods

    @Test
    func subscript_pointsToCorrectNodes() {
        let node2 = SinglyLinkedListNode(payload: 3)
        let node1 = SinglyLinkedListNode(payload: 2, nextNode: node2)
        let node0 = SinglyLinkedListNode(payload: 1, nextNode: node1)
        let list = SinglyLinkedList(firstNode: node0)

        #expect(list[0] === node0)
        #expect(list[1] === node1)
        #expect(list[2] === node2)
    }

    @Test
    func formIndex_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        let startingValue = 0
        let offset = 1

        var index = startingValue
        list.formIndex(&index, offsetBy: offset)

        #expect(index == (startingValue + offset))
    }

    @Test
    func formIndex_withLimit_worksAsExpected() {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        let startingValue = 0
        let offset = 1
        let limit = 1
        var index = startingValue

        #expect(list.formIndex(&index, offsetBy: offset, limitedBy: limit) == true)
        #expect(index == (startingValue + offset))

        #expect(list.formIndex(&index, offsetBy: offset, limitedBy: limit) == false)
    }

    @Test
    func underestimatedCount_whenList_haveThreeNodes_isLessThanFour() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        #expect(list.underestimatedCount <= 3)
    }

    @Test
    func underestimatedCount_whenList_isEmpty_isLessThanOne() {
        let emptyList = SinglyLinkedList<String>()
        #expect(emptyList.underestimatedCount <= 0)
    }

    @Test
    func count_whenList_haveThreeNodes_isThree() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        #expect(list.count == 3)
    }

    @Test
    func count_whenList_isEmpty_isZero() {
        let emptyList = SinglyLinkedList<String>()
        #expect(emptyList.count == 0)
    }

    @Test
    func first_whenList_isEmpty_isNil() {
        let emptyList = SinglyLinkedList<Int>()
        #expect(emptyList.first == nil)
    }

    @Test
    func first_whenList_isNotEmpty_isFirstNode() {
        let secondNode = SinglyLinkedListNode(payload: 2)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        #expect(list.first === firstNode)
    }

    @Test
    func isEmpty_whenListIsEmpty_isTrue() {
        let emptyList = SinglyLinkedList<Int>()
        #expect(emptyList.isEmpty)
    }

    @Test
    func isEmpty_whenListIsNotEmpty_isFalse() {
        let secondNode = SinglyLinkedListNode(payload: 2)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        #expect(list.isEmpty == false)
    }

    @Test
    func distance_betweenSameIndices_isZero() {
        let list = SinglyLinkedList<Int>()

        let firstIndex = 0
        #expect(list.distance(from: firstIndex, to: firstIndex) == 0)
    }

    @Test
    func distance_betweenDifferentIndices_isDifferenceBetweenIndices() {
        let list = SinglyLinkedList<Int>()

        let firstIndex = 0
        let secondIndex = 10

        #expect(list.distance(from: firstIndex, to: secondIndex) == secondIndex - firstIndex)
    }

    @Test
    func firstIndex_pointsToCorrectIndex() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        #expect(list.firstIndex(of: secondNode) == 1)
    }

    @Test
    func firstIndex_ofUnrelatedNode_isNil() {
        let thirdNode = SinglyLinkedListNode(payload: 3)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let otherNode = SinglyLinkedListNode(payload: 4)
        #expect(list.firstIndex(of: otherNode) == nil)
    }

    @Test
    func firstIndexWhere_pointsToCorrectIndex() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)

        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)

        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)

        let list = SinglyLinkedList(firstNode: firstNode)

        #expect(list.firstIndex { $0.payload == secondPayload } == 1)
    }

    @Test
    func firstIndexWhere_ofUnrelatedNode_isNil() {
        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload)

        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)

        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)

        let list = SinglyLinkedList(firstNode: firstNode)

        let otherPayload = 4
        _ = SinglyLinkedListNode(payload: otherPayload)

        #expect(list.firstIndex { $0.payload == otherPayload } == nil)
    }

    @Test
    func formIndexAfter() {
        let list = SinglyLinkedList<Int>()

        let indexAfterValue = 1
        var indexAfter = indexAfterValue
        list.formIndex(after: &indexAfter)

        #expect(indexAfter == (indexAfterValue + 1))
    }

    @Test
    func indexOffsetBy_withZeroOffset_isInitialIndex() {
        let list = SinglyLinkedList<Int>()

        let initialIndex = 1
        #expect(list.index(initialIndex, offsetBy: 0) == initialIndex)
    }

    @Test
    func indexOffsetBy_withNonZeroOffset_pointsToCorrectIndex() {
        let list = SinglyLinkedList<Int>()

        let initialIndex = 1
        let expectedIndex = 10

        #expect(list.index(initialIndex, offsetBy: expectedIndex - initialIndex) == expectedIndex)
    }

    @Test
    func indexOffset_limitedByHigherValue_pointsToExactIndex() {
        let list = SinglyLinkedList<Int>()

        let initialIndex = 1
        let offset = 5
        let expectedIndex = initialIndex + offset

        #expect(list.index(initialIndex, offsetBy: offset, limitedBy: expectedIndex + 1) == expectedIndex)
    }

    @Test
    func indexOffset_limitedBySameValue_pointsToExactIndex() {
        let list = SinglyLinkedList<Int>()

        let initialIndex = 1
        let offset = 5
        let expectedIndex = initialIndex + offset

        #expect(list.index(initialIndex, offsetBy: offset, limitedBy: expectedIndex) == expectedIndex)
    }

    @Test
    func indexOffset_limitedByLowerValue_isNil() {
        let list = SinglyLinkedList<Int>()

        let initialIndex = 1
        let offset = 5
        let expectedIndex = initialIndex + offset

        #expect(list.index(initialIndex, offsetBy: offset, limitedBy: expectedIndex - 1) == nil)
    }

    @Test
    func prefixThrough() {
        let fourthPayload = 4
        let fourthNode = SinglyLinkedListNode(payload: fourthPayload)

        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload, nextNode: fourthNode)

        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)

        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)

        let list = SinglyLinkedList(firstNode: firstNode)

        let index = 2
        let prefix = list.prefix(through: index)
        let result = SinglyLinkedList(prefix)

        let expectedThirdNode = SinglyLinkedListNode(payload: thirdPayload)
        let expectedSecondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: expectedThirdNode)
        let expectedFirstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: expectedSecondNode)
        let expectedList = SinglyLinkedList(firstNode: expectedFirstNode)

        #expect(result == expectedList)
    }

    @Test
    func prefixUpTo() {
        let fourthPayload = 4
        let fourthNode = SinglyLinkedListNode(payload: fourthPayload)

        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload, nextNode: fourthNode)

        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)

        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)

        let list = SinglyLinkedList(firstNode: firstNode)

        let index = 2
        let prefix = list.prefix(upTo: index)
        let result = SinglyLinkedList(prefix)

        let expectedSecondNode = SinglyLinkedListNode(payload: secondPayload)
        let expectedFirstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: expectedSecondNode)
        let expectedList = SinglyLinkedList(firstNode: expectedFirstNode)

        #expect(result == expectedList)
    }

    @Test
    func prefixWhile() {
        let fourthPayload = 4
        let fourthNode = SinglyLinkedListNode(payload: fourthPayload)

        let thirdPayload = 3
        let thirdNode = SinglyLinkedListNode(payload: thirdPayload, nextNode: fourthNode)

        let secondPayload = 2
        let secondNode = SinglyLinkedListNode(payload: secondPayload, nextNode: thirdNode)

        let firstPayload = 1
        let firstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        
        let prefix = list.prefix { $0.payload < thirdPayload }
        let result = SinglyLinkedList(prefix)
        
        let expectedSecondNode = SinglyLinkedListNode(payload: secondPayload)
        let expectedFirstNode = SinglyLinkedListNode(payload: firstPayload, nextNode: expectedSecondNode)
        let expectedList = SinglyLinkedList(firstNode: expectedFirstNode)
        
        #expect(result == expectedList)
    }

    @Test
    func suffixFrom() {
        let fourthNode = SinglyLinkedListNode(payload: 4)
        let thirdNode = SinglyLinkedListNode(payload: 3, nextNode: fourthNode)
        let secondNode = SinglyLinkedListNode(payload: 2, nextNode: thirdNode)
        let firstNode = SinglyLinkedListNode(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let index = 2
        let suffix = list.suffix(from: index)
        let result = SinglyLinkedList(suffix)

        let expectedResult = SinglyLinkedList(firstNode: list[index])

        #expect(result == expectedResult)
    }

}
