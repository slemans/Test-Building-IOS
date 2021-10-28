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
    static let photoKey = "photo"
}
enum TitleCell {
    static let collectionCell = "collectionCell"
    static let tableCell = "contactCell" 
}
enum SegueTitle {
    static let photos = "seguePhotos"
}
enum FontsTitle {
    static let arial = "Arial"
}
enum ImageCustomTitle {
    static let plusCircle = "plus.circle.fill"
}

struct NumberInt{
    static let zero = 0
    static let one = 1
}

struct NumberCGFloat {
    static let zero: CGFloat = 0
    static let zeroThree: CGFloat = 0.3
    static let zeroFore: CGFloat = 0.4
    static let one: CGFloat = 1
    static let two: CGFloat = 2
    static let three: CGFloat = 3
    static let five: CGFloat = 5
    static let six: CGFloat = 6
    static let ten: CGFloat = 10
    static let tenMinus: CGFloat = -10
    static let twelve: CGFloat = 12
    static let twelveMinus: CGFloat = -12
    static let fiftiny: CGFloat = 15
    static let eighteen: CGFloat = 18
    static let twenty: CGFloat = 20
    static let twentyOne: CGFloat = 21
    static let twentyTwo: CGFloat = 22
    static let twentyFive: CGFloat = 25
    static let twentyFiveMinus: CGFloat = -25
    static let thirty: CGFloat = 30
    static let thirtyFour: CGFloat = 34
    static let fortyMinus: CGFloat = -40
    static let fortyTwo: CGFloat = 42
    static let fortyFive: CGFloat = 45
    static let fiftyFive: CGFloat = 55
    static let seventy: CGFloat = 70
    static let oneHundredTwenty: CGFloat = 120
    static let oneHundredTwentyMinus: CGFloat = -120
}
struct NumberTimeInterval {
    static let one: TimeInterval = 1
}

struct NumberFloat {
    static let zeroThree: Float = 0.3
}
struct NumberDouble{
    static let twoFive: Double = 2.5
}

struct ColorUIColor {
    static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let pinkCustom = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
    static let greyTwo = #colorLiteral(red: 0.5254901961, green: 0.5803921569, blue: 0.5843137255, alpha: 1)
    static let greyOne = #colorLiteral(red: 0.9294117647, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
    static let greyThree = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    static let blackWhite = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0)
    
}
struct ColorCGColor {
    static let white: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let pinkCustom: CGColor = #colorLiteral(red: 0.8078431373, green: 0.4, blue: 0.4, alpha: 1)
    static let grey: CGColor = #colorLiteral(red: 0.3803921569, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
    
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



