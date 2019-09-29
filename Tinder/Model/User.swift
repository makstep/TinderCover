//
//  User.swift
//  Tinder
//
//  Created by Maksim Ivanov on 01/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {

    var name: String?
    var age: Int?
    var profession: String?
    var imageURL1: String?
    var uid: String?

    init(dictionary: [String: Any]) {
        self.name = dictionary["fullName"] as? String ?? ""
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        self.imageURL1 = dictionary["imageURL1"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }

    private var attributedText: NSAttributedString {
        let ageString = age != nil ? "\(age!)" : "N/A"
        let professionString = profession != nil ? profession! : "Not available"

        let attributedText = NSMutableAttributedString(
            string: name ?? "",
            attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)]
        )

        let ageAttributedString = NSAttributedString(
            string: " \(ageString)",
            attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]
        )
        attributedText.append(ageAttributedString)

        let professtionAttributedStrig = NSAttributedString(
            string: "\n\(professionString)",
            attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]
        )
        attributedText.append(professtionAttributedStrig)

        return attributedText
    }

    func toCardViewModel() -> CardViewModel {
        return CardViewModel(imageNames: [imageURL1 ?? ""], attributedString: attributedText, textAlingment: .left)
    }

}
