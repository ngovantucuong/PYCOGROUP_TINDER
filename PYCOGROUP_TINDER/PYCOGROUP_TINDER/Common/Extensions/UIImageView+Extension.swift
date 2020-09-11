//
//  UIImageView+Extension.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/11/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
