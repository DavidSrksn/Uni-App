//
//  Colors.swift
//  Uni
//
//  Created by David Sarkisyan on 23.01.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import Foundation
import  UIKit

enum ColorStyleMode: String {
    case dark = "dark"
    case light = "light"
}


extension UIColor{
    static var interfaceStyle: ColorStyleMode =  {
        let styleCase = UserDefaults.standard.value(forKey: "interfaceStyle") as? String
        if styleCase == "dark"{
            return .dark
        }
        else if styleCase == "light"{
            return .light
        }
        return .light
    }()
}

// MARK: StatusBarStyle
extension UIStatusBarStyle{
        static var statusBar: UIStatusBarStyle {
            switch UIColor.interfaceStyle {
            case .dark:
                return .lightContent
            case .light:
                return .darkContent
            }
        }
}

// MARK: Custom Default Colors
extension UIColor{
    enum Customs{
        static var green: UIColor = UIColor(red: 0, green: 128/256, blue: 0, alpha: 1)
        
        static var lightBlack: UIColor = UIColor(red: 28/256, green: 28/256, blue: 30/256, alpha: 1)
        
        static var red: UIColor = UIColor(red: 255/256, green: 0, blue: 0, alpha: 1)
        
        static var blue: UIColor = UIColor(red: 106/256, green: 166/256, blue: 211/256, alpha: 1)
    }
}

// MARK: Launch
extension UIColor{
    enum Launch{
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .black
            case .light:
                return .white
            }
        }
        
        static var text: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
    }
}

// MARK: TabBar
extension UIColor{
    enum TabBar{
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .black
            case .light:
                return .lightGray
            }
        }
        
        static var item: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return .black
            }
        }
    }
}

// MARK: NavigationController
extension UIColor{
    enum NavigationController{
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .black
            case .light:
                return .lightGray
            }
        }
        
        static var item: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return .black
            }
        }
    }
}

// MARK: View
extension UIColor{
    enum View{
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return  UIColor.Customs.lightBlack
            case .light:
                return .white
            }
        }
        
        static var tint: UIColor{
            switch UIColor.interfaceStyle {
            case .dark:
                return .black
            case .light:
                return UIColor.white.darker
            }
        }
    }
}
// MARK: Tableview (Cell, Separator)
extension UIColor{
    enum TableView{
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return  UIColor.Customs.lightBlack
            case .light:
                return .white
            }
        }
        
        static var separator: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .black
            case .light:
                return .lightGray
            }
        }
        
        static var headerBackground: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .black
            case .light:
                return .lightGray
            }
        }
        
        enum Cell {
            static var tintedBackground: UIColor {
                switch UIColor.interfaceStyle {
                case .dark:
                    return .black
                case .light:
                    return UIColor.white.darker
                }
            }
            
            static var defaultBackground: UIColor { // дефолтный цвет ячейки
                switch UIColor.interfaceStyle {
                case .dark:
                    return UIColor.Customs.lightBlack
                case .light:
                    return .white
                }
            }
            
            static var choosedBackground: UIColor { // когда ячейка выбрана
                switch UIColor.interfaceStyle {
                case .dark:
                    return .black
                case .light:
                    return .lightGray
                }
            }
            
            static var choosedAttributes: UIColor {
                switch UIColor.interfaceStyle {
                case .dark:
                    return .white
                case .light:
                    return UIColor.Customs.lightBlack
                }
            }
        }
        
    }
}

// MARK: Text
extension UIColor{
    enum Text{
        static var common: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
        
        static var title: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return .white
            }
        }
        
    }
}

// MARK: AddToWishlistButton
extension UIColor{
    static var AddToWishlistButtonTint: UIColor {
        switch UIColor.interfaceStyle {
        case .dark:
            return .white
        case .light:
            return .lightGray
        }
    }
}

extension UIColor{
    struct Button {
                
        var background = { (type: TypeButton)-> UIColor in
                switch UIColor.interfaceStyle {
                case .light:
                    
                    switch type {
                    case .delete:
                        return .white
                    case .filter:
                       return .lightGray
                    case .map:
                        return UIColor.Customs.blue
                    }
                    
                case .dark:
                    
                    switch type {
                    case .delete:
                        return .white
                    case .filter:
                        return UIColor.Customs.lightBlack
                    case .map:
                        return UIColor.Customs.blue.lighter
                    }
                }
        }
        
        var text = { (type: TypeButton)-> UIColor in
                switch UIColor.interfaceStyle {
                case .light:
                    
                    switch type {
                    case .delete:
                        return .white
                    case .filter:
                       return UIColor.Customs.lightBlack
                    case .map:
                        return UIColor.Customs.lightBlack
                    }
                    
                case .dark:
                    
                    switch type {
                    case .delete:
                        return .white
                    case .filter:
                        return .darkGray
                    case .map:
                       return UIColor.Customs.lightBlack
                    }
                }
        }
        
    }
}

// MARK: MapButton
extension UIColor{
    enum MapButton{
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return UIColor.Customs.blue.lighter
            case .light:
                return UIColor.Customs.blue
            }
        }
        
        static var text: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return UIColor.Customs.lightBlack
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
        
    }
}

// MARK: FilterButton
extension UIColor{
    enum FilterButton{
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return UIColor.Customs.lightBlack
            case .light:
                return .lightGray
            }
        }
        
        static var shadow: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .darkGray
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
        
        static var tint: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
        
    }
}

// MARK: Shimmer
extension UIColor{
    enum Shimmer{
        static var gradient: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.white.darker
            }
        }
        
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return UIColor.Customs.lightBlack
            case .light:
                return UIColor.gray.lighter
            }
        }
        
    }
}

// MARK: Loader
extension UIColor{
        static var loaderIndicator: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
    
}
