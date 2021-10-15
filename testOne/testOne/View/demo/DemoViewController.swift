//
//  DemoViewController.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit

class DemoViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    
    var arrayStreet: [Street] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayStreet.append(Street(lable: "Название локации", arrayImage: [Images(image: #imageLiteral(resourceName: "pfoto1")), Images(image: #imageLiteral(resourceName: "pfoto3")), Images(image: #imageLiteral(resourceName: "pfoto2"))]))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        button.layer.cornerRadius = button.frame.size.height / 2
        
    }
    @IBAction func buttonAc() {
        arrayStreet.append(Street(lable: "Название локации", arrayImage: [nil]))
        print("Добавил")
        tableView.reloadData()
    }
    

}


extension DemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayStreet.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDemo", for: indexPath) as! demoTableViewCell
        cell.delegate = self
        let street = arrayStreet[indexPath.row]
        cell.fetchStreet(street: street)
        return cell
    }
}

extension DemoViewController: DelegatReturnTable {
    func returnTableReview() {
        cooseImagePicker(source: .photoLibrary)
//        tableView.reloadData()
        
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
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        arrayStreet[0].arrayImage.append(Images(image: image))
        print("сохранение")
//        imagesProfileUser.image = info[.editedImage] as? UIImage
//        imagesProfileUser.contentMode = .scaleAspectFill
//        imagesProfileUser.clipsToBounds = true // pruning photo for border Lb
//        imageIsChanged = true
//        userImagesAndName(image: info[.editedImage] as? UIImage, name: nil)
//        dismiss(animated: true)
    }
}
