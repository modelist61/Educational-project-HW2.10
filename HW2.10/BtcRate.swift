//
//  BtcRate.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 15.11.2020.
//

struct BtcRate: Decodable {
    let price: Double
    let pair: [String: String]
}

struct GetPair: Decodable {
    let name: String?
    let base: String?
    let quote: String?
}

struct GetPairNew {
    let name: String
    let base: String
    let quote: String
    
    init?(dict: [String: AnyObject]) {
        guard
        let name = dict["name"] as? String,
        let base = dict["base"] as? String,
        let quote = dict["quote"] as? String
        else { return nil }
        
        self.name = name
        self.base = base
        self.quote = quote
    }
}




