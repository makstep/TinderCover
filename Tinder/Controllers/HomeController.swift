//
//  ViewController.swift
//  Tinder
//
//  Created by Maksim Ivanov on 30/05/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    fileprivate let topNavigationStackView = TopNavigationStackView()
    fileprivate let cardsDeckView = UIView()
    fileprivate let bottimStackView = HomeButtomControlsStackView()

    let cardViewModels: [CardViewModel] = {
        let producers: [ProducesCardViewModel] = [
            User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
            Advertiser(title: "Street Food", brandName: "Fat Custom Guides", posterPhotoName: "street_food"),
            User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])
        ]

        return producers.map { $0.toCardViewModel() }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        topNavigationStackView.settingButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)

        setupLayout()
        setupDummuCards()
    }

     // MARK:- Fileprivate

    @objc fileprivate func handleSettings() {
        let registrationController = RegistrationController()

        present(registrationController, animated: true, completion: nil)
    }

    fileprivate func setupDummuCards() {
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModel

            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }

    fileprivate func setupLayout() {
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

