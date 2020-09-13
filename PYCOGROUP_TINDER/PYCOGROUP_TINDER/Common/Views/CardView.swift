//
//  TinderView.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/10/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import UIKit

protocol CardViewDelegate {
    func didAddUserFavorite(dataUser: User?)
}

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
    
    private let bottomSeperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: 0xADADAD)
        return view
    }()
    
    private let firstInformationLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lb.textColor = UIColor(hex: 0xDDDDDD)
        return lb
    }()
    
    private let secondInformationLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return lb
    }()
    
    let arrImageStr: [String] = ["user", "calendar", "pin", "phone", "lock"]
    var dataUserCardView: User?
    var delegate: CardViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
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
        addSubview(firstInformationLabel)
        addSubview(secondInformationLabel)
        addSubview(bottomSeperatorView)
        
        imageAvartar.layer.cornerRadius = widthAvartar / 2
        // Contraint
        imageAvartar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageAvartar.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        imageAvartar.widthAnchor.constraint(equalToConstant: widthAvartar).isActive = true
        imageAvartar.heightAnchor.constraint(equalTo: imageAvartar.widthAnchor, multiplier: 1).isActive = true
        
        firstInformationLabel.topAnchor.constraint(equalTo: imageAvartar.bottomAnchor, constant: 30).isActive = true
        firstInformationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        firstInformationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        secondInformationLabel.topAnchor.constraint(equalTo: firstInformationLabel.bottomAnchor, constant: 4).isActive = true
        secondInformationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        secondInformationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        bottomSeperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomSeperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomSeperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomSeperatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:))))
    }
    
    private func addViewAction(index: Int) {
       let parentView = UIView()
       parentView.translatesAutoresizingMaskIntoConstraints = false
       parentView.tag = index
       parentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapButtonAction(sender:))))
       
       let seperatorView = UIView()
       seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.backgroundColor = index == 0 ? UIColor(hex: 0xC9E265): .white
       parentView.addSubview(seperatorView)
       
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
       let tinColor: UIColor = index == 0 ? UIColor(hex: 0xC9E265): UIColor(hex: 0xDDDDDD)
       imageView.image = UIImage(named: arrImageStr[index])?.withTintColor(tinColor)
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
           imageView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 6),
           imageView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
           imageView.widthAnchor.constraint(equalToConstant: 30),
           imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
       ])
       stackViewActionButton.addArrangedSubview(parentView)
   }
    
    private func addListActionButton() {
        addSubview(stackViewActionButton)
        stackViewActionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        stackViewActionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackViewActionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stackViewActionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        for i in 0..<arrImageStr.count {
            addViewAction(index: i)
        }
    }
    
    private func handleUIWhenClick(numberTagView: Int) {
        stackViewActionButton.subviews.forEach { (view) in
            if (view.tag == numberTagView) {
                view.subviews[0].backgroundColor = UIColor(hex: 0xC9E265)
                if let imageView = view.subviews[1] as? UIImageView  {
                    imageView.image = UIImage(named: arrImageStr[view.tag])?.withTintColor(UIColor(hex: 0xC9E265))
                }
            } else {
                view.subviews[0].backgroundColor = .white
                if let imageView = view.subviews[1] as? UIImageView  {
                    imageView.image = UIImage(named: arrImageStr[view.tag])?.withTintColor(UIColor(hex: 0xDDDDDD))
                }
            }
        }
    }
    
    private func didUserClick(numberTagView: Int) {
        handleUIWhenClick(numberTagView: numberTagView)
    }
    
    private func didTimeClick(numberTagView: Int) {
        handleUIWhenClick(numberTagView: numberTagView)
    }
    
    private func didLocationClick(numberTagView: Int) {
        handleUIWhenClick(numberTagView: numberTagView)
    }
    
    private func didPhoneClick(numberTagView: Int) {
        handleUIWhenClick(numberTagView: numberTagView)
    }
    
    private func didLockClick(numberTagView: Int) {
        handleUIWhenClick(numberTagView: numberTagView)
    }
    
    // MARK: - Func objc
    @objc func handleTapButtonAction(sender: UITapGestureRecognizer) {
        guard let numberTagView = sender.view?.tag else { return }
        switch numberTagView {
        case 0:
            didUserClick(numberTagView: numberTagView)
            firstInformationLabel.text = "My name is"
            secondInformationLabel.text = (dataUserCardView?.name?.first ?? "") + " " + (dataUserCardView?.name?.last ?? "")
            break
        case 1:
            didTimeClick(numberTagView: numberTagView)
            firstInformationLabel.text = "My age is"
            secondInformationLabel.text = "\(dataUserCardView?.dob?.age ?? 0)"
            break
        case 2:
            didLocationClick(numberTagView: numberTagView)
            firstInformationLabel.text = "My location is"
            secondInformationLabel.text = (dataUserCardView?.location?.city ?? "") + "-" + (dataUserCardView?.location?.state ?? "")
            break
        case 3:
            didPhoneClick(numberTagView: numberTagView)
            firstInformationLabel.text = "My phone is"
            secondInformationLabel.text = dataUserCardView?.phone ?? ""
            break
        case 4:
            didLockClick(numberTagView: numberTagView)
            firstInformationLabel.text = "My email is"
            secondInformationLabel.text = dataUserCardView?.email ?? ""
            break
        default:
            break
        }
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        let LIMIT_VALUE_MOVE: Int = 140
        switch gesture.state {
        case .changed:
            let valueMove = abs(translation.x)
            if (Int(valueMove) > LIMIT_VALUE_MOVE) {
                if (translation.x > 0) {
                    delegate?.didAddUserFavorite(dataUser: dataUserCardView)
                }
                removeFromSuperview()
            }
            let angle = translation.x / 20 * .pi / 180
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
    func updateDataUser(dataUser: User, index: Int) {
        dataUserCardView = dataUser
        guard let urlImage = URL(string: dataUser.picture?.large ?? "") else { return }
        imageAvartar.load(url: urlImage)
        firstInformationLabel.text = "My name is"
        secondInformationLabel.text = (dataUser.name?.first ?? "") + " " + (dataUser.name?.last ?? "")
    }
}
