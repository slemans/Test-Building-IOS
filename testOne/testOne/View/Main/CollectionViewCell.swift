//
//  CollectionViewCell.swift
//  testOne
//
//  Created by sleman on 27.10.21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {


    let colorButoonDelete: UIColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
    var indexCollectionViewCell: Int!
    var nameCollectionViewCell: String!



    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()

    let showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let buttonDelete: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
        button.layer.cornerRadius = 30 / 2
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitleColor(#colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1), for: .normal)
        return button
    }()



    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    func initialize() {
        buttonDelete.isHidden = true
        contentView.addSubview(showCaseImageView)
        contentView.addSubview(buttonDelete)
        contentView.addSubview(indicator)

        contentView.layer.cornerRadius = 10
        
        showCaseImageView.frame.contains(CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.width))
        NSLayoutConstraint.activate([
            buttonDelete.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            buttonDelete.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),


//            showCaseImageView.heightAnchor.constraint(equalToConstant: 128),
//            showCaseImageView.widthAnchor.constraint(equalToConstant: 128)
//            showCaseImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height),
//            showCaseImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width)


            ])
    }
    func configure(images: Images?) {
        guard let images = images else { return }
        putImage(image: images.url)
    }
    private func putImage(image: String?) {
        guard let image = image,
            let urlImg = URL(string: image) else { return }
        URLSession.shared.dataTask(with: urlImg) { [weak self] data, _, _ in
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.showCaseImageView.image = image
                        self?.indicator.stopAnimating()
                    }
                }
            }
        }.resume()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
