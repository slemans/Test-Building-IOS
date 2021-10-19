//
//  DemoImagesViewController.swift
//  testOne
//
//  Created by sleman on 18.10.21.
//

import UIKit

class DemoImagesViewController: UIViewController {

    @IBOutlet weak var imagesColectionView: UIImageView!
    @IBOutlet weak var button: UIButton!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = button.frame.size.height / 2
        imagesColectionView.image = image
    }
    
    @IBAction func buttonAct() {
        dismiss(animated: true)
    }
    
    


}
