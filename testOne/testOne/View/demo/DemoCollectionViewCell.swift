//
//  DemoCollectionViewCell.swift
//  testOne
//
//  Created by sleman on 16.10.21.
//

import UIKit

protocol DelegatDeleteCollectionViewCell: AnyObject {
    func deleteCollectionViewCell(index: Int)
}

class DemoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var buttonDelete: UIButton!
    
    weak var delegate: DelegatDeleteCollectionViewCell?
    let colorButoonDelete:UIColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
    var indexCollectionViewCell: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        
        buttonDelete.isHidden = true
        buttonDelete.layer.cornerRadius = buttonDelete.frame.size.height / 2
        buttonDelete.layer.borderWidth = 1
        buttonDelete.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
        buttonDelete.setTitleColor(colorButoonDelete, for: .normal)
    }
    
    func configure(images: Images?) {
        guard let images = images else { return }
        image.image = images.image
    }
    @IBAction func buttonDeleteImageAction() {
        print("Удалить Image")
        buttonDelete.setTitle("x", for: .normal)
        delegate?.deleteCollectionViewCell(index: indexCollectionViewCell)
    }
}



