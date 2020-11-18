//
//  NetWorkManager.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 15.11.2020.
//

import Foundation
import Alamofire

enum URLS: String {
    case getPair = "https://api.n.exchange/en/api/v1/pair/"
    case pairRate = "https://api.n.exchange/en/api/v1/get_price/BTCETH"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(from url: URLS, with complition: @escaping ([GetPair]) -> Void) {
        AF.request(url.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let cryptoPair = GetPair.getBtcPair(from: value) ?? []
                    DispatchQueue.main.async {
                        complition(cryptoPair)
                    }
                case .failure(let error):
                    print("ERROR GetPair", error.localizedDescription)
                }
            }.resume()
    }
    
    func fetchDataRate(from url: URLS, with complition: @escaping (BtcRate2, Pair) -> Void) {
        AF.request(url.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let btcRate = value
                    
                    DispatchQueue.main.async {
                       
                    }
                case .failure(let error):
                    print("BtcRate", error.localizedDescription)
                }
            }.resume()
    }
}

    
