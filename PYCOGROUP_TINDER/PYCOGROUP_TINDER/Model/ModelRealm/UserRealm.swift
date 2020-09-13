//
//  UserRealm.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/12/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import UIKit
import RealmSwift

class UserRealm: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var city: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var image: String = ""
    convenience init(name: String,
                     gender: String,
                     phone: String,
                     email: String,
                     age: Int,
                     city: String,
                     state: String,
                     image: String) {
        self.init()
        self.id = UUID().uuidString
        self.name = name
        self.gender = gender
        self.phone = phone
        self.email = email
        self.age = age
        self.city = city
        self.state = state
        self.image = image
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
