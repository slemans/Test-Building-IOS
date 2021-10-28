//
//  StreetTableViewCell.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit

protocol DelegatReturnTables: AnyObject {
    func returnTableReviews(index: Int, street: Street)
    func deleteImageWithtables(index: Int, nameCell: [String])
    func openImages(images: String?)
}

class TableViewCell: UITableViewCell {
    
    var stackViewOne: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        stackView.spacing = 0
        stackView.contentMode = .scaleToFill
        stackView.semanticContentAttribute = .unspecified
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 20
        stackView.layer.shadowColor = #colorLiteral(red: 0.3803921569, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        return stackView
    }()

    let stackViewTwo = UIStackView()
    let stackViewTree = UIStackView()
    let stackViewFour = UIStackView()
    var stackViewFive = UIStackView()
    
    var oneIsStreet: Street!
    var indexStreet: Int!
    var arrayNameImages: [String] = []
    weak var delegate: DelegatReturnTables?
    
     let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        return collectionView
    }()
    
    
    let buttonAddPhoto: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular, scale: .large)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addConstraints([NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1, constant: 0)])
        button.layer.cornerRadius = 20
        return button
    }()
    
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
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }

    @objc func editingTextFielAct(_ sender: UITextField) {
        if sender.text?.count ?? 0 >= 1, let text = sender.text {
            oneIsStreet.ref?.updateChildValues(["lable": text])
        }
    }
    
    @objc func addNewPhoto(_ sender: UIButton) {
        delegate?.returnTableReviews(index: indexStreet, street: oneIsStreet)
    }

    @objc func handleLongPress(gesture: UILongPressGestureRecognizer!) {
        if gesture.state != .ended {
            return
        }
        buttonDelete.isHidden = false
        collectionView.reloadData()
    }
    
    @objc func pressedDeleteAll(_ sender: UIButton) {
        buttonDelete.isHidden = true
        if oneIsStreet.arrayImage.count == 0 {
            stackViewFive.isHidden = true
        }
        delegate?.deleteImageWithtables(index: indexStreet, nameCell: arrayNameImages)
        arrayNameImages.removeAll()
        collectionView.reloadData()
    }
    
    
    func initialize() {
        textFieldMain.addTarget(self, action: #selector(editingTextFielAct(_:)), for: .editingDidEnd)
        buttonDelete.addTarget(self, action: #selector(pressedDeleteAll(_:)), for: .touchUpInside)
        buttonAddPhoto.addTarget(self, action: #selector(addNewPhoto(_:)), for: .touchUpInside)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // long press
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressedGesture.minimumPressDuration = 1.0
        longPressedGesture.delegate = self
        self.collectionView.addGestureRecognizer(longPressedGesture)
        
        /// четвертый стек
        
        // первый стек внутри четвертого стека
        let stackViewFourOne = UIStackView()
        stackViewFourOne.axis = .vertical
        stackViewFourOne.distribution = .fill
        stackViewFourOne.alignment = .fill
        stackViewFourOne.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0)
        stackViewFourOne.spacing = 0
        stackViewFourOne.layer.cornerRadius = 20
        stackViewFourOne.translatesAutoresizingMaskIntoConstraints = false
        
        // четверты стек
        stackViewFour.addArrangedSubview(textFieldMain)
        stackViewFour.addArrangedSubview(stackViewFourOne)
        stackViewFour.axis = .horizontal
        stackViewFour.distribution = .fill
        stackViewFour.alignment = .fill
        stackViewFour.spacing = 0
        stackViewFour.contentMode = .scaleToFill
        stackViewFour.semanticContentAttribute = .unspecified
        stackViewFour.layer.cornerRadius = 20
        stackViewFour.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        stackViewFour.translatesAutoresizingMaskIntoConstraints = false
        
        // кнопка добавить новое фото
         stackViewFourOne.addArrangedSubview(buttonAddPhoto)
        
        
        // второй стек внутри четвертого стека
        stackViewFive.addArrangedSubview(collectionView)
        stackViewFive.axis = .vertical
        stackViewFive.distribution = .fill
        stackViewFive.alignment = .fill
        stackViewFive.spacing = 0
        stackViewFive.contentMode = .scaleToFill
        stackViewFive.semanticContentAttribute = .unspecified
        stackViewFive.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
        stackViewFive.isLayoutMarginsRelativeArrangement = true
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
        
 
        contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        contentView.addSubview(stackViewOne)
        stackViewOne.addArrangedSubview(stackViewTwo)
        contentView.addSubview(buttonDelete)
        settingButtonDeleteAll()
        NSLayoutConstraint.activate([
            stackViewOne.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewOne.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackViewOne.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackViewOne.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            stackViewFive.heightAnchor.constraint(equalToConstant: 115),
            buttonAddPhoto.heightAnchor.constraint(equalToConstant: 42),
            stackViewFour.heightAnchor.constraint(equalToConstant: 45),
            buttonAddPhoto.rightAnchor.constraint(equalTo: stackViewFourOne.rightAnchor),
            buttonAddPhoto.leftAnchor.constraint(equalTo: stackViewFourOne.leftAnchor),
            buttonAddPhoto.bottomAnchor.constraint(equalTo: stackViewFourOne.bottomAnchor),
            buttonAddPhoto.topAnchor.constraint(equalTo: stackViewFourOne.topAnchor),
            
            collectionView.topAnchor.constraint(equalTo: stackViewFive.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: stackViewFive.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: stackViewFive.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: stackViewFive.rightAnchor, constant: -10)
           
            ])
    }
   
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
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneIsStreet.arrayImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        let imageStreet = oneIsStreet.arrayImage[indexPath.row]
        cell.configure(images: imageStreet)
        cell.delegate = self
        if buttonDelete.isHidden == false {
            cell.buttonDelete.isHidden = false
        } else {
            cell.buttonDelete.isHidden = true
        }
        if imageStreet?.pick != true {
            cell.buttonDelete.setImage(ConstantsImage.imageDeleteEmpty, for: .normal)
        } else {
            cell.buttonDelete.setImage(ConstantsImage.imageDelete, for: .normal)
        }
        cell.indexCollectionViewCell = indexPath.row
        cell.nameCollectionViewCell = imageStreet?.title      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = oneIsStreet.arrayImage[indexPath.row]?.url
        delegate?.openImages(images: image)
    }
    
    
}

extension TableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 3.0
        let padding = 5 * (itemPerRow + 2.0)
        let availableWidth = collectionView.frame.width - padding
        let widthPerItem = availableWidth / itemPerRow
        let height = widthPerItem
        return CGSize(width: widthPerItem, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension TableViewCell: DelegatDeleteCollectionsViewCell {
    func deleteCollectionsViewCell(index: Int, title: String) {
        if oneIsStreet.arrayImage[index]?.pick != true {
            oneIsStreet.arrayImage[index]?.pick = true
            arrayNameImages.append(oneIsStreet.arrayImage[index]!.title) // добавил title  в новый массив
        } else {
            oneIsStreet.arrayImage[index]?.pick = false
            for (indexArray, value) in arrayNameImages.enumerated() {
                if value == title {
                    arrayNameImages.remove(at: indexArray)
                    collectionView.reloadData()
                }
            }
        }
    }
}
