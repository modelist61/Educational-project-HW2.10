//
//  CryptoDetailsViewController.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 15.11.2020.
//

import UIKit

class CryptoDetailsViewController: UIViewController {
    
    @IBOutlet var pairName: UILabel!
    @IBOutlet var pairPrice: UILabel!
    @IBOutlet var descriptionPrice: UILabel!
    var price = BtcRate.init(price: 0.0, pair: ["" : ""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CryptoDetailsViewController - \(price)")
        pairPrice.text = String(format: "%.3f", price.price)
        pairName.text = "\(price.pair["base"] ?? "") - \(price.pair["quote"] ?? "")"
        descriptionPrice.text = "\(price.pair["quote"] ?? "") for 1 \(price.pair["base"] ?? "")"
        
    }
}
