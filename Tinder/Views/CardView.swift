//
//  CardView.swift
//  Tinder
//
//  Created by Maksim Ivanov on 31/05/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            imageView.image = UIImage(named: cardViewModel.imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlingment
        }
    }

    // Configuration
    fileprivate let threshold: CGFloat = 100

    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let informationLabel = UILabel()
    fileprivate let gradiestLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradiestLayer.frame = self.frame
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupLayout() {
        addSubview(imageView)
        imageView.fillSuperview()

        setupGradiestLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 2

        imageView.contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        
        self.transform = CGAffineTransform(rotationAngle: angle).translatedBy(x: translation.x, y: translation.y)
    }

    fileprivate func setupGradiestLayer() {
        gradiestLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradiestLayer.locations = [0.5, 1.1]
        
        layer.addSublayer(gradiestLayer)
    }

    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold

        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut,
                       animations: {
                           if shouldDismissCard {
                               self.frame = CGRect(x: 1000 * translationDirection,
                                                   y: 0,
                                                   width: self.frame.width,
                                                   height: self.frame.height)
                           } else {
                               self.transform = .identity
                           }
                        },
                       completion: { (_) in
                           self.transform = .identity
                           if shouldDismissCard {
                               self.removeFromSuperview()
                           }
                       })
    }

}
