//
//  Font.swift
//  Uni
//
//  Created by David Sarkisyan on 08.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

public enum FontType{
    case title
    case regular
    case description
}

public enum FontName: String {
    case title = "HelveticaNeue"
    case regular = "AvenirNext"
    case navigationBar = "Georgia"
}


public enum FontThickness: String {
    case bold = "-Bold"
    case regular = "-Regular"
}

public enum FontSize: CGFloat {
    case title = 24
    case regular = 20
    case description = 15
}

//extension UIFont{
//    static let fontConfigurator = UIFont()
//
//    public func setup(name: FontName, thickness: FontThickness, size: FontSize) -> UIFont{
//        let fontName: String = name.rawValue
//        let thickness: String = thickness.rawValue
//        let size: CGFloat = size.rawValue
//
//        if let font = UIFont(name: fontName + thickness,
//                             size: size){
//             return font
//        }else if let font = UIFont(name: fontName,
//        size: size) {
//            return font
//        }else {
//            return UIFont(name: "HelveticaNeue", size: 100)!
//        }
//    }
//}

extension UILabel{
    public func fontSetup(name: FontName, thickness: FontThickness, size: FontSize){
        let fontName: String = name.rawValue
        let thickness: String = thickness.rawValue
        let size: CGFloat = size.rawValue
        
        if let font = UIFont(name: fontName + thickness,
                             size: size){
            self.font = font
        }else if let font = UIFont(name: fontName,
        size: size) {
            self.font = font
        }else {
            self.font = UIFont(name: "HelveticaNeue", size: 100)!
        }
    }
}
