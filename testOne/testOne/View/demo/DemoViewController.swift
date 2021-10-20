//
//  DemoViewController.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit
import Firebase




class DemoViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!

    let demoTableViewCellVC = DemoTableViewCell()
    var arrayStreet: [Street] = []
    var indexCellWherePutImages: Int?
    

    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
//        arrayStreet.append(Street(lable: "Название локации", arrayImage: [Images(image: #imageLiteral(resourceName: "pfoto1")), Images(image: #imageLiteral(resourceName: "pfoto3")), Images(image: #imageLiteral(resourceName: "pfoto2"))]))
//        arrayStreet.append(Street(lable: "Название локации", arrayImage: []))
        arrayStreet.append(Street(lable: "Название локации", images: [Images(image: #imageLiteral(resourceName: "pfoto1"))]))
        arrayStreet.append(Street(lable: "Название локации"))

        ref = Database.database().reference(withPath: "Streets")
        print(arrayStreet)
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        // наблюдатель за значениями
//        ref.observe(.value) { [weak self] snapshot in
//            var arrayStreetTwo = [Street]()
//            for item in snapshot.children {
//                guard let snapshot = item as? DataSnapshot,
//                      let street = Street(snapshot: snapshot) else { continue }
//                arrayStreetTwo.append(street)
//            }
//            self?.arrayStreet = arrayStreetTwo
//            self?.tableView.reloadData()
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // удаляем всех обзерверов
//        ref.removeAllObservers()
//    }

    @IBAction func buttonAc() {
        let newStreet = Street(lable: "Название локации")
        arrayStreet.append(newStreet)
        tableView.reloadData()
        // создание новый улицы в firebase
        let newSteet = FirebaseDatabaseProject.ref.child("\(arrayStreet.count)")
        newSteet.ref.setValue([
            "lable": "Название локации",
            "arrayImage": [nil]
            ])

//        newSteet.ref.setValue([
//            "lable": "Название локации",
//            "arrayImage": [
//                "image": "gs://testone-abe3e.appspot.com/images/pfoto1.jpg",
//                "pick": false
//            ]
//            ])
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DemoImagesVC = segue.destination as? DemoImagesViewController {
            DemoImagesVC.image = sender as? UIImage
        }
    }
    public func startSetting() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        button.layer.cornerRadius = button.frame.size.height / 2
    }
}


extension DemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayStreet.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDemo", for: indexPath) as! DemoTableViewCell
        cell.delegate = self
        cell.indexStreet = indexPath.row
        let street = arrayStreet[indexPath.row]
        cell.oneIsStreet = street
        print(street.arrayImage.count)
        
        if street.arrayImage.count >= 1{
            cell.stackFive.isHidden = false
            cell.collectionView.reloadData()
        } else {
            cell.stackFive.isHidden = true
            cell.collectionView.reloadData()
        }
        
//        if street.arrayImage.count >= 1 {
//            cell.stackFive.isHidden = false
//            cell.collectionView.reloadData()
//        } else {
//            cell.stackFive.isHidden = true
//            cell.collectionView.reloadData()
//        }
        print(street)
        return cell
    }
}

extension DemoViewController: DelegatReturnTable {
    func reloatDataBase() {
        tableView.reloadData()
    }

    func deleteImageWithtable(index: Int, indexCell: [Int]) {
        let sortedIndexCell = indexCell.sorted(by: >)
        for (_, value) in sortedIndexCell.enumerated() {
                arrayStreet[index].arrayImage.remove(at: value)
            
        }
        tableView.reloadData()
    }

    // добавление нового фото
    func returnTableReview(index: Int) {
        indexCellWherePutImages = index
        cooseImagePicker(source: .photoLibrary)
    }

    func openImage(image: UIImage?) {
        performSegue(withIdentifier: "seguePhoto", sender: image)
    }
}


extension DemoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // select what we open and allow to edit the image
    func cooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

        guard let index = indexCellWherePutImages else { return }
        arrayStreet[index].arrayImage.append(Images(image: image))
        tableView.reloadData()
    }
}


