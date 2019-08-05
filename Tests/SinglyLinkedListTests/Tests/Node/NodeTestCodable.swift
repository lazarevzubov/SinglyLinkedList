//
//  NodeTestCodable.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import SinglyLinkedList
import XCTest

final class NodeTestCodable: XCTestCase {

    // MARK: - Methods

    func testEncodeDecode() {
        let payload2 = 2
        let node2 = SinglyLinkedListNode(payload: payload2)
        let payload1 = 1
        let node1 = SinglyLinkedListNode(payload: payload1, nextNode: node2)

        // TODO: Re-write after XCTest helpers are improved.
        let nodeData = try! JSONEncoder().encode(node1)
        let decodedNode = try! JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: nodeData)
        XCTAssertEqual(node1, decodedNode, "The decoded node doesn't equal the node it was initially created form.")

        let jsonString = "{\"payload\":1,\"nextNode\":{\"payload\":2}}"
        let jsonStringData = jsonString.data(using: .utf8)!
        assertNoThrow(try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: jsonStringData), "JSON decoder thrown an error while decoding a knowingly valid Node data.") {
            XCTAssertEqual(node1, $0, "The decoded from string node doesn't equal the node it was initially created form.")
        }

        let erroneousJSONString1 = "{\"bayload\":1,\"nextNode\":{\"payload\":2}}"
        let erroneousJSONStringData1 = erroneousJSONString1.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: erroneousJSONStringData1), "A field with a typo doesn't raise an error while deconding.")

        let erroneousJSONString2 = "{\"payload\":1,\"nextNode\":{}}"
        let erroneousJSONStringData2 = erroneousJSONString2.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: erroneousJSONStringData2), "A JSON with a mismatched structure doesn't raise an error while deconding.")

        let erroneousJSONString3 = "{\"payload\":1,\"nextNode\":{\"payload\":2,\"unknown\":0}}"
        let erroneousJSONStringData3 = erroneousJSONString3.data(using: .utf8)!
        XCTAssertNoThrow(try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: erroneousJSONStringData3), "A JSON with an extra field raised an error.")
    }

}
