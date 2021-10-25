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
        var arrayImageTwo: [Images?] = []
        guard let snapshotValue = snapshot.value as? [String: Any],
              let lable = snapshotValue[Constants.lableKey] as? String
            else { return nil }
        if let favoritedDate = snapshotValue["arrayImage"] as? [String: [String: String]] {
            for (_, value) in favoritedDate{
                var title = ""
                var url = ""
                for (key, date) in value{
                    if key == "title"{
                        title = date
                    } else{
                        url = date
                    }
                }
                arrayImageTwo.append(Images(title: title, url: url))
            }
        }
        self.lable = lable
        ref = snapshot.ref
        self.arrayImage = arrayImageTwo
    }
    
    func convertStreetDictionary() -> [String: Any]{
        [Constants.lableKey: lable, Constants.arrayImageKey: []]
    }

}
struct Images {
    let url: String
    let title: String
    var pick: Bool = false
    
    init(image: UIImage){
        self.title = "demoTitle"
        self.url = "demoUrl"
    }
    
    init(title: String, url: String){
        self.title = title
        self.url = url
    }
    
    func convertStreetDictionary() -> [String: Any]{
        [Constants.titleKey: title, Constants.urlKey: url]
    }
    
}
