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
        title = "PYCOGROUP TINDER"
        getApiData()
    }
    
    // MARK: - Action
    @IBAction func didRefresh(_ sender: UIButton) {
        addCardView(data: dataUser)
    }
    
    @IBAction func didAddFavorite(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let myFavoriteViewController = storyboard.instantiateViewController(identifier: "MyFavoriteViewController") as? MyFavoriteViewController else { return }
        navigationController?.pushViewController(myFavoriteViewController, animated: false)
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
        data.enumerated().forEach { (index, user) in
            let cardView = CardView()
            cardView.delegate = self
            cardView.updateDataUser(dataUser: user, index: index)
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

// MARK: - CardViewDelegate
extension MainViewController: CardViewDelegate {
    func didAddUserFavorite(dataUser: User?) {
        let modelObj = UserRealm(  name: "\(dataUser?.name?.first ?? "") \(dataUser?.name?.last ?? "")",
                                gender: dataUser?.gender ?? "",
                                phone: dataUser?.phone ?? "",
                                email: dataUser?.email ?? "",
                                age: dataUser?.dob?.age ?? 0,
                                city: dataUser?.location?.city ?? "",
                                state: dataUser?.location?.state ?? "",
                                image: dataUser?.picture?.thumbnail ?? "")
        DBManager.shared.addUser(with: modelObj)
    }
}
