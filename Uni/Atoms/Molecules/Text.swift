//
//  Labels.swift
//  Uni
//
//  Created by David Sarkisyan on 15.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

public enum textColor{
    case common
    case inverted
}

extension textColor{
    typealias RawValue = UIColor

        init?(rawValue: RawValue) {
            switch rawValue {
            case UIColor.Text.common: self = .common
            case UIColor.Text.inverted: self = .inverted
            default: self = .common
            }
        }

    var rawValue: RawValue {
            switch self {
            case .common: return UIColor.Text.common
            case .inverted: return UIColor.Text.inverted
            }
        }
}

extension UILabel{
    public func textSetup(text: String, textAlignment: NSTextAlignment, textColor: textColor){
        self.text = text
        self.textAlignment = textAlignment
        
        switch textColor{
        case .common:
            self.textColor = UIColor.Text.common
        case .inverted:
            self.textColor = UIColor.Text.inverted
        }
    }
    
    public func attributedTextSetup(text: NSAttributedString, textAlignment: NSTextAlignment){
        self.attributedText = text
        self.textAlignment = textAlignment
    }
}

extension UIButton{
    public func textSetup(type: TypeButton, textColor: textColor){
        var textColor: UIColor {
            switch textColor{
            case .common:
              return UIColor.Text.common
            case .inverted:
                return UIColor.Text.inverted
            }
        }
        
        var text: String {
            switch type{
            case .map:
              return "Построить маршрут"
            case .delete:
                return "Удалить"
            case .filter:
                return ""
            }
        }
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
    }
}

