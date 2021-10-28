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

    var arrayStreet: [Street] = []
    var indexCellWherePutImages: Int?
    var streetWhyPick: Street!
    let store = Storage.storage()


    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // наблюдатель за значениями
        FirebaseDatabaseProject.ref.observe(.value) { [weak self] snapshot in
            var arrayStreetTwo = [Street]()
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot,
                    let street = Street(snapshot: snapshot) else { continue }
                arrayStreetTwo.append(street)
            }
            self?.arrayStreet = arrayStreetTwo
            self?.tableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // удаляем всех обзерверов
        FirebaseDatabaseProject.ref.removeAllObservers()
    }

    @IBAction func buttonAc() {
        let newStreetTask = Street(lable: "Название локации")
        arrayStreet.append(newStreetTask)
        // создание новый улицы в firebase
        let newSteet = FirebaseDatabaseProject.ref.child("location\(arrayStreet.count)")
        newSteet.setValue(newStreetTask.convertStreetDictionary())
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DemoImagesVC = segue.destination as? DemoImagesViewController {
            DemoImagesVC.imageUrl = sender as? String
        }
    }
    
    
    
    
    func uploadImageFireStorege(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let storeRef = store.reference().child("photo").child(GetDate.time)
        guard let data = photo.jpegData(compressionQuality: 0.4) else { return }
        let metaDate = StorageMetadata()
        metaDate.contentType = "image/jpeg"

        storeRef.putData(data, metadata: metaDate) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            storeRef.downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
    private func startSetting() {
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
        cell.textrr?.placeholder = street.lable
        if street.arrayImage.count >= 1 {
            cell.stackFive.isHidden = false
            cell.collectionView.reloadData()
        } else {
            cell.stackFive.isHidden = true
            cell.collectionView.reloadData()
        }
        return cell
    }

}

extension DemoViewController: DelegatReturnTable {
    func openImage(images: String?) {
        performSegue(withIdentifier: "seguePhoto", sender: images)
    }
    
    func deleteImageWithtable(index: Int, nameCell: [String]) {
        for title in nameCell {
            for (_, cell) in arrayStreet[index].arrayImage.enumerated() {
                if cell?.title == title {
//                    arrayStreet[index].arrayImage.remove(at: inde)
                    let ref = arrayStreet[index].ref?.child("arrayImage").child(title)
                    ref?.removeValue { _, _ in }
                }
            }
        }
    }

    // добавление нового фото
    func returnTableReview(index: Int, street: Street) {
        indexCellWherePutImages = index
        streetWhyPick = street
        cooseImagePicker(source: .photoLibrary)
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


    // рабочий выбор фото
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        uploadImageFireStorege(photo: image) { [weak self] (result) in
            switch result {
            case .success(let url):
                let imgUrl = url.absoluteString
                let newImgTask = Images(title: GetDate.time, url: imgUrl)
                guard let index = self?.indexCellWherePutImages else { return }
                let newDemoStreet = self?.arrayStreet[index].ref?.child("arrayImage").child("\(GetDate.time)")
                newDemoStreet?.setValue(newImgTask.convertStreetDictionary())
            case .failure(let error):
                print(error)
            }
        }
    }
}


