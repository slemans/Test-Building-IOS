//
//  DemoImagesViewController.swift
//  testOne
//
//  Created by sleman on 18.10.21.
//

import UIKit

class DemoImagesViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imagesColectionView: UIImageView!
    @IBOutlet weak var button: UIButton!
    var image: UIImage?
    var imageUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
    }
    public func startSetting() {
        button.layer.cornerRadius = button.frame.size.height / 2
        guard let image = imageUrl,
            let urlImg = URL(string: image) else { return }
        URLSession.shared.dataTask(with: urlImg) { [weak self] data, _, _ in
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imagesColectionView.image = image
                        self?.indicator.stopAnimating()
                    }
                }
            }
        }.resume()
    }
    @IBAction func buttonAct() {
        dismiss(animated: true)
    }
}
