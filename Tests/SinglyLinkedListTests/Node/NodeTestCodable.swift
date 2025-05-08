//
//  NodeTestCodable.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 18.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import Foundation
import SinglyLinkedList
import Testing

struct NodeTestCodable {

    // MARK: - Methods

    @Test
    func decoding_encodedNode_resultsInSameNode() throws {
        let node1 = SinglyLinkedListNode(payload: 2)
        let node0 = SinglyLinkedListNode(payload: 1, nextNode: node1)

        let nodeData = try JSONEncoder().encode(node0)
        let decodedNode = try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: nodeData)
        #expect(decodedNode == node0)
    }

    @Test
    func decoding_validData_doNotThrowError() throws {
        let jsonString = """
                         {
                           "payload" : 1,
                           "nextNode" : {
                             "payload" : 2
                           }
                         }
                         """
        let jsonStringData = try #require(jsonString.data(using: .utf8))

        #expect(throws: Never.self) { try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: jsonStringData) }
    }

    @Test
    func decoding_validData_andExtraField_doNotThrowError() throws {
        let jsonString = """
                         {
                           "payload" : 1,
                           "nextNode" : {
                             "payload" : 2,
                             "unknown" : "unsupported"
                           }
                         }
                         """
        let jsonStringData = try #require(jsonString.data(using: .utf8))

        #expect(throws: Never.self) { try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: jsonStringData) }
    }

    @Test
    func decoding_invalidData_throwError() throws {
        let jsonString = """
                         {
                           "payload" : 1,
                           "nextNode" : {
                           }
                         }
                         """
        let jsonStringData = try #require(jsonString.data(using: .utf8))

        #expect(throws: Error.self) { try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: jsonStringData) }
    }

    @Test
    func decoding_validData_resultsInNode_withEncodedPayload() throws {
        let payload = 1
        let jsonString = """
                         {
                           "payload" : \(payload),
                           "nextNode" : {
                             "payload" : 2
                           }
                         }
                         """

        let jsonStringData = try #require(jsonString.data(using: .utf8))
        let node = try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: jsonStringData)

        #expect(node.payload == payload)
    }

    @Test
    func decoding_validData_resultsInNode_withEncodedNextNode() throws {
        let nextNodePayload = 2
        let jsonString = """
                         {
                           "payload" : 1,
                           "nextNode" : {
                             "payload" : \(nextNodePayload)
                           }
                         }
                         """

        let jsonStringData = try #require(jsonString.data(using: .utf8))
        let node = try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: jsonStringData)

        #expect(node.nextNode?.payload == nextNodePayload)
    }

}
