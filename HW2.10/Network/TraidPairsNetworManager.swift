//
//  traidPairsNetworManager.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 16.11.2020.
//

import Foundation

class TraidPairsNetworkManager {
    private init() {}
    
    static func getTraidPair(completion: @escaping(GetTraidPairResponse) -> () ){
        guard let url = URL(string: "https://api.n.exchange/en/api/v1/pair/") else { return }
        NetworkManager.shared.getData(url: url) { (json) in
            do {
                let response = try GetTraidPairResponse(json: json)
                completion(response)
            } catch {
                print(error)
            }
        }
    }
}
