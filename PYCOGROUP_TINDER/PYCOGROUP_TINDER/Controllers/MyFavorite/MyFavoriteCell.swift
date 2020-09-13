//
//  MyFavoriteCell.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/12/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import UIKit

class MyFavoriteCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgAvartar: UIImageView!
    @IBOutlet weak var seperatorView: UIView!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public func
    func updateUI(dataUser: UserRealm, isHidden: Bool) {
        seperatorView.isHidden = isHidden
        lblName.text = dataUser.name
        lblAge.text = String(describing: dataUser.age) 
        lblPhone.text = dataUser.phone
        lblLocation.text = dataUser.city
        if let url = URL(string: dataUser.image) {
            imgAvartar.load(url: url)
        }
    }
    
}
