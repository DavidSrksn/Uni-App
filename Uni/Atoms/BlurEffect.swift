//
//  BlurEffect.swift
//  Uni
//
//  Created by David Sarkisyan on 05.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import Foundation
import  UIKit

extension UIBlurEffect.Style{
    
    static var blurView: UIBlurEffect.Style {
        switch UIColor.interfaceStyle {
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
    
}
