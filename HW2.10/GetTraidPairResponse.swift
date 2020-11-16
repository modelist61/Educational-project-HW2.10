//
//  GetTraidPairResponse.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 16.11.2020.
//

import Foundation

struct GetTraidPairResponse {
    typealias JSON = [String: AnyObject]
    let traidPairs: [GetPairNew]
    
    init(json: Any) throws {
        guard let array = json as? [JSON] else { throw NetwordError.failInternetError }
        var pairs = [GetPairNew]()
        for dictionary in array {
            guard let pair = GetPairNew(dict: dictionary) else { continue }
            pairs.append(pair)
        }
        self.traidPairs = pairs
    }
}
