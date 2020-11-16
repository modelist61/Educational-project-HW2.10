//
//  NetWorkManager.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 15.11.2020.
//

import Foundation

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    public func getData(url: URL, completion: @escaping (Any) -> ()) {
        let session = URLSession.shared
        session.dataTask(with: url ) { (data, _, error) in
            guard let data = data else { return }
            do {
                let json  = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
