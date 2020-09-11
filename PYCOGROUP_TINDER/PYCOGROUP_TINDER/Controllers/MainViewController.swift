//
//  MainViewController.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/10/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - Properties
    var dataUser: [User] = [User]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getApiData()
    }
    
    // MARK: - Private function
    private func getApiData() {
        NetworkManager.shared.getData { [weak self] data in
            guard let sSelf = self else { return }
            sSelf.dataUser = data
            DispatchQueue.main.async {
                sSelf.addCardView(data: data)
            }
        }
    }
    
    
    private func addCardView(data: [User]) {
        data.forEach { (user) in
            let cardView = CardView()
            cardView.updateDataUser(dataUser: user)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            mainView.insertSubview(cardView, at: 0)
            
            // Constraint
            cardView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
            cardView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
            cardView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
            cardView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        }
        
        
    }
}
