//
//  Constants.swift
//  testOne
//
//  Created by sleman on 20.10.21.
//

import UIKit

enum Constants {
    static let lableKey = "lable"
    static let arrayImageKey = "arrayImage"
    static let urlKey = "url"
    static let titleKey = "title"
}
struct NumberCGFloat {
    static let zero: CGFloat = 0
    static let one: CGFloat = 1
    static let two: CGFloat = 2
    static let twentyFive: CGFloat = 25
    static let twentyFiveMinus: CGFloat = -25
    static let thirtyFour: CGFloat = 34
}

struct ColorUIColor {
    static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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



