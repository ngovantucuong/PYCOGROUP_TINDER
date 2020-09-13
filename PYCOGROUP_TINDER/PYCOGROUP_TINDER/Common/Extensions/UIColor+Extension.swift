//
//  UIColor+Extension.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/12/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hex: Int, alpha: Double = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}

