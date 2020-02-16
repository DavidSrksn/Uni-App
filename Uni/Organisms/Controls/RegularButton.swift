//
//  Buttons.swift
//  Uni
//
//  Created by David Sarkisyan on 03.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit
import Foundation

public enum TypeButton{ // здесь задаются все типы кнопок
    case map
    case delete
    case filter
}

extension UIButton{
    private func setupColors(colors: [String : UIColor], image: UIImage?){
        self.backgroundColor = colors["background"]
        self.layer.borderColor = colors["border"]?.cgColor
        self.layer.shadowColor = colors["shadow"]?.cgColor
        
        if let tintColor = colors["inverted"], let image = image{
            self.contentMode = .scaleAspectFit
            self.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            self.image(for: .normal)?.withTintColor(tintColor)
        }
    }
    
    private func setupColorConfigurator(type: TypeButton) -> [String : UIColor]{
        switch type{
        case .map:
            return UIColor.MapButton.colorConfigurator
        case .delete:
            return UIColor.DeleteButton.colorConfigurator
        case .filter:
            return UIColor.FilterButton.colorConfigurator
        }
    }
    
    public func setupColors(type: TypeButton, image: UIImage?){
        let colorConfigurator = setupColorConfigurator(type: type)
        setupColors(colors: colorConfigurator, image: image)
    }
}
