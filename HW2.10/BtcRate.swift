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




