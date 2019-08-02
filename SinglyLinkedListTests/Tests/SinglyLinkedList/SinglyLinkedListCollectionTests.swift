//
//  SinglyLinkedListCollectionTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class SinglyLinkedListCollectionTests: XCTestCase {

    // MARK: - Methods

    func testSubscript() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        
        XCTAssertEqual(list[0], firstNode)
        XCTAssertEqual(list[1], secondNode)
        XCTAssertEqual(list[2], thirdNode)
        
        // TODO: Test index out of range after improvements.
    }

    func testFormIndex() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let startingValue = 0
        let offset = 1

        var index = startingValue
        list.formIndex(&index, offsetBy: offset)
        XCTAssertEqual(index, startingValue + offset, "Resulted index value doesn't equal a sum of initial index value and offset.")
    }

    func testLimitedFormIndex() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let startingValue = 0
        let offset = 1
        let limit = 1
        var index = startingValue

        XCTAssertTrue(list.formIndex(&index, offsetBy: offset, limitedBy: limit), "Resulted index is limited by a vlue less than a passed one.")
        XCTAssertEqual(index, startingValue + offset, "Resulted index value doesn't equal a sum of initial index value and offset.")

        XCTAssertFalse(list.formIndex(&index, offsetBy: offset, limitedBy: limit), "Resulted index is limited by a vlue higher than a passed one.")
    }

    func testUnderestimatedCount() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        XCTAssertEqual(list.underestimatedCount, 3, "The list's underestimated count is different from the nodes count.")

        let emptyList = SinglyLinkedList<String>()
        XCTAssertEqual(emptyList.underestimatedCount, 0, "An empty list's underestimated count is not zero.")
    }

    func testCount() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        XCTAssertEqual(list.count, 3, "The list's count is different from the actual nodes number.")

        let emptyList = SinglyLinkedList<String>()
        XCTAssertEqual(emptyList.count, 0, "An empty list's count is not zero.")
    }

    func testFirst() {
        let emptyList = SinglyLinkedList<Int>()
        XCTAssertNil(emptyList.first, "The list initialized as empty unexpectedly has a first node.")

        let secondNode = Node(payload: 2)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        XCTAssertEqual(list.first, firstNode, "First node doesn't match the node which the list was initialized with.")
    }

    func testEmpty() {
        let emptyList = SinglyLinkedList<Int>()
        XCTAssertTrue(emptyList.isEmpty, "Empty list is unexpectedly not empty.")

        let secondNode = Node(payload: 2)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        XCTAssertFalse(list.isEmpty, "A list with two nodes is unexpectedly not empty.")
    }
    
    func testDistance() {
        let list = SinglyLinkedList<Int>()

        let firstIndex = 0
        XCTAssertEqual(list.distance(from: firstIndex, to: firstIndex), 0, "The distance between an index and itself is not zero.")

        let secontIndex = 10
        XCTAssertEqual(list.distance(from: firstIndex, to: secontIndex), secontIndex - firstIndex, "The distance between two indices doesn't equal its values difference.")
    }

    func testFirstIndexOf() {
        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.firstIndex(of: firstNode), 0, "Index of the first node is not 0.")
        XCTAssertEqual(list.firstIndex(of: secondNode), 1, "Index of the second node is not 1.")
        XCTAssertEqual(list.firstIndex(of: thirdNode), list.count - 1, "Index of the last node is not the list's count minus 1.")

        let otherNode = Node(payload: 4)
        XCTAssertNil(list.firstIndex(of: otherNode), "An index of node which isn't conteined in the list is not nil.")
    }

    func testFirstIndexWhere() {
        let thirdPayload = 3
        let thirdNode = Node(payload: thirdPayload)
        let secondPayload = 2
        let secondNode = Node(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = Node(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        XCTAssertEqual(list.firstIndex { $0.payload == firstPayload }, 0, "Index of the node with a condition matching the first node is not 0.")
        XCTAssertEqual(list.firstIndex { $0.payload == secondPayload }, 1, "Index of the node with a condition matching the second node is not 1")
        XCTAssertEqual(list.firstIndex { $0.payload == thirdPayload },
                       list.count - 1,
                       "Index of the node with a condition matching the last node is not the list's count minus 1.")

        let otherPayload = 4
        _ = Node(payload: otherPayload)
        XCTAssertNil(list.firstIndex { $0.payload == otherPayload }, "An index of a node which conditions doesn't match the list is not nil.")
    }

    func testFormIndexAfter() {
        let list = SinglyLinkedList<Int>()

        let indexAfterValue = 1
        var indexAfter = indexAfterValue
        list.formIndex(after: &indexAfter)
        XCTAssertEqual(indexAfter, indexAfterValue + 1, #"Formed "index after" doesn't equal initial plus 1."#)
    }
    
    func testIndexOffsetBy() {
        let list = SinglyLinkedList<Int>()

        let initialIndex = 1
        let expectedIndex = 10
        XCTAssertEqual(list.index(initialIndex, offsetBy: 0), initialIndex, "Result of zero offset index doesn't equal the initial index.")
        XCTAssertEqual(list.index(initialIndex, offsetBy: expectedIndex - initialIndex), expectedIndex, "Result of offset index doesn't equal the initial index plus offset.")
    }

    func testIndexOffsetByLimitedBy() {
        let list = SinglyLinkedList<Int>()

        let initialIndex = 1
        let offset = 5
        let expectedIndex = initialIndex + offset
        XCTAssertEqual(list.index(initialIndex, offsetBy: offset, limitedBy: expectedIndex + 1),
                       expectedIndex,
                       "Result of offset index doesn't equal the initial index plus offset.")
        XCTAssertEqual(list.index(initialIndex, offsetBy: offset, limitedBy: expectedIndex),
                       expectedIndex,
                       "Result of offset index doesn't equal the initial index plus offset.")
        XCTAssertNil(list.index(initialIndex, offsetBy: offset, limitedBy: expectedIndex - 1), "Result of offset index isn't nil if offset goes beyond a limit.")
    }

    func testPrefixThrough() {
        let fourthPayload = 4
        let fourthNode = Node(payload: fourthPayload)
        let thirdPayload = 3
        let thirdNode = Node(payload: thirdPayload, nextNode: fourthNode)
        let secondPayload = 2
        let secondNode = Node(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = Node(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let index = 2
        let prefix = list.prefix(through: index)
        let result = SinglyLinkedList(prefix)

        let expectedThirdNode = Node(payload: thirdPayload)
        let expectedSecondNode = Node(payload: secondPayload, nextNode: expectedThirdNode)
        let expectedFirstNode = Node(payload: firstPayload, nextNode: expectedSecondNode)
        let expectedList = SinglyLinkedList(firstNode: expectedFirstNode)

        XCTAssertEqual(result,
                       expectedList,
                       #"The resulting list of the "prefix-through" call is not equal the list with initial list's start index and the passed value as the end index."#)
    }

    func testPrefixUpTo() {
        let fourthPayload = 4
        let fourthNode = Node(payload: fourthPayload)
        let thirdPayload = 3
        let thirdNode = Node(payload: thirdPayload, nextNode: fourthNode)
        let secondPayload = 2
        let secondNode = Node(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = Node(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let index = 2
        let prefix = list.prefix(upTo: index)
        let result = SinglyLinkedList(prefix)

        let expectedSecondNode = Node(payload: secondPayload)
        let expectedFirstNode = Node(payload: firstPayload, nextNode: expectedSecondNode)
        let expectedList = SinglyLinkedList(firstNode: expectedFirstNode)

        XCTAssertEqual(result,
                       expectedList,
                       #"The resulting list of the "prefix-up-to" call is not equal the list with initial list's start index and the passed value minus one as the end index."#)
    }

    func testPrefixWhile() {
        let fourthPayload = 4
        let fourthNode = Node(payload: fourthPayload)
        let thirdPayload = 3
        let thirdNode = Node(payload: thirdPayload, nextNode: fourthNode)
        let secondPayload = 2
        let secondNode = Node(payload: secondPayload, nextNode: thirdNode)
        let firstPayload = 1
        let firstNode = Node(payload: firstPayload, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)
        
        let prefix = list.prefix { $0.payload < thirdPayload }
        let result = SinglyLinkedList(prefix)
        
        let expectedSecondNode = Node(payload: secondPayload)
        let expectedFirstNode = Node(payload: firstPayload, nextNode: expectedSecondNode)
        let expectedList = SinglyLinkedList(firstNode: expectedFirstNode)
        
        XCTAssertEqual(result,
                       expectedList,
                       #"The resulting list of the "prefix-up-to" call is not equal the list with initial list's start index and the index of the last node satisfying the condition as the end index."#)
    }

    func testSuffixFrom() {
        let fourthNode = Node(payload: 4)
        let thirdNode = Node(payload: 3, nextNode: fourthNode)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        let index = 2
        let suffix = list.suffix(from: index)
        let result = SinglyLinkedList(suffix)

        let expectedResult = SinglyLinkedList(firstNode: list[index])

        XCTAssertEqual(result,
                       expectedResult,
                       #"The resulting list of the "suffix-from" call doesn't equal the list with the initial list's node of passed index as a start and the initial list's end index as an end index."#)
    }

    func testRandomElement() {
        struct Generator: RandomNumberGenerator {

            // MARK: - Properties

            let randomIndex = 2

            // MARK: - Methods

            // MARK: RandomNumberGenerator protocol methods

            func next() -> UInt64 {
                return UInt64(randomIndex)
            }

        }

        // MARK: -

        let thirdNode = Node(payload: 3)
        let secondNode = Node(payload: 2, nextNode: thirdNode)
        let firstNode = Node(payload: 1, nextNode: secondNode)
        let list = SinglyLinkedList(firstNode: firstNode)

        var generator = Generator()
        XCTAssertEqual(list.randomElement(using: &generator),
                       list[generator.randomIndex],
                       "The result of random element picking doesn't equalt the node with the index that equals random number generator output.")
    }

}
