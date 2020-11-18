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
    
//    func fetchDataRate(from url: URL, with complition: @escaping (BtcRate) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseJSON { dataResponse in
//                switch dataResponse.result {
//                case .success(let value):
//                    let price = BtcRate.init(rate: value as! [String : Any])
//                    let pair = Pair.init(pair: value as! [String : Any])
//                    DispatchQueue.main.async {
//                        complition(price)
//                    }
//                case .failure(let error):
//                    print("BtcRate", error.localizedDescription)
//                }
//            }.resume()
//    }
}

    
