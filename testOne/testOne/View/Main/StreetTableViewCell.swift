//
//  StreetTableViewCell.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit

class StreetTableViewCell: UITableViewCell {
    
    weak var coverView: UIImageView!
    weak var titleLabel: UILabel!
    weak var stackView: UIStackView!

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        textField.textColor = #colorLiteral(red: 0.5254901961, green: 0.5803921569, blue: 0.5843137255, alpha: 1)
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.cornerRadius = 10
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    func initialize() {
//        let textField = UITextField(frame: .zero)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
//        textField.layer.cornerRadius = 20
//        self.contentView.addSubview(textField)
        
//        textField.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
//        textField.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//        textField.topAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .green
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        self.contentView.addSubview(stackView)
        

        NSLayoutConstraint.activate([
            
//            self.contentView.topAnchor.constraint(equalTo: self.stackView.topAnchor),
//            self.contentView.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
//            self.contentView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
//            self.contentView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
//            self.contentView.centerXAnchor.constraint(equalTo: self.titleLabel.centerXAnchor),
//            self.contentView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])
        self.textField.font = UIFont.systemFont(ofSize: 21)
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        self.coverView.image = nil
//    }
}
