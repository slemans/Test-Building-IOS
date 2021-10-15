//
//  demoTableViewCell.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit

protocol DelegatReturnTable: AnyObject {
    func returnTableReview()
//    func createAlert()
}

class demoTableViewCell: UITableViewCell {

    @IBOutlet weak var textrr: UITextField!
    @IBOutlet weak var bt: UIButton!
    @IBOutlet weak var steackTwo: UIStackView!
    @IBOutlet weak var stackOne: UIStackView!
    @IBOutlet weak var stackFive: UIStackView!
    @IBOutlet weak var stackThree: UIStackView!
    @IBOutlet weak var images: UIImageView!
    
 
    
    weak var delegate: DelegatReturnTable?
    override func awakeFromNib() {
        super.awakeFromNib()
        start()
        
    }
    @IBAction func buttonAddImages() {
        stackFive.isHidden = false
        delegate?.returnTableReview()
        print("добавить фото")
    }
    
    func start(){
        bt.layer.cornerRadius = bt.frame.size.height / 2
        steackTwo.layer.cornerRadius = 20
        stackThree.layer.cornerRadius = 20
//        stackFive.isHidden = true
    }
    func fetchStreet(street: Street){
        if street.arrayImage.count != 0{
            self.stackFive.isHidden = false
        } else {
            self.stackFive.isHidden = true
        }
    }
    

}

