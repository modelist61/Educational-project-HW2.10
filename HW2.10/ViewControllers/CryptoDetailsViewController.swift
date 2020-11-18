//
//  CryptoDetailsViewController.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 15.11.2020.
//

import UIKit
import Alamofire
import Spring

class CryptoDetailsViewController: UIViewController {
    
    @IBOutlet var pairName: SpringLabel!
    @IBOutlet var pairPrice: SpringLabel!
    @IBOutlet var descriptionPrice: SpringLabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var price: BtcRate2!
    var pair: Pair!
    
    var tradePair = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBtcRate()
    }
    
    private func printLable() {
        pairPrice.text = String(format: "%.3f", price.price ?? 0)
        pairName.text = "\(pair.base ?? "") - \(pair.quote ?? "")"
        descriptionPrice.text = "\(pair.base ?? "") for 1 \(pair.quote ?? "")"
        pairName.animation = "slideRight"
        pairName.animate()
    }
    
    @IBAction func dismisButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

// MARK: GetBtcRate
extension CryptoDetailsViewController {
    private func getBtcRate() {
        guard let url = URL(string: "https://api.n.exchange/en/api/v1/get_price/\(tradePair)") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let btcRate = try JSONDecoder().decode(BtcRate2.self, from: data)
                self.price = btcRate
                self.pair = btcRate.pair
                print(btcRate)
                DispatchQueue.main.async {
                    self.printLable()
                    self.activityIndicator.stopAnimating()
                }
            } catch let error {
                DispatchQueue.main.async {
                    self.pairName.text = "No result =("
                    self.pairPrice.text = ""
                    self.activityIndicator.stopAnimating()
                }
                print("ERROR!!! \(error)")
            }
        }.resume()
    }
}

//extension CryptoDetailsViewController {
//    private func getBtcRate2() {
//        AF.request("https://api.n.exchange/en/api/v1/get_price/\(tradePair)")
//            .validate()
//            .responseJSON { dataResponse in
//                switch dataResponse.result {
//                case .success(let value):
////                    self.price2 =
//
//                    DispatchQueue.main.async {
//                        self.printLable()
//                        self.activityIndicator.stopAnimating()
//
//                    }
//                case .failure(let error):
//                    print("ERROR: \(error)")
//                    self.pairName.text = "No result =("
//                    self.pairPrice.text = ""
//                    self.activityIndicator.stopAnimating()
//                }
//            }.resume()
//    }
//}

