//
//  BtcRate.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 15.11.2020.
//

struct GetPair: Decodable {
    let name: String?
    let base: String?
    let quote: String?
    
    init(pairData: [String: Any]) {
        name = pairData["name"] as? String
        base = pairData["base"] as? String
        quote = pairData["quote"] as? String
    }
    
//    static func getCryptoPair(from value: Any) -> [GetPair]? {
//        guard let pairsData = value as? [[String: Any]] else { return nil }
//        return pairsData.compactMap { GetPair(pairData: $0) }
//    }
    
    static func getBtcPair(from value: Any) -> [GetPair]? {
        guard let pairsData = value as? [[String: Any]] else { return nil }
        var btcPair: [GetPair] = []
        for btc in pairsData {
            let pair = GetPair(pairData: btc)
            if pair.base == "BTC" {
                btcPair.append(pair)
            }
        }
        return btcPair
    }
}

struct BtcRate2: Decodable {
    let price: Double?
    var pair: Pair
}

struct Pair: Decodable {
    let base: String?
    let quote: String?
}







