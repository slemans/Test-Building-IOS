//
//  demoTableViewCell.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit

protocol DelegatReturnTable: AnyObject {
    func reloatDataBase()
    func returnTableReview(index: Int, street: Street)
    func deleteImageWithtable(index: Int, indexCell: [Int])
    func openImage(image: UIImage?)
}



class DemoTableViewCell: UITableViewCell {

    @IBOutlet weak var textrr: UITextField!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var steackTwo: UIStackView!
    @IBOutlet weak var stackOne: UIStackView!
    @IBOutlet weak var stackFive: UIStackView!
    @IBOutlet weak var stackThree: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonDelete: UIButton!

    var oneIsStreet: Street!
    var indexStreet: Int!
    var arrayIndexImages: [Int] = []
    var arrayNameImages: [String] = []
    weak var delegate: DelegatReturnTable?

    override func awakeFromNib() {
        super.awakeFromNib()
        start()
    }


    // длинное нажатие на картинку
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer!) {
        if gesture.state != .ended {
            return
        }
        buttonDelete.isHidden = false
        delegate?.reloatDataBase()
        collectionView.reloadData()
    }

    // изменения название lable
    @IBAction func editingTextFielAct(_ sender: UITextField) {
        if sender.text?.count ?? 0 >= 1, let text = sender.text {
            oneIsStreet.ref?.updateChildValues(["lable": text])
        }
    }

    // тень cell
    func shadowStack() {
        let corner: CGFloat = 20
        stackOne.layer.cornerRadius = corner
        stackOne.layer.shadowColor = #colorLiteral(red: 0.3803921569, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        steackTwo.layer.masksToBounds = false
        steackTwo.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        steackTwo.layer.shadowOpacity = 0.3
        steackTwo.layer.shadowRadius = 6.0
    }

    // тень для кнопки Удалить
    func shadowStackButton() {
        let corner: CGFloat = 20
        buttonDelete.layer.cornerRadius = corner
        buttonDelete.layer.shadowColor = #colorLiteral(red: 0.3803921569, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        buttonDelete.layer.shadowRadius = 6.0
        buttonDelete.layer.shadowOpacity = 0.3
        buttonDelete.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }



    @IBAction func buttonAddImages() {
        delegate?.returnTableReview(index: indexStreet, street: oneIsStreet)
    }

    @IBAction func buttonDeleteAct() {
        buttonDelete.isHidden = true
        if oneIsStreet.arrayImage.count == 0 {
            stackFive.isHidden = true
        }
        delegate?.deleteImageWithtable(index: indexStreet, indexCell: arrayIndexImages)
        arrayIndexImages.removeAll()
        collectionView.reloadData()
    }

    public func start() {
        stackThree.layer.borderColor = #colorLiteral(red: 0.9263823628, green: 0.9255852103, blue: 0.921618104, alpha: 1)
        stackThree.layer.borderWidth = 1


        // долгое нажатие long press
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressedGesture.minimumPressDuration = 1.0
        longPressedGesture.delegate = self
        self.collectionView.addGestureRecognizer(longPressedGesture)

        buttonDelete.isHidden = true

        collectionView.dataSource = self
        collectionView.delegate = self
        buttonDelete.layer.borderWidth = 1
        buttonDelete.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        buttonDelete.layer.cornerRadius = buttonDelete.frame.size.height / 2
        buttonAdd.layer.cornerRadius = buttonAdd.frame.size.height / 2
        steackTwo.layer.cornerRadius = 20
        stackThree.layer.cornerRadius = 20
        shadowStack()
        shadowStackButton()
    }

}

extension DemoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneIsStreet.arrayImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellDemo", for: indexPath) as! DemoCollectionViewCell
        let imageStreet = oneIsStreet.arrayImage[indexPath.row]
        cell.configure(images: imageStreet)
        cell.delegate = self
        if buttonDelete.isHidden == false {
            cell.buttonDelete.isHidden = false
        } else {
            cell.buttonDelete.isHidden = true
        }
        if imageStreet?.pick != true {
            cell.buttonDelete.setTitle("", for: .normal)
        } else {
            cell.buttonDelete.setTitle("x", for: .normal)
        }
        cell.indexCollectionViewCell = indexPath.row
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeData = oneIsStreet.arrayImage[indexPath.row]?.image
        delegate?.openImage(image: recipeData)
    }
}

// вид UICollectioncell
extension DemoTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 3.0
        let padding = 5 * (itemPerRow + 2.0)
        let availableWidth = collectionView.frame.width - padding
        let widthPerItem = availableWidth / itemPerRow
        let height = CGFloat(125)
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

// работа с collectionCell по делегату с cell
extension DemoTableViewCell: DelegatDeleteCollectionViewCell {
    func deleteCollectionViewCell(index: Int) {
        if oneIsStreet.arrayImage[index]?.pick != true {
            oneIsStreet.arrayImage[index]?.pick = true
            arrayIndexImages.append(index)
            arrayNameImages.append(oneIsStreet.arrayImage[index]!.title) // добавил titile  вновый массив
        } else {
            oneIsStreet.arrayImage[index]?.pick = false
            for (indexArray, value) in arrayIndexImages.enumerated() {
                if index == value {
                    arrayIndexImages.remove(at: indexArray)
                }
            }
            for title in arrayNameImages{
//                if title
            }
        }
        print(arrayIndexImages)
        collectionView.reloadData()
    }
}


