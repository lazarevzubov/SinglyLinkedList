//
//  CopyOnWriteBox.swift
//  SinglyLinkedList
//
//  Created by Nikita Lazarev-Zubov on 12.06.2019.
//  Copyright © 2019 Nikita Lazarev-Zubov. All rights reserved.
//

struct CopyOnWriteBox<T> {
    
    // MARK: - Properties
    
    var value: T {
        get {
            return referenceBox.value
        }
        set {
            if !isKnownUniquelyReferenced(&referenceBox) {
                referenceBox = ReferenceBox(value: newValue)
                return
            }
            referenceBox.value = newValue
        }
    }
    
    // MARK: Private properties
    
    private var referenceBox: ReferenceBox<T>
    
    // MARK: - Initialization
    
    init(value: T) {
        referenceBox = ReferenceBox(value: value)
    }
    
}

// MARK: -

private final class ReferenceBox<T> {
    
    // MARK: - Properties
    
    var value: T
    
    // MARK: - Initialization
    
    init(value: T) {
        self.value = value
    }
    
}
