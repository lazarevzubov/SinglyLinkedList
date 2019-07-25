//
//  Node.swift
//  SinglyLinkedList
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

/**
 Type that represents one singly linked list node.
 
 Provides `Equatable` and `Comparable` protocol conformity for payload types which conform to `Equatable` and `Comparable` respectively.
 It is based on payload equality and comparability respectively and doesn't take in account the next node.
 */
public final class Node<T>: NSCopying {

    // MARK: - Properties

    /// Payload of the node.
    public var payload: T
    /// Link to the next node in the sequence. Nil value means that this node is the last.
    public var nextNode: Node<T>?

    // MARK: - Initialization

    /**
     Initializes a singly linked list node instance.
     - Parameters:
        - payload: The payload of the node.
        - nextNode: The link to the next node in the sequence. Nil value (which is default) means that this node is the last.
     */
    public init(payload: T, nextNode: Node<T>? = nil) {
        self.payload = payload
        self.nextNode = nextNode
    }

    // MARK: - Methods

    // MARK: NSCopying protocol methods

    public func copy(with zone: NSZone? = nil) -> Any {
        return Node(payload: payload, nextNode: nextNode?.copy() as? Node<T>)
    }

}

// MARK: - Equatable

extension Node: Equatable where T: Equatable {

    // MARK: - Methods

    // MARK: Equatable protocol methods

    public static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.payload == rhs.payload
    }

}

// MARK: - Comparable

extension Node: Comparable where T: Comparable {

    // MARK: - Methods

    // MARK: Equatable protocol methods

    public static func < (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.payload < rhs.payload
    }

}

// MARK: - Codable

extension Node: Codable where T: Codable { }

// MARK: - CustomStringConvertible

extension Node: CustomStringConvertible where T: CustomStringConvertible {

    // MARK: - Properties

    // MARK: CustomStringConvertible protocol properties

    public var description: String {
        let firstPart = "The node \(Unmanaged.passUnretained(self).toOpaque()) has the payload \(payload) and"
        if let nextNode = nextNode { return firstPart + " the next node with the payload \(nextNode.payload)." }

        return firstPart + " no next node."
    }

}
