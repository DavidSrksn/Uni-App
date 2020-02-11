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
    case title = ""
    case regular = " "
}


public enum FontThickness: String{
    case bold = "-Bold"
    case regular = "-Regular"
}

public enum FontSize: CGFloat {
    case title = 17
    case regular = 15
    case description = 12
}

extension UIFont{
    
    public func configure(name: FontName, thickness: FontThickness, size: FontSize) -> UIFont{
        let fontName: String = name.rawValue
        let thickness: String = thickness.rawValue
        let size: CGFloat = size.rawValue
        
        if let font = UIFont(name: fontName + thickness, size: size){
            return font
        }else {
            return UIFont(name: "TimesNewRoman", size: 1)!
            
        }
    }
    
//    public func setup(style: FontType){
//        switch style {
//        case .title:
//            return configure(name:"AvenirNext-Regular", thickness: , size: )
//        case .regular:
//            return configure(name: , thickness: , size: )
//        case .description:
//            return configure(name: , thickness: , size: )
//        }
//    }
    
}



//extension UIFont{
//    static var font = { ( style: FontStyle,  thickness: FontThickness) -> UIFont in
//        let tempFont: UIFont
//
//        tempFont = UIFont(name: setupFontStyle(style: style),
//                          size: )
//
//        return tempFont
//    }
//}
