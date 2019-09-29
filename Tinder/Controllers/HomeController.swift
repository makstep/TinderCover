//
//  ViewController.swift
//  Tinder
//
//  Created by Maksim Ivanov on 30/05/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {

    fileprivate let topNavigationStackView = TopNavigationStackView()
    fileprivate let cardsDeckView = UIView()
    fileprivate let bottimStackView = HomeButtomControlsStackView()

    var cardViewModels: [CardViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        topNavigationStackView.settingButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)

        setupLayout()
        setupDummyCards()

        fetchUsersFromFirestore()
    }

     // MARK: - Fileprivate

    @objc fileprivate func handleSettings() {
        let registrationController = RegistrationController()

        present(registrationController, animated: true, completion: nil)
    }

    fileprivate func fetchUsersFromFirestore() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print("Failt to fetch usees: ", error)
                return
            }

            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)

                self.cardViewModels.append(user.toCardViewModel())
            })

            self.setupDummyCards()
        }
    }

    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModel

            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }

    fileprivate func setupLayout() {
        view.backgroundColor = .white

        let overallStackView = UIStackView(arrangedSubviews: [topNavigationStackView, cardsDeckView, bottimStackView])

        overallStackView.axis = .vertical
        view.addSubview(overallStackView)

        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.safeAreaLayoutGuide.leadingAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                trailing: view.safeAreaLayoutGuide.trailingAnchor)

        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0,
                                               left: 8,
                                               bottom: 0,
                                               right: 8)

        overallStackView.bringSubviewToFront(cardsDeckView)
    }

}
