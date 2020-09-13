//
//  MyFavoriteViewController.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/12/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import UIKit

class MyFavoriteViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var myFavoriteDataArr: [UserRealm] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private func
    private func setupUI() {
        title = "My Favorite"
        tableView.register(UINib(nibName: "MyFavoriteCell", bundle: nil), forCellReuseIdentifier: "cell")
        DBManager.shared.getDataUser(complete: { [weak self] users in
            guard let sSelf = self else { return }
            sSelf.myFavoriteDataArr = users
            sSelf.tableView.reloadData()
        })
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MyFavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavoriteDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyFavoriteCell
        let isHidden = indexPath.item == myFavoriteDataArr.count - 1
        cell.updateUI(dataUser: myFavoriteDataArr[indexPath.item], isHidden: isHidden)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
}
