//
//  StreetTableViewCell.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit

protocol DelegatReturnTables: AnyObject {
    
}

class StreetTableViewCell: UITableViewCell {

    weak var coverView: UIImageView!
    weak var titleLabel: UILabel!
    
    
    var stackViewOne = UIStackView()
    let stackViewTwo = UIStackView()
    let stackViewTree = UIStackView()
    let stackViewFour = UIStackView()
    var stackViewFive = UIStackView()
    
    var oneIsStreet: Street!
    var indexStreet: Int!
    weak var delegate: DelegatReturnTables?


    
    let textFieldMain: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 20
        textField.textColor = #colorLiteral(red: 0.5254901961, green: 0.5803921569, blue: 0.5843137255, alpha: 1)
        textField.font = UIFont(name: "Arial", size: 21)
        return textField
    }()
    
    let buttonDelete: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(("Удалить"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
        button.tintColor = .white
        button.titleLabel!.font = UIFont(name: "Arial", size: 18)
        button.titleLabel!.textAlignment = .center
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.addTarget(self, action: #selector(pressedDeleteAll(_:)), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    @objc func pressedDeleteAll(_ sender: UIButton) {
        print("Удалить все фото")
    }
    

    
    func initialize() {
        
        
        
        /// четвертый стек
        
        // первый стек внутри четвертого стека
        let stackViewFourOne = UIStackView()
        stackViewFourOne.axis = .vertical
        stackViewFourOne.distribution = .fill
        stackViewFourOne.alignment = .fill
        stackViewFourOne.spacing = 0
        stackViewFourOne.translatesAutoresizingMaskIntoConstraints = false
        
        // четверты стек
        stackViewFour.addArrangedSubview(textFieldMain)
        stackViewFour.addArrangedSubview(stackViewFourOne)
        stackViewFour.axis = .horizontal
        stackViewFour.distribution = .fill
        stackViewFour.alignment = .fill
        stackViewFour.spacing = 0
        stackViewFour.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        stackViewFour.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // кнопка добавить новое фото
        let buttonAddPhoto = UIButton(type: .custom)
        buttonAddPhoto.setImage(UIImage(named: "plus.circle.fill"), for:  .normal)
//        buttonAddPhoto.setTitle(("+"), for: .normal) plus.circle.fill
        buttonAddPhoto.tintColor = .black
        buttonAddPhoto.confuge
        buttonAddPhoto.translatesAutoresizingMaskIntoConstraints = false
        buttonAddPhoto.backgroundColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
        buttonAddPhoto.tintColor = .white
        buttonAddPhoto.titleLabel!.textAlignment = .center
        buttonAddPhoto.layer.cornerRadius = 20
//        buttonAddPhoto.addTarget(self, action: #selector(pressedDeleteAll(_:)), for: .touchUpInside)
        stackViewFourOne.addArrangedSubview(buttonAddPhoto)
        
        
        // второй стек внутри четвертого стека
//        stackViewFive.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        stackViewFive.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        stackViewFive.axis = .vertical
        stackViewFive.distribution = .fill
        stackViewFive.alignment = .fill
        stackViewFive.spacing = 0
        stackViewFive.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // третий стек
        stackViewTree.addArrangedSubview(stackViewFour)
        stackViewTree.addArrangedSubview(stackViewFive)
        stackViewTree.axis = .vertical
        stackViewTree.distribution = .fill
        stackViewTree.alignment = .fill
        stackViewTree.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        stackViewTree.spacing = 0
        stackViewTree.contentMode = .scaleToFill
        stackViewTree.semanticContentAttribute = .unspecified
        stackViewTree.layoutMargins = UIEdgeInsets(top: 2, left: 10, bottom: 5, right: 0)
        stackViewTree.isLayoutMarginsRelativeArrangement = true
        stackViewTree.translatesAutoresizingMaskIntoConstraints = false
        stackViewTree.layer.masksToBounds = false
        stackViewTree.layer.cornerRadius = 20
        stackViewTree.layer.borderColor = #colorLiteral(red: 0.9263823628, green: 0.9255852103, blue: 0.921618104, alpha: 1)
        stackViewTree.layer.borderWidth = 1
        
        // второй стек
        stackViewTwo.addArrangedSubview(stackViewTree)
        stackViewTwo.axis = .vertical
        stackViewTwo.distribution = .fill
        stackViewTwo.alignment = .fill
        stackViewTwo.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        stackViewTwo.spacing = 0
        stackViewTwo.contentMode = .scaleToFill
        stackViewTwo.semanticContentAttribute = .unspecified
        stackViewTwo.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        stackViewTwo.isLayoutMarginsRelativeArrangement = true
        stackViewTwo.translatesAutoresizingMaskIntoConstraints = false
        stackViewTwo.layer.masksToBounds = false
        stackViewTwo.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        stackViewTwo.layer.shadowOpacity = 0.3
        stackViewTwo.layer.shadowRadius = 6.0
        stackViewTwo.layer.cornerRadius = 20
        
        
        // первый стек
        stackViewOne.addArrangedSubview(stackViewTwo)
        stackViewOne.axis = .vertical
        stackViewOne.distribution = .fill
        stackViewOne.alignment = .fill
        stackViewOne.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        stackViewOne.spacing = 0
        stackViewOne.contentMode = .scaleToFill
        stackViewOne.semanticContentAttribute = .unspecified
        stackViewOne.translatesAutoresizingMaskIntoConstraints = false
        stackViewOne.layer.cornerRadius = 20
        stackViewOne.layer.shadowColor = #colorLiteral(red: 0.3803921569, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        
        

        
        
        contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        contentView.addSubview(stackViewOne)
        contentView.addSubview(buttonDelete)
        settingButtonDeleteAll()
        NSLayoutConstraint.activate([
            stackViewOne.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewOne.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackViewOne.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackViewOne.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            
            textFieldMain.leftAnchor.constraint(equalTo: stackViewFour.leftAnchor),
            textFieldMain.topAnchor.constraint(equalTo: stackViewFour.topAnchor),
            textFieldMain.bottomAnchor.constraint(equalTo: stackViewFour.bottomAnchor),
            
            
            stackViewFourOne.rightAnchor.constraint(equalTo: stackViewFour.rightAnchor),
            stackViewFourOne.topAnchor.constraint(equalTo: stackViewFour.topAnchor),
            stackViewFourOne.bottomAnchor.constraint(equalTo: stackViewFour.bottomAnchor),
            
            stackViewFive.heightAnchor.constraint(equalToConstant: 140),
            buttonAddPhoto.heightAnchor.constraint(equalToConstant: 42),
            stackViewFour.heightAnchor.constraint(equalToConstant: 45)
            
//            buttonAddPhoto.rightAnchor.constraint(equalTo: stackViewFourOne.rightAnchor),
//            buttonAddPhoto.leftAnchor.constraint(equalTo: stackViewFourOne.leftAnchor),
//            buttonAddPhoto.bottomAnchor.constraint(equalTo: stackViewFourOne.bottomAnchor),
//            buttonAddPhoto.topAnchor.constraint(equalTo: stackViewFourOne.topAnchor)
            
           
            ])



    }


//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        self.coverView.image = nil
//    }
    
    
    func settingButtonDeleteAll(){
        buttonDelete.isHidden = true
        buttonDelete.layer.shadowColor = #colorLiteral(red: 0.3803921569, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        buttonDelete.layer.shadowRadius = 6.0
        buttonDelete.layer.shadowOpacity = 0.3
        buttonDelete.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        buttonDelete.layer.borderWidth = 1
        buttonDelete.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        buttonDelete.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 120).isActive = true
        buttonDelete.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -120).isActive = true
        buttonDelete.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
    }
}
