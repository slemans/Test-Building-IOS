//
//  FirebaseSetting.swift
//  testOne
//
//  Created by sleman on 19.10.21.
//

import Firebase
import UIKit

struct FirebaseStorageProject {
    static let storeUrl = "gs://testone-abe3e.appspot.com"
    static var storage: Storage {
        var storage = Storage.storage()
        storage = Storage.storage(url: storeUrl)
        return storage
    }
    static let storageRef = FirebaseStorageProject.storage.reference()
}


