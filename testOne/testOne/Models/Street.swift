//
//  Street.swift
//  testOne
//
//  Created by sleman on 14.10.21.
//

import UIKit
import Firebase

struct Street {
    var lable: String
    let ref: DatabaseReference?
    var arrayImage: [Images?]

    // локально
    init(lable: String, images: [Images]) {
        self.lable = lable
        self.ref = nil
        self.arrayImage = images
    }
    //
    init(lable: String) {
        self.lable = lable
        self.ref = nil
        self.arrayImage = []
    }
    
    

    // из сети
    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: Any],
            let lable = snapshotValue[Constants.lableKey] as? String
            else { return nil }
        self.lable = lable
        ref = snapshot.ref
        self.arrayImage = []
    }
    private enum Constants {
        static let lableKey = "lable"
        static let arrayImageKey = "arrayImage"
    }
}
struct Images {
    let image: UIImage
    var pick: Bool = false
    init(image: UIImage){
        self.image = image
    }
}
