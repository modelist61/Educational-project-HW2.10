//
//  CryptoCollectionViewController.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 15.11.2020.
//

import UIKit
import Alamofire
import Spring

class CryptoCollectionViewController: UICollectionViewController {
    var cryptoPair: [GetPair] = []
    private var tradePair = ""
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        NetworkManager.shared.fetchData(from: .getPair) { cryptoPairs in
            self.cryptoPair = cryptoPairs
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cryptoPair.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cryptoCell", for: indexPath) as! CryptoPairCell
        let naimPair = cryptoPair[indexPath.item]
        cell.cryptoPairLable.animation = "zoomIn"
        cell.cryptoPairLable.delay = 0.2
        cell.cryptoPairLable.duration = 1.0
        cell.cryptoPairLable.text = """
                                    \(naimPair.base ?? "")
                                    \(naimPair.quote ?? "")
                                    """
        cell.cryptoPairLable.animate()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = cryptoPair[indexPath.item]
        tradePair = userAction.name ?? ""
        performSegue(withIdentifier: "cryptoDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let price = segue.destination as? CryptoDetailsViewController
        price?.tradePair = tradePair
    }
}

// MARK: Allert
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
