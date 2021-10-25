//
//  Constants.swift
//  testOne
//
//  Created by sleman on 20.10.21.
//

import Foundation


enum Constants {
    static let lableKey = "lable"
    static let arrayImageKey = "arrayImage"
    static let urlKey = "url"
    static let titleKey = "title"
}

struct GetDate {
   static var time: String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd-MM-yyyy:HH-mm-ss"
        let datetime = formatter.string(from: now)
        return datetime
    }
}
