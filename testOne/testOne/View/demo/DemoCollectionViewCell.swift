//
//  DemoCollectionViewCell.swift
//  testOne
//
//  Created by sleman on 16.10.21.
//

import UIKit

protocol DelegatDeleteCollectionViewCell: AnyObject {
    func deleteCollectionViewCell(index: Int, title: String)
}

class DemoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    weak var delegate: DelegatDeleteCollectionViewCell?
    let colorButoonDelete:UIColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
    var indexCollectionViewCell: Int!
    var nameCollectionViewCell: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startSetting()
    }
    
    public func startSetting(){
        layer.cornerRadius = 10
        buttonDelete.isHidden = true
        buttonDelete.layer.cornerRadius = buttonDelete.frame.size.height / 2
        buttonDelete.layer.borderWidth = 1
        buttonDelete.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
        buttonDelete.setTitleColor(colorButoonDelete, for: .normal)
    }
    
    func configure(images: Images?) {
        guard let images = images else { return }
        putImage(image: images.url)
    }
    @IBAction func buttonDeleteImageAction() {
        buttonDelete.setTitle("x", for: .normal)
        delegate?.deleteCollectionViewCell(index: indexCollectionViewCell, title: nameCollectionViewCell)
    }
    private func putImage(image: String?) {
        guard let image = image,
            let urlImg = URL(string: image) else { return }
        URLSession.shared.dataTask(with: urlImg) { [weak self] data, _, _ in
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image.image = image
                        self?.indicator.stopAnimating()
                    }
                }
            }
        }.resume()
    }
    
}



