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
    var indexCollectionViewCell: Int!
    var nameCollectionViewCell: String!
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
    private let showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = NumberCGFloat.ten
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let buttonDelete: UIButton = {
        let button = UIButton()
        button.tintColor = ColorUIColor.pinkCustom
        button.addConstraints([NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .width, multiplier: NumberCGFloat.one, constant: NumberCGFloat.zero)])
        button.backgroundColor = ColorUIColor.white
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = NumberCGFloat.one
        button.layer.borderColor = ColorCGColor.pinkCustom
        button.layer.cornerRadius = NumberCGFloat.thirty / NumberCGFloat.two
        button.heightAnchor.constraint(equalToConstant: NumberCGFloat.thirty).isActive = true
        button.setTitleColor(ColorUIColor.pinkCustom, for: .normal)
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
    
    private func initialize() {
        buttonDelete.addTarget(self, action: #selector(buttonDeleteImageAction(_:)), for: .touchUpInside)
        buttonDelete.isHidden = true
        contentView.addSubview(showCaseImageView)
        contentView.addSubview(buttonDelete)
        contentView.addSubview(indicator)
        showCaseImageView.frame.contains(CGRect(x: NumberCGFloat.zero, y: NumberCGFloat.zero, width: contentView.frame.size.width, height: contentView.frame.size.width))
        NSLayoutConstraint.activate([
            buttonDelete.topAnchor.constraint(equalTo: contentView.topAnchor, constant: NumberCGFloat.twelve),
            buttonDelete.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: NumberCGFloat.twelveMinus),
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            showCaseImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            showCaseImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            showCaseImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            showCaseImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    public func configure(images: Images?) {
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
