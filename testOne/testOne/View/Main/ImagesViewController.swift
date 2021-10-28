//
//  ImagesViewController.swift
//  testOne
//
//  Created by sleman on 28.10.21.
//

import UIKit

class ImagesViewController: UIViewController {
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
    private let imagesColectionView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(ConstantsImage.imageDelete, for: .normal)
        button.tintColor = ColorUIColor.white
        button.addConstraints([NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .width, multiplier: NumberCGFloat.one, constant: NumberCGFloat.zero)])
        button.backgroundColor = ColorUIColor.black
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = NumberCGFloat.thirtyFour / NumberCGFloat.two
        button.heightAnchor.constraint(equalToConstant: NumberCGFloat.thirtyFour).isActive = true
        return button
    }()
    
    var image: UIImage?
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
    }
    @objc func buttonDismissView(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func startSetting() {
        button.addTarget(self, action: #selector(buttonDismissView(_:)), for: .touchUpInside)
        view.addSubview(imagesColectionView)
        view.addSubview(indicator)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            imagesColectionView.topAnchor.constraint(equalTo: view.topAnchor),
            imagesColectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imagesColectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imagesColectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: NumberCGFloat.twentyFive),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: NumberCGFloat.twentyFiveMinus)
        ])
        getImageAndPut()
    }
    private func getImageAndPut(){
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
}
