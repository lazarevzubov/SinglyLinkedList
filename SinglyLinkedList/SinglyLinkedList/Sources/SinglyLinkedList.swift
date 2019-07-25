//
//  SinglyLinkedList.swift
//  SinglyLinkedList
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

/**
 Data structure that represents a set of nodes.
 Every node contains a payload and a link to the next node in the list (if it's not the last one).
 */
public struct SinglyLinkedList<T> {
    
    /// First node of the list.
    public var firstNode: Node<T>?
    
    // Explicitly public initializer.
    /**
     Initializes singly linked list instance.
     - parameter firstNode: First node of the list. Nil value corresponds to an empty list.
     */
    public init(firstNode: Node<T>?) {
        self.firstNode = firstNode
    }
    
}

// MARK: - CustomStringConvertible

extension SinglyLinkedList: CustomStringConvertible where T == CustomStringConvertible {
    
    // MARK: - Properties
    
    // MARK: CustomStringConvertible protocol properties
    
    public var description: String {
        var description = "List"
        if firstNode != nil {
            description += " has nodes:\n"
            
            var node = firstNode
            while node != nil {
                description += (node!.description + "\n")
                node = node!.nextNode
            }
            
            return description
        } else {
            return description + " has no nodes."
        }
    }
    
}
