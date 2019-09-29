//
//  CardViewModel.swift
//  Tinder
//
//  Created by Maksim Ivanov on 02/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlingment: NSTextAlignment

    fileprivate var imageIndex = 0 {
        didSet {
            let image = UIImage(named: imageNames[imageIndex])
            imageIndexObserver?(imageIndex, image)
        }
    }

    var imageIndexObserver: ((Int, UIImage?) -> Void)?

    init(imageNames: [String], attributedString: NSAttributedString, textAlingment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlingment = textAlingment
    }

    func advanceIndexPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }

    func preveousIndexPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
