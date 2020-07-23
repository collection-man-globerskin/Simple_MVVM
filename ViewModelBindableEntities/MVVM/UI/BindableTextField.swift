//
//  BindableTextField.swift
//  ViewModelBindableEntities
//
//  Created by Julian Llorensi on 23/07/2020.
//  Copyright © 2020 Julian Llorensi. All rights reserved.
//

import UIKit

public class BindableTextField: UITextField, Bindable {    
    private var textChangedCallback: (String?) -> () = { _ in }
    
    public func subscribe(_ callback: @escaping (String?) -> ()) {
        textChangedCallback = callback
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textChangedCallback(textField.text)
    }
}
