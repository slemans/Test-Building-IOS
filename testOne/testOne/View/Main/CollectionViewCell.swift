//
//  CollectionViewCell.swift
//  testOne
//
//  Created by sleman on 27.10.21.
//

import UIKit
         
protocol DelegatDeleteCollectionsViewCell: AnyObject {
    func deleteCollectionsViewCell(index: Int, title: String)
}


class CollectionViewCell: UICollectionViewCell {
    weak var delegate: DelegatDeleteCollectionsViewCell?
    let colorButoonDelete: UIColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
    var indexCollectionViewCell: Int!
    var nameCollectionViewCell: String!
    
    
    
//    let imageDelete: UIImage? = {
//        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular, scale: .medium)
//        let image = UIImage(systemName: "multiply", withConfiguration: largeConfig)
//        return image
//    }()
    
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
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let buttonDelete: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
        button.addConstraints([NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1, constant: 0)])
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
    @objc func buttonDeleteImageAction(_ sender: UIButton) {
        buttonDelete.setImage(ConstantsImage.imageDelete, for: .normal)
        delegate?.deleteCollectionsViewCell(index: indexCollectionViewCell, title: nameCollectionViewCell)
    }
    
    func initialize() {
        buttonDelete.addTarget(self, action: #selector(buttonDeleteImageAction(_:)), for: .touchUpInside)
        buttonDelete.isHidden = true
        contentView.addSubview(showCaseImageView)
        contentView.addSubview(buttonDelete)
        contentView.addSubview(indicator)

        
        showCaseImageView.frame.contains(CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.width))
        NSLayoutConstraint.activate([
            buttonDelete.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            buttonDelete.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            showCaseImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            showCaseImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            showCaseImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            showCaseImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
