//
//  RandomPicViewController.swift
//  HW2.10
//
//  Created by Dmitry Tokarev on 14.11.2020.
//

import UIKit

class RandomPicViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    let screenWidth = Int(UIScreen.main.bounds.width)
    let screenHeight = Int(UIScreen.main.bounds.height)

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    @IBAction func nextImage(_ sender: UIBarButtonItem) {
        activityIndicator.startAnimating()
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: "https://picsum.photos/\(screenWidth)/\(screenHeight)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
        }.resume()
    }
}



