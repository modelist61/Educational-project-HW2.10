//
//  MainCollectionCollectionViewController.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 13.11.2020.
//

import UIKit

enum UserActions: String, CaseIterable {
    case randomPicture = "Show random picture"
    case btcRate = "BTC rate"
}

class MainCollectionViewController: UICollectionViewController {
    
    let userActions = UserActions.allCases
    var btcPair: [GetPair] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCryptoPair()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
        
        let userAction = userActions[indexPath.item]
        cell.actionCellLablle.text = userAction.rawValue
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .randomPicture:
            performSegue(withIdentifier: "randomPicture", sender: nil)
        case .btcRate:
            performSegue(withIdentifier: "crypto", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pair = segue.destination as? CryptoCollectionViewController
        pair?.cryptoPair = btcPair
    }
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 45 , height: 70)
    }
}

extension MainCollectionViewController {
    private func getCryptoPair() {
        guard let url = URL(string: "https://api.n.exchange/en/api/v1/pair/") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let cryptoPairs = try JSONDecoder().decode([GetPair].self, from: data)
                DispatchQueue.main.async {
                    for btc in cryptoPairs {
                        if btc.base == "BTC" {
                            self.btcPair.append(btc)
                        }
                    }
                }
            } catch let error {
                print("ERROR!!! \(error)")
            }
        }.resume()
    }
}




