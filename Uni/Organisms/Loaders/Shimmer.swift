//
//  Loader.swift
//  Uni
//
//  Created by David Sarkisyan on 03.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

protocol ShimmerAnimation {
    
    func startShimmer(view: UIView,  screen: String)

    func stopShimmer()
}
    
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

extension UIViewController{
    
    public func startShimmer( ){
        Shimmer.shared.startShimmer(view: self.view, screen: String(describing: type(of: self)))
    }
    
    public func stopShimmer(){
        Shimmer.shared.stopShimmer()
    }
    
    public func prepareShimer(){
        Shimmer.shared.prepareShimmer(view: self.view)
    }
}

enum Status{
    case notStarted
    case isstarted
    case shouldBeStopped
}

enum Action{
    case start
    case stop
    case reset
}

struct FakeData {
    static let cellsNumber = 5

    static let faculty = Faculty(name: "  ", fullName: "  ")

}


final class Shimmer: ShimmerAnimation{
    
    private init(){}
    
    static let shared = Shimmer()
    
    private let group = DispatchGroup()
    private let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    private var status = Status.notStarted
    
    private var preparingView = UIView() // "занавесь", закрывающая views, которые не надо подгружать, но и показывать их сразу некрасиво
    private var shimmeringView = UIView()
    private var backgroundView = UIView()
    
    private let gradientLayer = CAGradientLayer()
    private let animation = CABasicAnimation(keyPath: "transform.translation.x")
    private let duration: UInt32 = 2
    
    private var savedScreens: [String: (UIView,UIView)] = [:] // экраны на которых уже была анимация сохраняются и заново не "строятся" при повторном открытии
    
    private func setupGradient(superview: UIView){
        
        gradientLayer.colors = [
            UIColor.clear.cgColor, UIColor.clear.cgColor,
            UIColor.black.cgColor, UIColor.red.cgColor,
            UIColor.clear.cgColor, UIColor.clear.cgColor
        ]
        
        gradientLayer.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
        
        let angle = -60 * CGFloat.pi / 180
        let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        gradientLayer.transform = rotationTransform
        gradientLayer.frame = superview.frame
        
        shimmeringView.layer.mask = Shimmer.shared.gradientLayer
        
        gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(4, 4, 0))
    }
    
    private func setupAnimation( superview: UIView){
        
        animation.duration = 2
        animation.repeatCount = Float.infinity
        
        animation.fromValue = -3.0 * superview.frame.width
        animation.toValue = 3.0 * superview.frame.width
        
        gradientLayer.add(animation, forKey: "shimmerKey")
    }
    
    private func superCoordinate(view: UIView) -> CGRect{
        var frame: CGRect = view.frame
        var viewForCheck = view
        
        while (viewForCheck.superview?.superview != nil) {
            let currentCoordinate = viewForCheck.superview
            let superviewCoodinate = viewForCheck.superview?.superview
            frame = currentCoordinate!.convert( frame, to: superviewCoodinate)
            viewForCheck = viewForCheck.superview!
        }
        return frame
    }
    
    private func setupShimmer(view: UIView){
        checkSubviews(backgroundView: &backgroundView, shimmeringView: &shimmeringView , view: view) { (view,color) -> UIView in
            let viewForShimmer = UIView()
            
            viewForShimmer.frame = superCoordinate(view: view)
            viewForShimmer.layer.cornerRadius = view.layer.cornerRadius
            
            viewForShimmer.backgroundColor = color
            
            return viewForShimmer
        }
    }
    
    private func checkSubviews( backgroundView: inout UIView, shimmeringView: inout UIView, view: UIView, completion: (_ view: UIView, _ backgroundColor: UIColor) -> UIView) {
        
        for subview in view.subviews{
            if subview.isShimmering{
                backgroundView.addSubview(completion(subview, UIColor.Shimmer.background))
                shimmeringView.addSubview(completion(subview, UIColor.Shimmer.gradient))
            }else if subview.subviews.count != 0{
                checkSubviews(backgroundView: &backgroundView, shimmeringView: &shimmeringView, view: subview, completion: completion)
            }
        }
    }
    
    private func setupBackgroundView(){
        backgroundView.backgroundColor = UIColor.View.background
    }
    
    private func addShimmer(view: UIView, screen: String){
        if let backgroundView = savedScreens[screen]?.0 , let shimmeringView = savedScreens[screen]?.1{
            view.addSubview(backgroundView)
            view.addSubview(shimmeringView)
        }
    }
    
    private func changeStatus(action: Action){
        switch action{
        case .start:
            switch status{
            case .notStarted:
                status = .isstarted
            case .isstarted:
                status = .isstarted
            case .shouldBeStopped:
                status = .shouldBeStopped
            }
        case .stop:
            switch status{
            case .notStarted:
                status = .notStarted
            case .isstarted:
                status = .shouldBeStopped
            case .shouldBeStopped:
                status = .shouldBeStopped
            }
        case .reset:
            status = .notStarted
        }
    }
    
    public func prepareShimmer(view: UIView){
        
        preparingView.frame = view.frame
        preparingView.backgroundColor = UIColor.View.background
        
        view.addSubview(preparingView)
    }
    
    public func startShimmer(view: UIView,  screen: String){
        
        changeStatus(action: .start)
        
        if !savedScreens.keys.contains(screen){
            setupShimmer(view: view)
            
            savedScreens[screen] = (backgroundView,shimmeringView)
        }
        setupBackgroundView()
        setupGradient(superview:  view)
        setupAnimation(superview: view)
        addShimmer(view: view, screen: screen)
                
        if status == .shouldBeStopped{
            group.leave() // освобождает заглушку в случае вызова стоп раньше стара
        }
    }
    
    func stopShimmer(){
        changeStatus(action: .stop)
        
        concurrentQueue.async {
            if self.status == .notStarted{
                self.group.enter() // заглушка в случае когда стоп вызвался раньше старта
                self.changeStatus(action: .start)
            }else{
                sleep(self.duration)
            }
            
            self.group.wait() // для убеждения того что старт уже прошел
            
            DispatchQueue.main.async{
                self.gradientLayer.removeAnimation(forKey: "shimmer")
                self.shimmeringView.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
                self.changeStatus(action: .reset)
                self.preparingView.removeFromSuperview()
            }
        }
    }
}


//protocol ShimmerAnimation {
//    func startShimmer(view: UIView,  screen: UIViewController)
//
//    func stopShimmer()
//}
//
//struct AssociatedKeys {
//    static var isShimmering: Bool = false
//}
//
//extension UIView{
//     var isShimmering: Bool {
//        get {
//            return (objc_getAssociatedObject(self, &AssociatedKeys.isShimmering) != nil)
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, &AssociatedKeys.isShimmering, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//}
//
//extension UIViewController{
//
//    public func startShimmer( ){
//        Shimmer.shared.startShimmer(view: self.view, screen: self)
//    }
//
//    public func stopShimmer(){
//        Shimmer.shared.stopShimmer()
//    }
//
//    public func prepareShimer(){
//        Shimmer.shared.prepareShimmer(view: self.view)
//    }
//}
//
//enum Status{
//    case notStarted
//    case isstarted
//    case shouldBeStopped
//}
//
//enum Action{
//    case start
//    case stop
//    case reset
//}
//
//struct FakeData {
//    static let cellsNumber = 5
//
//    static let faculty = Faculty(name: "  ", fullName: "  ")
//
//}
//
//
//final class Shimmer: ShimmerAnimation{
//
//    private init(){}
//
//    static let shared = Shimmer()
//
//    private let group = DispatchGroup()
//    private let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
//
//    private var status = Status.notStarted
//
//    private var preparingView = UIView() // "занавесь", закрывающая views, которые не надо подгружать, но и показывать их сразу некрасиво
//    private var shimmeringViews = [UIView]()
//    private var backgroundViews = [UIView]()
//
//    private let gradientLayer = CAGradientLayer()
//    private let animation = CABasicAnimation(keyPath: "transform.translation.x")
//    private let duration: UInt32 = 1
//
//    private var savedScreens: [UIViewController] = [] // экраны на которых уже была анимация (анимация опять не появляется)
//
//    private func setupGradient(superview: UIView){
//        gradientLayer.colors = [
//            UIColor.clear.cgColor, UIColor.clear.cgColor,
//            UIColor.black.cgColor, UIColor.red.cgColor,
//            UIColor.clear.cgColor, UIColor.clear.cgColor
//        ]
//
//        gradientLayer.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
//
//        let angle = -60 * CGFloat.pi / 180
//        let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
//
//        gradientLayer.transform = rotationTransform
//        gradientLayer.frame = superview.frame
//
//        for view in shimmeringViews{
//            view.layer.mask = gradientLayer
//        }
//
//        gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(4, 4, 0))
//    }
//
//    private func setupAnimation( superview: UIView){
//
//        animation.duration = 2
//        animation.repeatCount = Float.infinity
//
//        animation.fromValue = -3.0 * superview.frame.width
//        animation.toValue = 3.0 * superview.frame.width
//
//        gradientLayer.add(animation, forKey: "shimmerKey")
//    }
//
//    private func superCoordinate(view: UIView) -> CGRect{
//        var frame: CGRect = view.frame
//        var viewForCheck = view
//
//        while (viewForCheck.superview?.superview != nil) {
//            let currentCoordinate = viewForCheck.superview
//            let superviewCoodinate = viewForCheck.superview?.superview
//            frame = currentCoordinate!.convert( frame, to: superviewCoodinate)
//            viewForCheck = viewForCheck.superview!
//        }
//        return frame
//    }
//
//    private func configureShimmer(view: UIView){
//        checkSubviews(backgroundViews: &backgroundViews, shimmeringViews: &shimmeringViews , view: view) { (view,color) -> UIView in
//
//            let shimmerView = UIView()
//
//            shimmerView.bounds = view.bounds
//            shimmerView.center = view.center
//
//            shimmerView.layer.cornerRadius = view.layer.cornerRadius
//
//            shimmerView.backgroundColor = color
//
//            return shimmerView
//        }
//    }
//
//    private func checkSubviews( backgroundViews: inout [UIView], shimmeringViews: inout [UIView], view: UIView, completion: (_ view: UIView, _ backgroundColor: UIColor) -> UIView) {
//
//        for subview in view.subviews{
//            if subview.isShimmering{
//                backgroundViews.append(completion(subview, UIColor.Shimmer.background))
//                shimmeringViews.append(completion(subview, UIColor.Shimmer.gradient))
//
//                if let backgroundView = backgroundViews.last, let shimmeringView = shimmeringViews.last{
//                    subview.addSubview(backgroundView)
//                    subview.addSubview(shimmeringView)
//                }
//            }
//            if subview.subviews.count != 0{
//                checkSubviews(backgroundViews: &backgroundViews, shimmeringViews: &shimmeringViews, view: subview, completion: completion)
//            }
//        }
//    }
//
//    private func setupBackgroundView(){
//        for backgroundView in backgroundViews{
//            backgroundView.backgroundColor = UIColor.View.background
//        }
//    }
//
//    private func changeStatus(action: Action){
//        switch action{
//        case .start:
//            switch status{
//            case .notStarted:
//                status = .isstarted
//            case .isstarted:
//                status = .isstarted
//            case .shouldBeStopped:
//                status = .shouldBeStopped
//            }
//        case .stop:
//            switch status{
//            case .notStarted:
//                status = .notStarted
//            case .isstarted:
//                status = .shouldBeStopped
//            case .shouldBeStopped:
//                status = .shouldBeStopped
//            }
//        case .reset:
//            status = .notStarted
//        }
//    }
//
//    public func prepareShimmer(view: UIView){
//
//        preparingView.frame = view.frame
//        preparingView.backgroundColor = UIColor.View.background
//
//        view.addSubview(preparingView)
//    }
//
//    public func startShimmer(view: UIView,  screen: UIViewController){
//        if !savedScreens.contains(screen){
//            changeStatus(action: .start)
//
//            setupBackgroundView()
//            setupGradient(superview:  view)
//            setupAnimation(superview: view)
//
//            configureShimmer(view: view)
//            savedScreens.append(screen)
//
//
//            if status == .shouldBeStopped{
//                group.leave() // освобождает заглушку в случае вызова стоп раньше стара
//            }
//        }
//    }
//
//    public func stopShimmer(){
//        changeStatus(action: .stop)
//
//        concurrentQueue.async {
//            if self.status == .notStarted{
//                self.group.enter() // заглушка в случае когда стоп вызвался раньше старта
//                self.changeStatus(action: .start)
//            }else{
//                sleep(self.duration)
//            }
//
//            self.group.wait() // для убеждения того что старт уже прошел
//
//            DispatchQueue.main.async{
//                self.gradientLayer.removeAnimation(forKey: "shimmer")
//
//                for view in self.shimmeringViews{
//                    view.removeFromSuperview()
//                }
//
//                for view in self.backgroundViews{
//                    view.removeFromSuperview()
//                }
//
//                self.changeStatus(action: .reset)
//                self.preparingView.removeFromSuperview()
//            }
//        }
//    }
//
//}

