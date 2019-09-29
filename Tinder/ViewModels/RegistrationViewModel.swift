//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Maksim Ivanov on 06/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit
import Firebase

private protocol RegistrationFieldValidator {
    func validate(_ value: String?) -> Bool
}

private class FullnameValidator: RegistrationFieldValidator {
    // soft validation
    func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        return !value.isEmpty
    }
}

private class EmailValidator: RegistrationFieldValidator {
    static let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        let emailTest = NSPredicate(format: "SELF MATCHES %@", EmailValidator.emailRegExp)

        return !value.isEmpty && emailTest.evaluate(with: value)
    }
}

private class PasswordValidator: RegistrationFieldValidator {
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

    let bindableIsRegistering = Bindable<Bool>()
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

    func performRegistration(completion: @escaping (Error?) -> Void) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true

        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in

            if let error = error {
                completion(error)
                return
            }

            print("Success singing up", result?.user.uid ?? "Empty")

            self.saveImageToFirebase(completion: completion)
        }
    }

    fileprivate func saveImageToFirebase(completion: @escaping ((Error?) -> Void)) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()

        ref.putData(imageData, metadata: nil, completion: { (_, putDataError) in
            if let putDataError = putDataError {
                completion(putDataError)
                return
            }

            ref.downloadURL(completion: { (downloadURL, downloadURLError) in
                if let downloadURLError = downloadURLError {
                    completion(downloadURLError)
                    return
                }

                self.bindableIsRegistering.value = false

                let imageURL = downloadURL?.absoluteString ?? ""

                print("Download url is \(imageURL)")

                self.saveInfo(imageURL: imageURL, completion: completion)
            })
        })
    }

    fileprivate func saveInfo(imageURL: String, completion: @escaping ((Error?) -> Void)) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName": fullname ?? "", "uid": uid, "imageURL1": imageURL]

        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            if let error = error {
                completion(error)
                return
            }

            completion(nil)
        }
    }

    fileprivate func checkFormValidity() {
        let isValid = fullnameValidator.validate(fullname) &&
                      emailValidator.validate(email) &&
                      passwordValidator.validate(password)

        bindableIsFormValid.value = isValid
    }

}
