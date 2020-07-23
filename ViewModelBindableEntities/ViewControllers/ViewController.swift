//
//  ViewController.swift
//  ViewModelBindableEntities
//
//  Created by Julian Llorensi on 23/07/2020.
//  Copyright © 2020 Julian Llorensi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var nameTextField: BindableTextField!
    @IBOutlet private weak var mobileNumberTextField: BindableTextField!
    @IBOutlet private weak var emailTextField: BindableTextField!
    @IBOutlet private weak var ageTextField: BindableTextField!
    @IBOutlet private weak var genderSegmentedControl: BindableSegmentedControl!
    @IBOutlet private weak var confirmButton: BindableButton!
    
    private var userViewModel: UserViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = User(name: "Jean Paul", mobileNumber: "01007336222", email: "dev.omartarek@gmail.com", age: 24, gender: .male)
        userViewModel = UserViewModel(user)
        
        configureUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        // from ViewModel to UI
        userViewModel.name?.subscribe { [unowned self] in
            self.nameTextField.text = $0
        }
        
        userViewModel.mobileNumber?.subscribe { [unowned self] in
            self.mobileNumberTextField.text = $0
        }
        
        userViewModel.email?.subscribe { [unowned self] in
            self.emailTextField.text = $0
        }
        
        userViewModel.age?.subscribe { [unowned self] in
            guard let age = $0 else {
                self.ageTextField.text = ""
                return
            }
            
            self.ageTextField.text = String(describing: age)
        }
        
        userViewModel.gender?.subscribe { [unowned self] in
            self.genderSegmentedControl.selectedSegmentIndex = $0!.rawValue
        }
        
        // from UI to ViewModel
        nameTextField.subscribe { [unowned self] in
            self.userViewModel.name?.value = $0
        }
        
        mobileNumberTextField.subscribe { [unowned self] in
            self.userViewModel.mobileNumber?.value = $0
        }
        
        emailTextField.subscribe { [unowned self] in
            self.userViewModel.email?.value = $0
        }
        
        ageTextField.subscribe { [unowned self] in
            self.userViewModel.age?.value = UInt8($0 ?? "0")
        }
        
        genderSegmentedControl.subscribe { [unowned self] in
            self.userViewModel.gender?.value = Gender(rawValue: $0 ?? 2)
        }
        
        confirmButton.subscribe { [unowned self] _ in
            self.userViewModel.confirmButtonTapped()
        }
        
        // Alerts
        userViewModel.messageCallback = { [unowned self] title, message in
            self.displayAlert(with: title, message)
        }
    }
    
    private func configureUI() {
        confirmButton.layer.cornerRadius = 20
    }
    
    private func displayAlert(with title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}


