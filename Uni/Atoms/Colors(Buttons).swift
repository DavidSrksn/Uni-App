//
//  Colors(Buttons).swift
//  Uni
//
//  Created by David Sarkisyan on 13.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

internal protocol ButtonColor { // новые увета добавлять сюда, а компилятор уже сам покажет где чего не хватает
    
    static var colorConfigurator: [String : UIColor] {get} // словарь где хранятся все цвета кнопки
    
    static var background: UIColor {get}
    
    static var shadow: UIColor {get}
    
    static var border: UIColor {get}
    
    static var inverted: UIColor {get} // инвертированный background (для tintColor у картинок на кнопках)
}

extension ButtonColor{
    
    static var colorConfigurator: [String : UIColor] {
        get{ return  [
            "background" : Self.background,
            "shadow" : Self.shadow,
            "border" : Self.border,
            "inverted" : Self.inverted
            ]
        }
    }
}

// MARK: MapButton
extension UIColor{
    struct MapButton: ButtonColor{
                
        internal static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return UIColor.Customs.blue.lighter
            case .light:
                return UIColor.Customs.blue
            }
        }
        
        internal static var shadow: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
        
        internal static var border: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
        
        internal static var inverted: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
    }
}

// MARK: DeleteButton
extension UIColor{
    struct DeleteButton: ButtonColor{
        
        internal static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return UIColor.Customs.red
            case .light:
                return UIColor.Customs.red.lighter
            }
        }
        
        internal static var shadow: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
        
        internal static var border: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
        
        internal static var inverted: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
    }
}

// MARK: FilterButton
extension UIColor{
    struct FilterButton: ButtonColor {
        internal static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return UIColor.Customs.lightBlack
            case .light:
                return .lightGray
            }
        }
        
        internal static var shadow: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .darkGray
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
        
        internal static var border: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
        
        internal static var inverted: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
        
    }
}

// MARK: AddToWishlistButton
extension UIColor{
    struct AddToWishlistButton: ButtonColor {
        
        internal static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
        
        internal static var shadow: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
        
        internal static var border: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .clear
            case .light:
                return .clear
            }
        }
        
        internal static var inverted: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
    }
}
