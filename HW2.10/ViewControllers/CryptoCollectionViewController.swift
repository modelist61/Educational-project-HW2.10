//
//  CryptoCollectionViewController.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 15.11.2020.
//

import UIKit

class CryptoCollectionViewController: UICollectionViewController {
    
    var cryptoPair: [GetPair] = []
    private var tradePair = ""
    private var selectPrice = BtcRate.init(price: 0.0, pair: ["" : ""])
    
//    //собраный массив из NetworkManager
//    var pairNew: [GetPairNew] = []
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        TraidPairsNetworkManager.getTraidPair { (response) in
//            self.pairNew = response.traidPairs
//        }
//        print("!pairNew! \(pairNew)")
//    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cryptoPair.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cryptoCell", for: indexPath) as! CryptoPairCell
        let naimPair = cryptoPair[indexPath.item]
        cell.cryptoPairLable.text = "\(naimPair.base ?? "") / \(naimPair.quote ?? "")"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = cryptoPair[indexPath.item]
        tradePair = userAction.name ?? ""
        getBtcRate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let price = segue.destination as? CryptoDetailsViewController
        price?.price = selectPrice
    }
}

extension CryptoCollectionViewController {
    private func getBtcRate() {
        guard let url = URL(string: "https://api.n.exchange/en/api/v1/get_price/\(tradePair)") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let btcRate = try JSONDecoder().decode(BtcRate.self, from: data)
                DispatchQueue.main.async {
                    self.selectPrice = btcRate
                    self.performSegue(withIdentifier: "ccryptoDetails", sender: nil )
                }
            } catch let error {
                self.errorAlert()
                print("ERROR!!! \(error)")
            }
        }.resume()
    }
}

extension CryptoCollectionViewController {
    private func errorAlert() {
        let alert = UIAlertController(title: "Faild! :(",
                                      message: "There is no data available for this pair",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
