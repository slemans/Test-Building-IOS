//
//  FirebaseDatabase.swift
//  testOne
//
//  Created by sleman on 19.10.21.
//

import Firebase
import UIKit

struct FirebaseDatabaseProject {
    static var ref: DatabaseReference{
        let ref = Database.database().reference(withPath: "Streets")
        return ref
    }
}
