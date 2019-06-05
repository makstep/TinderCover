//
//  RegistrationController.swift
//  Tinder
//
//  Created by Maksim Ivanov on 06/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    fileprivate let gradientLayer = CAGradientLayer()

    fileprivate let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        return button
    }()

    fileprivate let fullnameTextField: RegistrationTextField = {
        let textField = RegistrationTextField(padding: 16)
        textField.placeholder = "Enter full name"
        textField.backgroundColor = .white
        return textField
    }()

    fileprivate let emailTextField: RegistrationTextField = {
        let textField = RegistrationTextField(padding: 16)
        textField.placeholder = "Enter email"
        textField.backgroundColor = .white
        textField.keyboardType = .emailAddress
        return textField
    }()

    fileprivate let passwordTextField: RegistrationTextField = {
        let textField = RegistrationTextField(padding: 16)
        textField.placeholder = "Enter password"
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()

    fileprivate let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6350168586, green: 0.08776394278, blue: 0.2625488043, alpha: 1)
        button.layer.cornerRadius = 25
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    fileprivate lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fullnameTextField,
            emailTextField,
            passwordTextField,
            registerButton
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()

    fileprivate lazy var overallStackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        verticalStackView
    ])

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientLayer()
        setupLayout()
        setupNotificationObserver()
        setupTapGesture()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK:- Private

    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }

    fileprivate func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc fileprivate func handleTapDismiss(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardFrame = value.cgRectValue        
        let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
        let difference = keyboardFrame.height - bottomSpace

        view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }

    @objc fileprivate func handleKeyboardHide(notification: Notification) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: { self.view.transform = .identity })
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
        } else {
            overallStackView.axis = .vertical
        }
    }

    fileprivate func setupLayout() {
        view.addSubview(overallStackView)

        overallStackView.axis = .vertical
        selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        overallStackView.spacing = 8
        overallStackView.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    fileprivate func setupGradientLayer() {
        let topColor = #colorLiteral(red: 0.9867816567, green: 0.3567377925, blue: 0.3801293373, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.7667772174, green: 0.1033584699, blue: 0.3984122872, alpha: 1)

        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]

        view.layer.addSublayer(gradientLayer)
    }

}