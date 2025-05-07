//
//  SinglyLinkedListNode.swift
//  SinglyLinkedList
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

import Foundation

/// A single singly linked list node.
///
/// Provides `Equatable` and `Comparable` methods for the cases when the payload type conforms to `Equatable` and `Comparable` respectively.
///   Functionality is based on payload equality and comparability respectively and doesn't take in account the next node.
public final class SinglyLinkedListNode<T>: NSCopying {

    // MARK: - Properties

    /// The payload of the node.
    public var payload: T
    /// A link to the next node in the sequence. `nil` means that this node is last.
    public var nextNode: SinglyLinkedListNode<T>?

    // MARK: - Initialization

    /// Creates a singly linked list node.
    /// - Parameters:
    ///   - payload: The payload of the node.
    ///   - nextNode: A link to the next node in the sequence. `nil` means that this node is last.
    public init(payload: T, nextNode: SinglyLinkedListNode<T>? = nil) {
        self.payload = payload
        self.nextNode = nextNode
    }

    // MARK: - Methods

    // MARK: NSCopying protocol methods

    public func copy(with zone: NSZone? = nil) -> Any {
        SinglyLinkedListNode(payload: payload, nextNode: nextNode?.copy() as? SinglyLinkedListNode<T>)
    }

}

// MARK: - Equatable

extension SinglyLinkedListNode: Equatable where T: Equatable {

    // MARK: - Methods

    // MARK: Equatable protocol methods

    public static func == (lhs: SinglyLinkedListNode<T>, rhs: SinglyLinkedListNode<T>) -> Bool {
        lhs.payload == rhs.payload
    }

}

// MARK: - Comparable

extension SinglyLinkedListNode: Comparable where T: Comparable {

    // MARK: - Methods

    // MARK: Equatable protocol methods

    public static func < (lhs: SinglyLinkedListNode<T>, rhs: SinglyLinkedListNode<T>) -> Bool {
        lhs.payload < rhs.payload
    }

}

// MARK: - Codable

extension SinglyLinkedListNode: Codable where T: Codable { }

// MARK: - CustomStringConvertible

extension SinglyLinkedListNode: CustomStringConvertible where T: CustomStringConvertible {

    // MARK: - Properties

    // MARK: CustomStringConvertible protocol properties

    public var description: String {
        let firstPart = "The node \(Unmanaged.passUnretained(self).toOpaque()) has the payload of \(payload) and"
        return if let nextNode {
            firstPart + " the next node with the payload of \(nextNode.payload)."
        } else {
            firstPart + " no next node."
        }
    }

}
