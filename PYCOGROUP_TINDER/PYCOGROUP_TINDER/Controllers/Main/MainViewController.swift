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
    private let activityIndicator: UIActivityIndicatorView = {
        var actInd = UIActivityIndicatorView()
        actInd.translatesAutoresizingMaskIntoConstraints = false
        actInd.hidesWhenStopped = true
        actInd.style = .large
        return actInd
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
    private func setupUI() {
        title = "PYCOGROUP TINDER"
        view.addSubview(activityIndicator)
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    private func getApiData() {
        activityIndicator.startAnimating()
        NetworkManager.shared.getData { [weak self] data in
            guard let sSelf = self else { return }
            sSelf.dataUser = data
            DispatchQueue.main.async {
                sSelf.activityIndicator.stopAnimating()
                sSelf.addCardView(data: data)
            }
        }
    }
    
    
    private func addCardView(data: [User]) {
        let countLimitUser: Bool = data.count >= 3
        data.enumerated().forEach { (index, user) in
            let cardView = CardView()
            cardView.delegate = self
            cardView.updateDataUser(dataUser: user, index: index)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            mainView.insertSubview(cardView, at: 0)
            
            // Constraint
            var constantBottomContraint: CGFloat = 0.0
            if (countLimitUser && index == data.count - 2 || index == data.count - 3 ) {
                constantBottomContraint = index == data.count - 2 ? 6.0 : 3.0
            }
            cardView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
            cardView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
            cardView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: constantBottomContraint).isActive = true
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
