//
//  HomeButtomControlsStackView.swift
//  Tinder
//
//  Created by Maksim Ivanov on 30/05/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

class HomeButtomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.distribution = .fillEqually
        self.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let subviewImages = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        subviewImages.forEach { (sv) in
            self.addArrangedSubview(sv)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
