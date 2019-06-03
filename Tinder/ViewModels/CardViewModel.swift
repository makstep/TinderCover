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

struct CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlingment: NSTextAlignment
}
