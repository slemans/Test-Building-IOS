//
//  ConstantsImage.swift
//  testOne
//
//  Created by sleman on 28.10.21.
//

import UIKit

class ConstantsImage{
    static let imageDelete: UIImage? = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular, scale: .medium)
        let image = UIImage(systemName: "multiply", withConfiguration: largeConfig)
        return image
    }()
    static let imageDeleteEmpty: UIImage? = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular, scale: .medium)
        let image = UIImage(systemName: "", withConfiguration: largeConfig)
        return image
    }()
}
