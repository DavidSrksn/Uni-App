//
//  Font.swift
//  Uni
//
//  Created by David Sarkisyan on 08.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

public enum FontStyle: String {
    case title = ""
    case regular = " "
}


public enum FontThickness: String {
    case bold = ""
    case regular = " "
}

//extension UIFont{
//    public func setup(style: FontStyle, thickness: FontThickness) -> UIFont{
//        let tempFont: UIFont
//        
//        tempFont = UIFont(name: setupFontStyle(style: style),
//                          size: )
//        
//        return tempFont
//    }
//    
//    private func setupFontStyle(style: FontStyle) -> String{
//        let fontName: String = style.rawValue
//        if let font = UIFont(name: fontName, size: 1){
//            return font.fontName
//        }else { return "TimesNewRoman"}
//    }
//    
//    private func setupFontThickness(thickness: FontThickness) -> CGFloat{
//        let fontName: String = thickness.rawValue
//        if let font = UIFont(name: fontName, size: 1){
//            return font.fontName
//        }else { return "TimesNewRoman"}
//    }
//    
//}
//
//
//
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
