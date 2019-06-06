//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Maksim Ivanov on 06/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

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
    static let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        let emailTest = NSPredicate(format: "SELF MATCHES %@", EmailValidator.emailRegExp)

        return !value.isEmpty && emailTest.evaluate(with: value)
    }
}

fileprivate class PasswordValidator: RegistrationFieldValidator {
    static let minimumFirebasePasswordLength = 6

    func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        return !value.isEmpty && value.count >= PasswordValidator.minimumFirebasePasswordLength
    }
}

class RegistrationViewModel {

    fileprivate let fullnameValidator = FullnameValidator()
    fileprivate let emailValidator = EmailValidator()
    fileprivate let passwordValidator = PasswordValidator()

    let bindableImage = Bindable<UIImage>()
    let bindableIsFormValid = Bindable<Bool>()

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

    fileprivate func checkFormValidity() {
        let isValid = fullnameValidator.validate(fullname) &&
                      emailValidator.validate(email) &&
                      passwordValidator.validate(password)

        bindableIsFormValid.value = isValid
    }

}
