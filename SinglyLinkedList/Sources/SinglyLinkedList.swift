//
//  SinglyLinkedList.swift
//  SinglyLinkedList
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

/**
 A data structure which represents a collection of nodes.
 
 Every node contains a payload and a link to the next node in the list (except for the last one).
 
 Subscript access has an O(k) complexity, where k is a number of an accessed element.
 Finding an end index has O(n) complexity where n is a nodes number.
 
 Provides `Equatable` protocol conformity for node types which conform to `Equatable`. It is based on nodes equality and nodes order.
 */
public struct SinglyLinkedList<T> {

    // MARK: - Properties

    /**
     The first node of the list.
     - warning: Setting new value explicitly not inserts the node at the beginning, but replaces the entire sequence.
     */
    public var firstNode: Node<T>?

    // MARK: - Initialization

    // Explicitly public initializer.
    /**
     Initializes a singly linked list instance.

     Creates an empty list is `nil` is passed as the first node.

     - parameter firstNode: The first node of the list. Nil value corresponds to an empty list.
     */
    public init(firstNode: Node<T>? = nil) {
        self.firstNode = firstNode
    }

    // MARK: - Methods

    /**
     Returns the very last node of the list or `nil` if the list is empty.

     Complexity – O(n) where n is a nodes count.

     - returns: The last node of the list or `nil` if the list is empty.
     */
    public func lastNode() -> Node<T>? {
        guard let firstNode = firstNode else { return nil }

        var lastNode = firstNode
        var nextNode = lastNode.nextNode
        while nextNode != nil {
            lastNode = nextNode!
            nextNode = lastNode.nextNode
        }

        return lastNode
    }

    /**
     Inserts a new node at the beginning of the list. Thus, previous first node becomes the second.

     Properly handles the situation when the list is initially empty (as the result the list contains the inserted node only).

     Complexity – O(1).

     - parameter newNode: A new node to be inserted at the beginnging of the list.
     */
    public mutating func insertAtBeginning(_ newNode: Node<T>) {
        newNode.nextNode = firstNode
        firstNode = newNode
    }

    /**
     Inserts a new node after a specified one.

     Doesn't handle the situation when the specified node is not a part of the current list. The method will add the node at the specified place anyway.

     Complexity – O(1).

     - Parameters:
        - newNode: A node to be inserted.
        - node: A node after which the new node must be inserted.
     */
    public func insert(_ newNode: Node<T>, after node: Node<T>) {
        newNode.nextNode = node.nextNode
        node.nextNode = newNode
    }

    /**
     Inserts a new node at the end of the list.

     Properly handles the situation when the list is initially empty (as the result the list contains the inserted node only).

     Complexity – O(n) where n is a nodes count, or O(1) if the list is empty.

     - parameter newNode: A new node to be inserted at the end of the list.
     */
    public mutating func insertAtEnd(_ newNode: Node<T>) {
        if let lastNode = lastNode() {
            insert(newNode, after: lastNode)
        } else {
            insertAtBeginning(newNode)
        }
    }

    /**
     Deletes the first node of the list.

     Properly handles the situation when the list is initially empty or have the only node.

     Complexity – O(1).
     */
    public mutating func removeFirst() {
        firstNode = firstNode?.nextNode
    }

    /**
     Removes a node after a specified one.

     Doesn't handle the situation when the specified node is not a part of the current list. The method will remove the node at the specified place anyway.

     Complexity – O(1).
     */
    public func remove(after node: Node<T>) {
        node.nextNode = node.nextNode?.nextNode
    }

    /**
     Deletes the last node of the list.

     Properly handles the situation when the list is initially empty or have the only node.

     Complexity – O(n) where n is the nodes number.
     */
    public mutating func removeLast() {
        guard var currentNode = firstNode else { return }
        guard var nextNode = currentNode.nextNode else {
            removeFirst()
            return
        }

        while nextNode.nextNode != nil {
            currentNode = nextNode
            nextNode = currentNode.nextNode!
        }
        currentNode.nextNode = nil
    }

}

// MARK: - Equatable

extension SinglyLinkedList: Equatable where T: Equatable {

    // MARK: - Methods

    // MARK: Equatable protocol methods

    public static func == (lhs: SinglyLinkedList<T>, rhs: SinglyLinkedList<T>) -> Bool {
        var lhsCurrentNode = lhs.firstNode
        var rhsCurrentNode = rhs.firstNode

        while lhsCurrentNode != nil && rhsCurrentNode != nil {
            if lhsCurrentNode != rhsCurrentNode {
                return false
            }
            
            lhsCurrentNode = lhsCurrentNode?.nextNode
            rhsCurrentNode = rhsCurrentNode?.nextNode
        }

        return lhsCurrentNode == rhsCurrentNode
    }

}

// MARK: - Codable

extension SinglyLinkedList: Codable where T: Codable { }

// MARK: - Sequence

extension SinglyLinkedList: Sequence {

    public typealias Element = Node<T>
    public typealias Iterator = SinglyLinkedListIterator<T>

    // MARK: - Initialization

    /**
     Creates a new instance from the result of a `drop(while:)` call.
     - parameter dropWhileSequence: The result of a `drop(while:)` call.
     */
    public init(_ dropWhileSequence: DropWhileSequence<Self>) {
        var iterator = dropWhileSequence.makeIterator()
        self = SinglyLinkedList(firstNode: iterator.next())
    }
    
    /**
     Creates a new instance from the result of a `dropFirst(_:)` call.
     - parameter dropFirstSequence: The result of a `dropFirst(_:)` call.
     */
    public init(_ dropFirstSequence: DropFirstSequence<Self>) {
        var iterator = dropFirstSequence.makeIterator()
        self = SinglyLinkedList(firstNode: iterator.next())
    }

    /**
     Creates a new instance from the result of a `prefix(_:)` call.
     - parameter prefixSequence: The result of a `prefix(_:)` call.
     */
    public init(_ prefixSequence: PrefixSequence<Self>) {
        var iterator = prefixSequence.makeIterator()
        self = SinglyLinkedList(firstNode: iterator.next())
    }

    // MARK: - Methods

    // MARK: Sequence protocol methods

    public func makeIterator() -> SinglyLinkedListIterator<T> {
        return SinglyLinkedListIterator(list: self)
    }

    public __consuming func prefix(_ maxLength: Int) -> PrefixSequence<SinglyLinkedList<T>> {
        let result = SinglyLinkedList(firstNode: firstNode?.copy() as? Node<T>)
        for (index, node) in result.enumerated() {
            if index + 1 == maxLength {
                node.nextNode = nil
                break
            }
        }

        return PrefixSequence(result, maxLength: maxLength)
    }

}

// MARK: - Collection

extension SinglyLinkedList: Collection {
    
    // Some `Collection` requirements are covered by `Sequence` protocol conformance.
    
    public typealias Index = Int

    public subscript(position: Int) -> Node<T> {
        _read {
            var result: Element? = nil
            for (index, node) in enumerated() {
                if index == position {
                    result = node
                    break
                }
            }

            // TODO: Make it testable.
            guard let unwrappedResult = result else {
                fatalError("Index out of range.")
            }

            yield unwrappedResult
        }
    }

    // MARK: - Properties

    // MARK: Collection protocol properties

    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        if firstNode == nil {
            return startIndex
        }

        var lastIndex = 0
        for (index, _) in enumerated() {
            lastIndex = index
        }

        return lastIndex + 1
    }

    // MARK: - Methods

    // MARK: Collection protocol methods

    public func index(after i: Int) -> Int {
        return i + 1
    }

}

// MARK: - CustomStringConvertible

extension SinglyLinkedList: CustomStringConvertible where T: CustomStringConvertible {

    // MARK: - Properties

    // MARK: CustomStringConvertible protocol properties

    public var description: String {
        var description = "The list"
        if firstNode != nil {
            description += " has nodes:"

            var node = firstNode
            while node != nil {
                description += ("\n" + node!.description)
                node = node!.nextNode
            }

            return description
        }

        return description + " has no nodes."
    }

}

// MARK: -

public struct SinglyLinkedListIterator<T>: IteratorProtocol {

    public typealias Element = Node<T>

    // MARK: - Properties

    private(set) var list: SinglyLinkedList<T>

    // MARK: - Methods

    // MARK: IteratorProtocol protocol methods

    mutating public func next() -> Node<T>? {
        defer {
            list.removeFirst()
        }
        return list.firstNode
    }

}
