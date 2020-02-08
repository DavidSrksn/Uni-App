//
//  Loader.swift
//  Uni
//
//  Created by David Sarkisyan on 03.02.2020.
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


struct FakeData {
    static let cellsNumber = 5
    
    static let faculty = Faculty(name: "  ", fullName: "  ")
    
}


final class Shimmer{
    
    private init(){}
    
    static let shared = Shimmer()
    
    private var shimmeringView = UIView()
    private var backgroundView = UIView()
    
    private let gradientLayer = CAGradientLayer()
    private let animation = CABasicAnimation(keyPath: "transform.translation.x")
    
    private var savedScreens: [String: (UIView,UIView)] = [:]
    
    private func setupGradient(superview: UIView){
        
        Shimmer.shared.gradientLayer.colors = [
            UIColor.clear.cgColor, UIColor.clear.cgColor,
            UIColor.black.cgColor, UIColor.red.cgColor,
            UIColor.clear.cgColor, UIColor.clear.cgColor
        ]
        
        Shimmer.shared.gradientLayer.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
        
        let angle = -60 * CGFloat.pi / 180
        let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        Shimmer.shared.gradientLayer.transform = rotationTransform
        Shimmer.shared.gradientLayer.frame = superview.frame
        
        Shimmer.shared.shimmeringView.layer.mask = Shimmer.shared.gradientLayer
        
        Shimmer.shared.gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(4, 4, 0))
    }
    
    private func setupAnimation( superview: UIView){
        
        Shimmer.shared.animation.duration = 2
        Shimmer.shared.animation.repeatCount = Float.infinity
        
        Shimmer.shared.animation.fromValue = -3.0 * superview.frame.width
        Shimmer.shared.animation.toValue = 3.0 * superview.frame.width
        
        Shimmer.shared.gradientLayer.add(animation, forKey: "shimmerKey")
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
        checkSubviews(backgroundView: &Shimmer.shared.backgroundView, shimmeringView: &Shimmer.shared.shimmeringView , view: view) { (view,color) -> UIView in
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
    
    
    func startShimmer(view: UIView,  screen: String){
        if !savedScreens.keys.contains(screen){
            setupShimmer(view: view)
            
            savedScreens[screen] = (backgroundView,shimmeringView)
        }
        setupBackgroundView()
        setupGradient(superview:  view)
        setupAnimation(superview: view)
        addShimmer(view: view, screen: screen)
    }
    
    func stopShimmer(){
        sleep(2)
        gradientLayer.removeAnimation(forKey: "shimmer")
        shimmeringView.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
    
}

extension UIViewController{
    
    public func startShimmering(){
//        Shimmer.shared.startShimmer(view: <#T##UIView#>, screen: <#T##String#>)
    }
}

