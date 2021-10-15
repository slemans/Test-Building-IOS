//
//  demoTableViewCell.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit

class demoTableViewCell: UITableViewCell {

    @IBOutlet weak var textrr: UITextField!
    @IBOutlet weak var bt: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
