//
//  Bindable.swift
//  Tinder
//
//  Created by Maksim Ivanov on 06/06/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import Foundation

class Bindable<T> {

    var value: T? {
        didSet {
            observer?(value)
        }
    }

    var observer: ((T?) -> Void)?

    func bind(observer: @escaping (T?) -> Void) {
        self.observer = observer
    }

}
