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
    
    private let stackViewActionButton: UIStackView = {
       let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .horizontal
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 0
        return st
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubCardView()
        addListActionButton()
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
    
    private func addViewAction(index: Int) {
       let parentView = UIView()
       parentView.translatesAutoresizingMaskIntoConstraints = false
       parentView.tag = index
       parentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapButtonAction(sender:))))
       
       let seperatorView = UIView()
       seperatorView.translatesAutoresizingMaskIntoConstraints = false
       seperatorView.backgroundColor = .blue
       parentView.addSubview(seperatorView)
       
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.image = UIImage(named: "user1")
       imageView.contentMode = .scaleAspectFit
       parentView.addSubview(imageView)
       // Contraint UI
       NSLayoutConstraint.activate([
           seperatorView.topAnchor.constraint(equalTo: parentView.topAnchor),
           seperatorView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
           seperatorView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
           seperatorView.heightAnchor.constraint(equalToConstant: 3.0)
       ])
       NSLayoutConstraint.activate([
           imageView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 0),
           imageView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
           imageView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
           imageView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
       ])
       stackViewActionButton.addArrangedSubview(parentView)
   }
    
    private func addListActionButton() {
        addSubview(stackViewActionButton)
        stackViewActionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        stackViewActionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackViewActionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stackViewActionButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        for i in 0...3 {
            addViewAction(index: i)
        }
    }
    
    // MARK: - Func objc
    @objc func handleTapButtonAction(sender: UITapGestureRecognizer) {
        print("in ra", sender.view?.tag)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        let LIMIT_VALUE_MOVE: Int = 120
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
