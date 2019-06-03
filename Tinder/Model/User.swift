//
//  User.swift
//  Tinder
//
//  Created by Maksim Ivanov on 01/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {

    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]
    
    private var attributedText: NSAttributedString {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return attributedText
    }
    
    func toCardViewModel() -> CardViewModel {
        return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlingment: .left)
    }

}
