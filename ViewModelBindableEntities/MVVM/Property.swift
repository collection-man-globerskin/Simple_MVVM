//
//  Property.swift
//  ViewModelBindableEntities
//
//  Created by Julian Llorensi on 23/07/2020.
//  Copyright © 2020 Julian Llorensi. All rights reserved.
//

import Foundation

public class Property<Type>: Bindable {
    private var subscribeCallblack: (Type?) -> () = { _ in }
    
    var value: Type? {
        didSet {
            subscribeCallblack(value)
        }
    }
    
    init(_ value: Type) {
        self.value = value
    }
    
    public func subscribe(_ callback: @escaping (Type?) -> ()) {
        subscribeCallblack = callback
        subscribeCallblack(value)
    }
}
