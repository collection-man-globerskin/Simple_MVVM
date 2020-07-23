//
//  BindableButton.swift
//  ViewModelBindableEntities
//
//  Created by Julian Llorensi on 23/07/2020.
//  Copyright © 2020 Julian Llorensi. All rights reserved.
//

import UIKit

public class BindableButton: UIButton, Bindable {    
    private var tapCallback: (UIButton?) -> () = { _ in }
    
    public func subscribe(_ callback: @escaping (UIButton?) -> ()) {
        tapCallback = callback
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        tapCallback(sender)
    }
}
