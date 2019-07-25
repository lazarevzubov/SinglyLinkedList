//
//  Node.swift
//  SinglyLinkedList
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

/// Type that represents one singly linked list node.
public final class Node<T> {
    
    // MARK: - Properties
    
    /// Payload of the node.
    public let payload: T
    /// Link to the next node in the list. Nil value means that this node is the last.
    public var nextNode: Node<T>?
    
    // MARK: - Initialization
    
    /**
     Initializes singly linked list node instance.
     
     - Parameters:
        - payload: Payload of the node.
        - nextNode: Link to the next node in the list. Nil value (which is default) means that this node is the last.
     */
    public init(payload: T, nextNode: Node<T>? = nil) {
        self.payload = payload
        self.nextNode = nextNode
    }
    
}

// MARK: - CustomStringConvertible

extension Node: CustomStringConvertible where T == CustomStringConvertible {
    
    // MARK: - Properties
    
    // MARK: CustomStringConvertible protocol properties
    
    public var description: String {
        let firstPart = """
        Node \(Unmanaged.passUnretained(self).toOpaque()) has id \(payload) and
        """
        if let nextNode = nextNode {
            return firstPart + " next node \(nextNode.payload)."
        } else {
            return firstPart + " no next node."
        }
    }
    
}
