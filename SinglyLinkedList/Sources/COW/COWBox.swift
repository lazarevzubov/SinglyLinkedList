//
//  COWBox.swift
//  SinglyLinkedList
//
//  Created by lazarevzubov on 02.08.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

struct COWBox<T> {

    // MARK: - Properties

    var value: T? {
        get {
            return reference.value
        }
        set {
            if !isKnownUniquelyReferenced(&reference) {
                reference = Reference(newValue)
            } else {
                reference.value = newValue
            }
        }
    }

    // MARK: Private properties

    private var reference: Reference<T>

    // MARK: - Initialization

    init(_ value: T?) {
        reference = Reference(value)
    }

}

// MARK: - Codable

extension COWBox: Codable where T: Codable { }

// MARK: -

private final class Reference<T> {

    // MARK: - Properties

    // MARK: Private properties

    var value: T?

    // MARK: - Initialization

    init(_ value: T?) {
        self.value = value
    }

}

// MARK: - Codable

extension Reference: Codable where T: Codable { }
