//
//  SinglyLinkedList.swift
//  SinglyLinkedList
//
//  Created by Nikita Lazarev-Zubov on 11.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

/// A data structure which represents a collection of nodes.
///
/// Every node contains a payload and a link to the next node in the list (except for the last one).
///
/// Subscript access has an O(k) time complexity, where k is a number of an accessed element.
///
/// Finding an end index has O(n) time complexity where n is the number of nodes.
///
/// Provides `Equatable` interface for node types which also conform to `Equatable`. It is based on nodes equality and their order.
public struct SinglyLinkedList<T> {

    // MARK: - Properties

    /// The first node of the list.
    /// - Warning: Setting new value explicitly not inserts the node at the beginning, but replaces the entire sequence.
    public var firstNode: SinglyLinkedListNode<T>?

    // MARK: - Initialization

    /// Creates a singly linked list.
    /// - Parameter firstNode: The first node in the list. `nil` value corresponds to an empty list.
    public init(firstNode: SinglyLinkedListNode<T>? = nil) {
        self.firstNode = firstNode
    }

    // MARK: - Methods

    /// Returns the last node in the list or `nil` if the list is empty.
    ///
    /// Time complexity—O(n), where n is the number of nodes
    ///
    /// - Returns: The last node in the list or `nil` if the list is empty.
    public func lastNode() -> SinglyLinkedListNode<T>? {
        var node = firstNode
        if node != nil {
            while node?.nextNode != nil {
                node = node?.nextNode
            }
        }

        return node
    }

    /// Inserts a new node at the beginning of the list. The previous first node becomes second.
    ///
    /// Properly handles the situation when the list is initially empty (as a result, the list contains the inserted node only).
    ///
    /// Time-complexity—O(1).
    ///
    /// - Parameter newNode: A new node to be inserted at the beginning of the list.
    public mutating func insertAtBeginning(_ newNode: SinglyLinkedListNode<T>) {
        newNode.nextNode = firstNode
        firstNode = newNode
    }

    /// Inserts a new node after a specified one.
    ///
    /// Doesn't handle the situation when the specified node is not a part of the current list. The method will add the node as the next node of the specified one.
    ///
    /// Time-complexity—O(1).
    ///
    /// - Parameters:
    ///   - newNode: The node to be inserted.
    ///   - node: The node, after which the new node must be inserted.
    public func insert(_ newNode: SinglyLinkedListNode<T>, after node: SinglyLinkedListNode<T>) {
        newNode.nextNode = node.nextNode
        node.nextNode = newNode
    }

    /// Inserts a new node at the end of the list.
    ///
    /// Properly handles the situation when the list is initially empty (as a result, the list contains the inserted node only).
    ///
    /// Time-complexity—O(n), where n is the number of nodes, or O(1), if the list is initially empty.
    public mutating func insertAtEnd(_ newNode: SinglyLinkedListNode<T>) {
        if let lastNode = lastNode() {
            insert(newNode, after: lastNode)
        } else {
            insertAtBeginning(newNode)
        }
    }

    /// Removes the first node of the list.
    ///
    /// Properly handles the situation when the list is initially empty or have only one node.
    ///
    /// Time-complexity—O(1).
    public mutating func removeFirst() {
        firstNode = firstNode?.nextNode
    }

    /// Removes the node after a specified one.
    ///
    /// Doesn't handle the situation when the specified node is not a part of the current list. The method will remove the specified node's next node anyway.
    ///
    /// Time-complexity – O(1).
    public func remove(after node: SinglyLinkedListNode<T>) {
        node.nextNode = node.nextNode?.nextNode
    }

    /// Removes the last node in the list.
    ///
    /// Properly handles the situation when the list is initially empty or have only one node.
    ///
    /// Time-complexity—O(n), where n is the number of nodes.
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

    public static func == (lhs: Self, rhs: Self) -> Bool {
        var lhsCurrentNode = lhs.firstNode
        var rhsCurrentNode = rhs.firstNode

        while (lhsCurrentNode != nil)
                   && (rhsCurrentNode != nil) {
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

    public typealias Element = SinglyLinkedListNode<T>
    public typealias Iterator = SinglyLinkedListIterator<T>

    // MARK: - Initialization

    /// Creates a new instance from the result of a `drop(while:)` call.
    /// - Parameter dropWhileSequence: The result of the `drop(while:)` call.
    public init(_ dropWhileSequence: DropWhileSequence<Self>) {
        var iterator = dropWhileSequence.makeIterator()
        self = SinglyLinkedList(firstNode: iterator.next())
    }
    
    /// Creates a new instance from the result of a `dropFirst(_:)` call.
    /// - parameter dropFirstSequence: The result of the `dropFirst(_:)` call.
    public init(_ dropFirstSequence: DropFirstSequence<Self>) {
        var iterator = dropFirstSequence.makeIterator()
        self = SinglyLinkedList(firstNode: iterator.next())
    }

    /// Creates a new instance from the result of a `prefix(_:)` call.
    /// - parameter prefixSequence: The result of the `prefix(_:)` call.
    public init(_ prefixSequence: PrefixSequence<Self>) {
        var iterator = prefixSequence.makeIterator()
        self = SinglyLinkedList(firstNode: iterator.next())
    }

    // MARK: - Methods

    // MARK: Sequence protocol methods

    public func makeIterator() -> SinglyLinkedListIterator<T> {
        SinglyLinkedListIterator(list: self)
    }

    @inlinable
    public func prefix(_ maxLength: Int) -> PrefixSequence<Self> {
        let result = SinglyLinkedList(firstNode: firstNode?.copy() as? SinglyLinkedListNode<T>)
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
    
    // Some `Collection` requirements are covered with Sequence.

    public typealias Index = Int

    // MARK: -

    public subscript(position: Int) -> SinglyLinkedListNode<T> {
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
        0
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
    
    // MARK: - Initialization

    /// Creates a new instance from a `SubSequence` instance.
    /// - Parameter slice: The corresponding `SubSequence` instance.
    public init(_ slice: SubSequence) {
        let startIndex = slice.startIndex
        let endIndex = slice.endIndex

        guard startIndex != endIndex else {
            self = SinglyLinkedList()
            return
        }

        slice[endIndex - 1].nextNode = nil
        self = SinglyLinkedList(firstNode: slice[startIndex])
    }

    // MARK: - Methods

    // MARK: Collection protocol methods

    public func index(after i: Int) -> Int {
        i + 1
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

    public typealias Element = SinglyLinkedListNode<T>

    // MARK: - Properties

    private(set) var list: SinglyLinkedList<T>

    // MARK: - Methods

    // MARK: IteratorProtocol protocol methods

    mutating public func next() -> SinglyLinkedListNode<T>? {
        defer { list.removeFirst() }
        return list.firstNode
    }

}
