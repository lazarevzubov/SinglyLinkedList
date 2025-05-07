//
//  SinglyLinkedListCodableTests.swift
//  SinglyLinkedListTests
//
//  Created by lazarevzubov on 19.07.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import Foundation
import SinglyLinkedList
import Testing

struct SinglyLinkedListCodableTests {

    // MARK: - Methods

    @Test
    func decoding_encodedList_resultsInSameList() throws {
        let node3 = SinglyLinkedListNode(payload: 3)
        let node2 = SinglyLinkedListNode(payload: 2, nextNode: node3)
        let node1 = SinglyLinkedListNode(payload: 1, nextNode: node2)
        let list = SinglyLinkedList(firstNode: node1)

        let listData = try JSONEncoder().encode(list)
        let decodedList = try JSONDecoder().decode(SinglyLinkedList<Int>.self, from: listData)
        #expect(list == decodedList)
    }

    @Test
    func decoding_validData_doNotThrowError() throws {
        let jsonString = """
                         {
                           "firstNode" : {
                             "payload" : 1,
                             "nextNode" : {
                               "payload" : 2,
                               "nextNode" : {
                                 "payload" : 3
                               }
                             }
                           }
                         }
                         """
        let jsonStringData = try #require(jsonString.data(using: .utf8))

        #expect(throws: Never.self) { try JSONDecoder().decode(SinglyLinkedList<Int>.self, from: jsonStringData) }
    }

    @Test
    func decoding_validData_andExtraField_doNotThrowError() throws {
        let jsonString = """
                         {
                           "firstNode" : {
                             "payload" : 1,
                             "nextNode" : {
                               "payload" : 2,
                               "nextNode" : {
                                 "payload" : 3,
                                 "unknown" : "unsupported"
                               }
                             }
                           }
                         }
                         """
        let jsonStringData = try #require(jsonString.data(using: .utf8))

        #expect(throws: Never.self) { try JSONDecoder().decode(SinglyLinkedList<Int>.self, from: jsonStringData) }
    }

    @Test
    func decoding_invalidData_throwError() throws {
        let jsonString = """
                         {
                           "firstNode" : {
                             "Bayload" : 1,
                             "nextNode" : {
                               "payload" : 2,
                               "nextNode" : {
                                 "payload" : 3
                               }
                             }
                           }
                         }
                         """
        let jsonStringData = try #require(jsonString.data(using: .utf8))

        #expect(throws: Error.self) { try JSONDecoder().decode(SinglyLinkedListNode<Int>.self, from: jsonStringData) }
    }

}
