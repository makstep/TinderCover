//
//  ViewController.swift
//  Tinder
//
//  Created by Maksim Ivanov on 30/05/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    private let topNavigationStackView = TopNavigationStackView()
    private let cardsDeckView = UIView()
    private let bottimStackView = HomeButtomControlsStackView()
    
    let cardViewModels = [
        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c").toCardViewModel(),
        User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c").toCardViewModel()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupDummuCards()
    }
    
    fileprivate func setupDummuCards() {
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView(frame: .zero)

            cardView.imageView.image = UIImage(named: cardViewModel.imageName)
            cardView.informationLabel.attributedText = cardViewModel.attributedString
            cardView.informationLabel.textAlignment = cardViewModel.textAlingment

            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    // MARK:- Fileprivate
    
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

