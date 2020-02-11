//
//  Buttons.swift
//  Uni
//
//  Created by David Sarkisyan on 03.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit
import Foundation

public enum TypeButton: CaseIterable{
    case map
    case delete
    case filter
}

struct ButtonConfigurator{
    private init() {}
    
    static let colorConfigurator = UIColor.Button()
    
}
extension UIButton{
    public func setup(type: TypeButton){
        self.backgroundColor = ButtonConfigurator.colorConfigurator.background(type)
        self.titleLabel?.textColor = ButtonConfigurator.colorConfigurator.text(type)
        
    }
}
