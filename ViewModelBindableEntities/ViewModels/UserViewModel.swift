//
//  UserViewModel.swift
//  ViewModelBindableEntities
//
//  Created by Julian Llorensi on 23/07/2020.
//  Copyright © 2020 Julian Llorensi. All rights reserved.
//

import Foundation

enum ProfileError: Error {
    case emptyName
    case invalidNumber
    case invalidEmail
    case underAge
    
    var localizedDescription: String {
        switch self {
        case .emptyName:
            return "Please complete your name"
        case .invalidNumber:
            return "Please provide a valid number"
        case .invalidEmail:
            return "Please provide a valid email"
        case .underAge:
            return "You must to be 18 year old or older to access to the app"
        }
    }
}

class UserViewModel {
    var name: Property<String>?
    var mobileNumber: Property<String>?
    var email: Property<String>?
    var age: Property<UInt8>?
    var gender: Property<Gender>?
    
    var messageCallback: ((_ title: String, _ message: String) -> Void)?
    
    private var user: User?
    
    init(_ user: User?) {
        self.user = user
        
        if let user = user {
            setUserModel(with: user)
        }
    }
    
    func confirmButtonTapped() {
        let user = User(name: name?.value ?? "",
                        mobileNumber: mobileNumber?.value ?? "",
                        email: email?.value ?? "",
                        age: age?.value ?? 0,
                        gender: gender?.value ?? .other)
        
        let result = validate(user)
        
        guard result == nil else {
            messageCallback?("Error", result?.localizedDescription ?? "")
            return
        }
        
        updateUserModel(user)
        messageCallback?("Success", "The user profile was updated")
    }
    
    private func setUserModel(with user: User) {
        name = Property(user.name)
        mobileNumber = Property(user.mobileNumber)
        email = Property(user.email)
        age = Property(user.age)
        gender = Property(user.gender)
    }
    
    private func validate(_ user: User) -> ProfileError? {
        if user.name.isEmpty {
            return .emptyName
        }
        
        if !validate(string: user.mobileNumber, usingRegularExpression: "^[0-9]{11}$") {
            return .invalidNumber
        }
        
        if !validate(string: user.email, usingRegularExpression: "([\\w-+]+(?:\\.[\\w-+]+)*@(?:[\\w-]+\\.)+[a-zA-Z]{2,7})") {
            return .invalidEmail
        }
        
        if user.age < 18 {
            return .underAge
        }
        
        return nil
    }
    
    private func validate(string: String, usingRegularExpression regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: string)
    }
    
    private func updateUserModel(_ updatedUser: User) {
        user?.name = updatedUser.name
        user?.mobileNumber = updatedUser.mobileNumber
        user?.gender = updatedUser.gender
        user?.email = updatedUser.email
        user?.age = updatedUser.age
    }
}
