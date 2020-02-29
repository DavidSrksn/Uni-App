//
//  Router.swift
//  Uni
//
//  Created by David Sarkisyan on 22.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

protocol Router{
    var presenter: UINavigationController? {get}
    
    func present(controller: UIViewController, animated: Bool)
    func push(controller: UIViewController, animated: Bool)
    func popController(animated: Bool)
    func dismissController(animated: Bool)
}

extension Router{
    func present(controller: UIViewController, animated: Bool){
        presenter?.present(controller, animated: animated, completion: nil)
    }
    
    func push(controller: UIViewController, animated: Bool){
        presenter?.pushViewController(controller, animated: animated)
    }
    
    func popController(animated: Bool){
        presenter?.popViewController(animated: animated)
    }
    
    func dismissController(animated: Bool){
        presenter?.dismiss(animated: animated, completion: nil)
    }
}

typealias CoordinatorHandler = ()->()

protocol Coordinatable: Router{
    var flowCompletionHandler: CoordinatorHandler? {get set}
    func start()
}

protocol FlowController{
    associatedtype T
//    var completionHandler: (T->())? {get set}
}
