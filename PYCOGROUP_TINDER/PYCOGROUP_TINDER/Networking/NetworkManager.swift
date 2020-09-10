//
//  Networking.swift
//  PYCOGROUP_TINDER
//
//  Created by ngovantucuong on 9/10/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import Foundation
import UIKit

typealias result = (_ data: Results) -> Void

class NetworkManager {
    static let shared = NetworkManager(baseURL: URL(string: URL_GET_DATA))

    // MARK: - Properties
    let baseURL: URL?
    let session = URLSession(configuration: .default)

    // Initialization
    private init(baseURL: URL?) {
        self.baseURL = baseURL
    }
    
    // MARK: Function
    func getData(completion: @escaping (result)) {
        guard let baseURL = baseURL else { return }
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error != nil) { return }
            do {
                guard let data = data else { return }
                let values = try JSONDecoder().decode(Results.self, from: data)
                completion(values)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }

}
