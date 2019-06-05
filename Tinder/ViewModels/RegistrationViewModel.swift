//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Maksim Ivanov on 06/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

protocol RegistrationFieldValidator {
    func validate(_ value: String?) -> Bool
}

fileprivate class FullnameValidator: RegistrationFieldValidator {
    // soft validation
    func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        return !value.isEmpty
    }
}

fileprivate class EmailValidator: RegistrationFieldValidator {
    // soft validation
    func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        return !value.isEmpty
    }
}

fileprivate class PasswordValidator: RegistrationFieldValidator {
    // soft validation
    func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        return !value.isEmpty
    }
}

class RegistrationViewModel {

    fileprivate let fullnameValidator = FullnameValidator()
    fileprivate let emailValidator = EmailValidator()
    fileprivate let passwordValidator = PasswordValidator()

    var fullname: String? {
        didSet {
            checkFormValidity()
        }
    }

    var email: String? {
        didSet {
            checkFormValidity()
        }
    }

    var password: String? {
        didSet {
            checkFormValidity()
        }
    }

    var isFormValidObserver: ((Bool) -> ())?

    fileprivate func checkFormValidity() {
        let isValid = fullnameValidator.validate(fullname) &&
                      emailValidator.validate(email) &&
                      passwordValidator.validate(password)
        
        isFormValidObserver?(isValid)
    }

}
