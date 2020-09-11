//
//  TinderView.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/10/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // MARK: - Properties
    private let imageAvartar: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubCardView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private func
    private func addSubCardView() {
        let widthAvartar: CGFloat = 180
        addSubview(imageAvartar)
        backgroundColor = .white
        imageAvartar.layer.cornerRadius = widthAvartar / 2
        // Contraint
        imageAvartar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageAvartar.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        imageAvartar.widthAnchor.constraint(equalToConstant: widthAvartar).isActive = true
        imageAvartar.heightAnchor.constraint(equalTo: imageAvartar.widthAnchor, multiplier: 1).isActive = true
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:))))
    }
    
    // MARK: - Func objc
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        let LIMIT_VALUE_MOVE: Int = 100
        switch gesture.state {
        case .changed:
            let valueMove = abs(translation.x)
            print(valueMove)
            if (Int(valueMove) > LIMIT_VALUE_MOVE) { removeFromSuperview() }
            let angle = translation.x / 30 * .pi / 180
            self.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: translation.x, y: 0))
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.transform = .identity
            }) { (_) in
                
            }
            
        default:
            break
        }
    }
    
    // MARK: - Public func
    func updateDataUser(dataUser: User) {
        guard let urlImage = URL(string: dataUser.picture?.large ?? "") else { return }
        imageAvartar.load(url: urlImage) 
    }
}
