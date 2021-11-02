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
    private var stackViewOne: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = ColorUIColor.white
        stackView.spacing = NumberCGFloat.zero
        stackView.contentMode = .scaleToFill
        stackView.semanticContentAttribute = .unspecified
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = NumberCGFloat.twenty
        stackView.layer.shadowColor = ColorCGColor.grey
        return stackView
    }()
    private let stackViewTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = ColorUIColor.white
        stackView.spacing = NumberCGFloat.zero
        stackView.contentMode = .scaleToFill
        stackView.semanticContentAttribute = .unspecified
        stackView.layoutMargins = UIEdgeInsets(top: NumberCGFloat.fiftiny, left: NumberCGFloat.fiftiny, bottom: NumberCGFloat.fiftiny, right: NumberCGFloat.fiftiny)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = false
        stackView.layer.shadowOffset = CGSize(width: NumberCGFloat.zero, height: NumberCGFloat.five)
        stackView.layer.shadowOpacity = NumberFloat.zeroThree
        stackView.layer.shadowRadius = NumberCGFloat.six
        stackView.layer.cornerRadius = NumberCGFloat.twenty
        return stackView
    }()
    private let stackViewTree: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = ColorUIColor.greyOne
        stackView.spacing = NumberCGFloat.zero
        stackView.contentMode = .scaleToFill
        stackView.semanticContentAttribute = .unspecified
        stackView.layoutMargins = UIEdgeInsets(top: NumberCGFloat.two, left: NumberCGFloat.ten, bottom: NumberCGFloat.five, right: NumberCGFloat.zero)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.masksToBounds = false
        stackView.layer.cornerRadius = NumberCGFloat.twenty
        stackView.layer.borderColor = ColorCGColor.white
        stackView.layer.borderWidth = NumberCGFloat.one
        return stackView
    }()
    private let stackViewFour: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = NumberCGFloat.zero
        stackView.contentMode = .scaleToFill
        stackView.semanticContentAttribute = .unspecified
        stackView.layer.cornerRadius = NumberCGFloat.twenty
        stackView.backgroundColor = ColorUIColor.greyOne
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    var stackViewFive: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = NumberCGFloat.zero
        stackView.contentMode = .scaleToFill
        stackView.semanticContentAttribute = .unspecified
        stackView.layoutMargins = UIEdgeInsets(top: NumberCGFloat.zero, left: NumberCGFloat.zero, bottom: NumberCGFloat.ten, right: NumberCGFloat.ten)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let stackViewFourOne: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = ColorUIColor.blackWhite
        stackView.spacing = NumberCGFloat.zero
        stackView.layer.cornerRadius = NumberCGFloat.twenty
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var oneIsStreet: Street!
    var indexStreet: Int!
    var arrayNameImages: [String] = []
    weak var delegate: DelegatReturnTables?

    let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = ColorUIColor.greyOne
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: TitleCell.collectionCell)
        return collectionView
    }()
    private let buttonAddPhoto: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: NumberCGFloat.twentyTwo, weight: .regular, scale: .large)
        let image = UIImage(systemName: ImageCustomTitle.plusCircle, withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        button.tintColor = ColorUIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addConstraints([NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .width, multiplier: NumberCGFloat.one, constant: NumberCGFloat.zero)])
        button.layer.cornerRadius = NumberCGFloat.twenty
        return button
    }()

    let textFieldMain: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = NumberCGFloat.twenty
        textField.textColor = ColorUIColor.greyTwo
        textField.font = UIFont(name: FontsTitle.arial, size: NumberCGFloat.twentyOne)
        return textField
    }()

    let buttonDelete: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(("Удалить"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorUIColor.pinkCustom
        button.tintColor = ColorUIColor.white
        button.titleLabel!.font = UIFont(name: FontsTitle.arial, size: NumberCGFloat.eighteen)
        button.titleLabel!.textAlignment = .center
        button.layer.cornerRadius = NumberCGFloat.twenty
        button.heightAnchor.constraint(equalToConstant: NumberCGFloat.fortyTwo).isActive = true
        return button
    }()

    func secondSetting(number: CGFloat) {
        stackViewFive.heightAnchor.constraint(equalToConstant: number).isActive = true
//        collectionView.reloadData()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }

    @objc func editingTextFielAct(_ sender: UITextField) {
        if sender.text?.count ?? NumberInt.zero >= NumberInt.one, let text = sender.text {
            oneIsStreet.ref?.updateChildValues([Constants.lableKey: text])
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
        if oneIsStreet.arrayImage.count == NumberInt.zero {
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
        longPressedGesture.minimumPressDuration = NumberTimeInterval.one
        longPressedGesture.delegate = self
        self.collectionView.addGestureRecognizer(longPressedGesture)
        contentView.backgroundColor = ColorUIColor.greyThree
        contentView.addSubview(stackViewOne)
        stackViewOne.addArrangedSubview(stackViewTwo)
        stackViewTwo.addArrangedSubview(stackViewTree)
        stackViewTree.addArrangedSubview(stackViewFour)
        stackViewFour.addArrangedSubview(textFieldMain)
        stackViewFour.addArrangedSubview(stackViewFourOne)
        stackViewFourOne.addArrangedSubview(buttonAddPhoto)
        stackViewTree.addArrangedSubview(stackViewFive)
        stackViewFive.addArrangedSubview(collectionView)
        contentView.addSubview(buttonDelete)
        settingButtonDeleteAll()


        NSLayoutConstraint.activate([
            stackViewOne.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewOne.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackViewOne.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackViewOne.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: NumberCGFloat.twentyFiveMinus),
//            stackViewFive.heightAnchor.constraint(equalToConstant: heightStackViewFour ?? 0), // height all block
            buttonAddPhoto.heightAnchor.constraint(equalToConstant: NumberCGFloat.two),
            stackViewFour.heightAnchor.constraint(equalToConstant: NumberCGFloat.fortyFive),
            buttonAddPhoto.rightAnchor.constraint(equalTo: stackViewFourOne.rightAnchor),
            buttonAddPhoto.leftAnchor.constraint(equalTo: stackViewFourOne.leftAnchor),
            buttonAddPhoto.bottomAnchor.constraint(equalTo: stackViewFourOne.bottomAnchor),
            buttonAddPhoto.topAnchor.constraint(equalTo: stackViewFourOne.topAnchor),
            collectionView.topAnchor.constraint(equalTo: stackViewFive.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: stackViewFive.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: stackViewFive.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: stackViewFive.rightAnchor, constant: NumberCGFloat.tenMinus)
            ])
    }

    public func settingButtonDeleteAll() {
        buttonDelete.isHidden = true
        buttonDelete.layer.shadowColor = ColorCGColor.grey
        buttonDelete.layer.shadowRadius = NumberCGFloat.six
        buttonDelete.layer.shadowOpacity = NumberFloat.zeroThree
        buttonDelete.layer.shadowOffset = CGSize(width: NumberDouble.twoFive, height: NumberDouble.twoFive)
        buttonDelete.layer.borderWidth = NumberCGFloat.one
        buttonDelete.layer.borderColor = ColorCGColor.white
        buttonDelete.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: NumberCGFloat.oneHundredTwenty).isActive = true
        buttonDelete.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: NumberCGFloat.oneHundredTwentyMinus).isActive = true
        buttonDelete.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: NumberCGFloat.ten).isActive = true
    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneIsStreet.arrayImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.collectionCell, for: indexPath) as! CollectionViewCell
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
        let padding = NumberCGFloat.five * (NumberCGFloat.three + NumberCGFloat.two)
        let availableWidth = collectionView.frame.width - padding
        let widthPerItem = availableWidth / NumberCGFloat.three
        let height = widthPerItem
        return CGSize(width: widthPerItem, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: NumberCGFloat.five, left: NumberCGFloat.zero, bottom: NumberCGFloat.zero, right: NumberCGFloat.zero)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return NumberCGFloat.five
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return NumberCGFloat.zero
    }
}

extension TableViewCell: DelegatDeleteCollectionsViewCell {
    func deleteCollectionsViewCell(index: Int, title: String) {
        if oneIsStreet.arrayImage[index]?.pick != true {
            oneIsStreet.arrayImage[index]?.pick = true
            arrayNameImages.append(oneIsStreet.arrayImage[index]!.title)
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
