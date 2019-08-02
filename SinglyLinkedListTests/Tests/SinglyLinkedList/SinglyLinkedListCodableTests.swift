//
//  SinglyLinkedListCodableTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class SinglyLinkedListCodableTests: XCTestCase {

    // MARK: - Methods

    func testCodable() {
        let node3 = Node(payload: 3)
        let node2 = Node(payload: 2, nextNode: node3)
        let node1 = Node(payload: 1, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        // TODO: Re-write after XCTest helpers are improved.
        let listData = try! JSONEncoder().encode(list)
        let decodedList = try! JSONDecoder().decode(SinglyLinkedList<Int>.self, from: listData)
        XCTAssertEqual(list, decodedList, "The decoded list doesn't equal the list it was initially created form.")

        let jsonString = "{\"boxedFirstNode\":{\"reference\":{\"value\":{\"payload\":1,\"nextNode\":{\"payload\":2,\"nextNode\":{\"payload\":3}}}}}}"
        let jsonStringData = jsonString.data(using: .utf8)!
        assertNoThrow(try JSONDecoder().decode(SinglyLinkedList<Int>.self, from: jsonStringData), "JSON decoder thrown an error while decoding a knowingly valid list data.") {
            XCTAssertEqual(list, $0, "The decoded from string list doesn't equal the list it was initially created form.")
        }
    }

    func testMalformedData() {
        let erroneousJSONString1 = "{\"firstNode\":{\"bayload\":1,\"nextNode\":{\"payload\":2,\"nextNode\":{\"payload\":3}}}}"
        let erroneousJSONStringData1 = erroneousJSONString1.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(SinglyLinkedList<Int>.self, from: erroneousJSONStringData1),
                             "A field with a typo doesn't raise an error while decoding.")

        let erroneousJSONString2 = "{\"firstNode\":{}}"
        let erroneousJSONStringData2 = erroneousJSONString2.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(SinglyLinkedList<Int>.self, from: erroneousJSONStringData2),
                             "A JSON with a mismatched structure doesn't raise an error while decoding.")
    }

    func testExtraField() {
        let erroneousJSONString3 = """
{\"boxedFirstNode\":{\"reference\":{\"value\":{\"payload\":1,\"nextNode\":{\"payload\":2,\"nextNode\":{\"payload\":3}}}}},\"unknownField\":0}
"""
        let erroneousJSONStringData3 = erroneousJSONString3.data(using: .utf8)!

        XCTAssertNoThrow(try JSONDecoder().decode(SinglyLinkedList<Int>.self, from: erroneousJSONStringData3), "A JSON with an extra field raised an error.")
    }

}
