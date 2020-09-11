//
//  User.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/10/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import Foundation

struct Results: Codable {
    let results: [User]
}

struct User: Codable {
    let gender: String?
    let name: Name?
    let location: Location?
    let phone: String?
    let picture: Picture?
}

struct Name: Codable {
    let first: String?
    let last: String?
}

struct Location: Codable {
    let city: String?
    let state: String?
}

struct Picture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
