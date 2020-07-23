//
//  BindableSegmentedControl.swift
//  ViewModelBindableEntities
//
//  Created by Julian Llorensi on 23/07/2020.
//  Copyright © 2020 Julian Llorensi. All rights reserved.
//

import UIKit

public class BindableSegmentedControl: UISegmentedControl, Bindable {
    private var selectedValueChangedCallback: (Int?) -> () = { _ in }
    
    public func subscribe(_ callback: @escaping (Int?) -> ()) {
        selectedValueChangedCallback = callback
        addTarget(self, action: #selector(segmentedControlDidChange), for: .editingChanged)
    }
    
    @objc private func segmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        selectedValueChangedCallback(segmentedControl.selectedSegmentIndex)
    }
}
