//
//  User.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/10/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import Foundation

struct Results: Codable {
    private let results: [User]
}

struct User: Codable {
    private let gender: String?
    private let name: Name?
    private let location: Location?
    private let phone: String?
    private let picture: Picture?
}

struct Name: Codable {
    private let first: String?
    private let last: String?
}

struct Location: Codable {
    private let city: String?
    private let state: String?
}

struct Picture: Codable {
    private let large: String?
    private let medium: String?
    private let thumbnail: String?
}
