//
//  CustomTextField.swift
//  Tinder
//
//  Created by Maksim Ivanov on 06/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

class RegistrationTextField: UITextField {

    fileprivate let padding: CGFloat

    init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }

    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }

}
