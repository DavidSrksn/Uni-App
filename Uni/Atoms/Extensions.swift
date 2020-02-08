//
//  Extensions.swift
//  Uni
//
//  Created by David Sarkisyan on 04.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

struct AssociatedKeys {
    static var isShimmering: Bool = false
}

extension UIView{
     var isShimmering: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.isShimmering) != nil)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.isShimmering, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
