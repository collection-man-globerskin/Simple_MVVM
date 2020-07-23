//
//  Bindable.swift
//  ViewModelBindableEntities
//
//  Created by Julian Llorensi on 23/07/2020.
//  Copyright © 2020 Julian Llorensi. All rights reserved.
//

import Foundation

protocol Bindable {
    associatedtype T
    
    func subscribe(_ callback: @escaping (T?) -> ())
}
