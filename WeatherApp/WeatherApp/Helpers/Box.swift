//
//  Box.swift
//  ListingsApp
//
//  Created by Rana Ijaz on 20/08/2022.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var shouldCallListenerForIntialValue = true
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        if shouldCallListenerForIntialValue {
            listener?(value)
        }
    }
}


