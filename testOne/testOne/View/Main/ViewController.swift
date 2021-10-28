//
//  ViewController.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorUIColor.greyThree
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TitleCell.tableCell)
        return tableView
    }()
    private let buttonAddCell: UIButton = {
        let button = UIButton(type: .system)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: NumberCGFloat.fiftyFive, weight: .regular, scale: .large)
        let image = UIImage(systemName: ImageCustomTitle.plusCircle, withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addConstraints([NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .width, multiplier: NumberCGFloat.one, constant: NumberCGFloat.zero)])
        button.layer.cornerRadius = NumberCGFloat.twenty
        button.heightAnchor.constraint(equalToConstant: NumberCGFloat.seventy).isActive = true
        button.widthAnchor.constraint(equalToConstant: NumberCGFloat.seventy).isActive = true
        return button
    }()

    private let viewTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        FirebaseDatabaseProject.ref.removeAllObservers()
    }

    @objc func pressed(_ sender: UIButton) {
        let newStreetTask = Street(lable: "Название локации")
        arrayStreet.append(newStreetTask)
        let newSteet = FirebaseDatabaseProject.ref.child("location\(arrayStreet.count)")
        newSteet.setValue(newStreetTask.convertStreetDictionary())
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ImagesVC = segue.destination as? ImagesViewController {
            ImagesVC.imageUrl = sender as? String
        }
    }

    private func uploadImageFireStorege(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let storeRef = store.reference().child(Constants.photoKey).child(GetDate.time)
        guard let data = photo.jpegData(compressionQuality: NumberCGFloat.zeroFore) else { return }
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


    private func setupTableView() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: viewTop.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupButton() {
        buttonAddCell.rightAnchor.constraint(equalTo: view.rightAnchor, constant: NumberCGFloat.twentyFiveMinus).isActive = true
        buttonAddCell.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: NumberCGFloat.fortyMinus).isActive = true
    }

    func setupViewTop() {
        viewTop.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewTop.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewTop.topAnchor.constraint(equalTo: view.topAnchor, constant: NumberCGFloat.thirty).isActive = true
        viewTop.heightAnchor.constraint(equalToConstant: 150).isActive = true
        let imageTop = UIImageView()
        imageTop.image = #imageLiteral(resourceName: "logo")
        imageTop.translatesAutoresizingMaskIntoConstraints = false
        viewTop.addSubview(imageTop)
        imageTop.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        imageTop.centerXAnchor.constraint(equalTo: viewTop.centerXAnchor).isActive = true
        let labelTop = UILabel()
        labelTop.text = "ЛОКАЦИИ"
        labelTop.textAlignment = .center
        labelTop.textColor = #colorLiteral(red: 0.1294117647, green: 0.1254901961, blue: 0.1254901961, alpha: 1)
        labelTop.font = UIFont(name: "Oswald-Regular", size: 37)
        labelTop.translatesAutoresizingMaskIntoConstraints = false
        viewTop.addSubview(labelTop)
        labelTop.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        labelTop.centerXAnchor.constraint(equalTo: viewTop.centerXAnchor).isActive = true
    }
    private func startSetting() {
        buttonAddCell.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: NumberCGFloat.zero, left: NumberCGFloat.zero, bottom: NumberCGFloat.zero, right: NumberCGFloat.zero)
        tableView.separatorStyle = .none

        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        view.addSubview(viewTop)
        setupViewTop()
        view.addSubview(tableView)
        setupTableView()
        view.addSubview(buttonAddCell)
        setupButton()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayStreet.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.tableCell, for: indexPath) as! TableViewCell
        cell.delegate = self
        cell.indexStreet = indexPath.row
        let street = arrayStreet[indexPath.row]
        cell.oneIsStreet = street
        cell.textFieldMain.placeholder = street.lable
        if street.arrayImage.count >= NumberInt.one {
            cell.stackViewFive.isHidden = false
            cell.collectionView.reloadData()
        } else {
            cell.stackViewFive.isHidden = true
            cell.collectionView.reloadData()
        }
        return cell
    }
}

extension ViewController: DelegatReturnTables {
    func openImages(images: String?) {
        performSegue(withIdentifier: SegueTitle.photos, sender: images)
    }
    func deleteImageWithtables(index: Int, nameCell: [String]) {
        for title in nameCell {
            for (_, cell) in arrayStreet[index].arrayImage.enumerated() {
                if cell?.title == title {
                    let ref = arrayStreet[index].ref?.child(Constants.arrayImageKey).child(title)
                    ref?.removeValue { _, _ in }
                }
            }
        }
    }
    func returnTableReviews(index: Int, street: Street) {
        cooseImagePicker(source: .photoLibrary)
        indexCellWherePutImages = index
        streetWhyPick = street
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        uploadImageFireStorege(photo: image) { [weak self] (result) in
            switch result {
            case .success(let url):
                let imgUrl = url.absoluteString
                let newImgTask = Images(title: GetDate.time, url: imgUrl)
                guard let index = self?.indexCellWherePutImages else { return }
                let newDemoStreet = self?.arrayStreet[index].ref?.child(Constants.arrayImageKey).child("\(GetDate.time)")
                newDemoStreet?.setValue(newImgTask.convertStreetDictionary())
            case .failure(let error):
                print(error)
            }
        }
    }
}
