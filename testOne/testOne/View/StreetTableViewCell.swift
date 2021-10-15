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

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        textField.layer.cornerRadius = 20
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
        let coverView = UIImageView(frame: .zero)
        coverView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(coverView)
        self.coverView = coverView

        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel

        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.coverView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.coverView.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.coverView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.coverView.trailingAnchor),

            self.contentView.centerXAnchor.constraint(equalTo: self.titleLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])

        self.titleLabel.font = UIFont.systemFont(ofSize: 64)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.coverView.image = nil
    }
}
