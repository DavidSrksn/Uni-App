//
//  Manager.swift
//  Uni
//
//  Created by David Sarkisyan on 15.10.2019.
//  Copyright © 2019 DavidS & that's all. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import CircleMenu
import paper_onboarding
import UIKit

final class Manager {
    
    private init(){}

    let wishlistQueue = DispatchQueue.main

    var workItem = DispatchWorkItem(qos: .utility, flags: .assignCurrentContext) {
    }
    
    var FollowersWorkItem = DispatchWorkItem(qos: .background, flags: .assignCurrentContext) {
    }
    
    let notificationCentre = NotificationCenter.default
        
    static let shared = Manager()
    
    var UFD = [ University : [Faculty? : [Department]?]]()
    var dataUFD = [University : [Faculty? : [Department]?]]()
    
    var choosed: [Any?] = [nil,nil,nil]
    
    let realm = try! Realm()
    
    var flagFilterChanged = true
    var sortType: String?
    
    var filterSettings = Filter(country: nil, subjects: nil, minPoint: nil, military: nil, campus: nil)
    
    //////// ИСПРАВИТЬ
    
    func sort(type: Int, tableView: UITableView){
        let array = (Manager.shared.UFD[Manager.shared.choosed[0] as! University]?[Manager.shared.choosed[1] as? Faculty]?!)!
        let sortType = Sort.Occasions.allCases[type]
        
        switch sortType{
        case .minPointAscending:
            Manager.shared.UFD[Manager.shared.choosed[0] as! University]?[Manager.shared.choosed[1] as? Faculty]?! = array.sorted(by: { (firstDep, secondDep) -> Bool in
                return firstDep.minPoints < secondDep.minPoints
            })
        case .minPointDescending:
            Manager.shared.UFD[Manager.shared.choosed[0] as! University]?[Manager.shared.choosed[1] as? Faculty]?! = array.sorted(by: { (firstDep, secondDep) -> Bool in
                return firstDep.minPoints > secondDep.minPoints
            })
        case .defaultSort:
            if let typeOfScience = (UserDefaults.standard.value(forKey: "Увлечение") as? String){
                let sortType: [String]? = Sort.shared.switchDefaultSort(type: typeOfScience) // список предметов
                
                Manager.shared.UFD[Manager.shared.choosed[0] as! University]?[Manager.shared.choosed[1] as? Faculty]?! = array.sorted(by: { (firstDep, secondDep) -> Bool in
//                    var firstDepCounter: Int = 0 // Количество совпадений предметов с характерными в sortType
//                    var secondDepCounter: Int = 0
//
//                    for subject in firstDep.subjects{
//                        if (sortType?.contains(subject))! {
//                            firstDepCounter += 1
//                        }
//                    }
//
//                    for subject in secondDep.subjects{
//                        if (sortType?.contains(subject))! {
//                            secondDepCounter += 1
//                        }
//                    }
//
//                    if firstDepCounter > secondDepCounter{
//                        return firstDep.su > secondDep
//                    }else{return firstDep < secondDep }
                    return (sortType?.contains(firstDep.subjects.first(where: { (subject) -> Bool in
                        return (sortType?.contains(subject))!
                    })!))!
                })
            }else{
                break
            }
        }
        
        
        tableView.reloadData()
    }
    
    func internetConnectionCheck(viewcontroller: UIViewController ){
        if !NetworkReachabilityManager()!.isReachable{
            viewcontroller.tabBarController?.selectedIndex = 1
            let alert = UIAlertController(title: "Alert", message: "There is no internet. You can only use your wishlist info ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            viewcontroller.present(alert, animated: true)
        }
    }
    
    func warningLabel(label: UILabel, warning text: String, viewController: UIViewController, tableView: UITableView){
        label.frame = CGRect(x: 0, y: 0, width: 400, height: 100)
        label.numberOfLines = 0
        label.alpha = 0
        viewController.view.addSubview(label)
        label.center = viewController.view.center
        label.font = UIFont(name: "AvenirNext-Regular", size: 21)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = text
        UIView.animate(withDuration: 0.5) {
            tableView.backgroundColor = .alizarin
            tableView.separatorColor = tableView.backgroundColor
            label.alpha = 1
        }
    }
    
    func addToWishlist (sender: UIButton){
        let wishlistObject = RealmObject(university: Manager.shared.choosed[0] as! University, department: Manager.shared.choosed[2] as! Department, faculty: Manager.shared.choosed[1] as! Faculty )
        if !self.realm.objects(RealmObject.self).contains(wishlistObject){
            do {
                try self.realm.write {
                    self.realm.add(wishlistObject)
                }
            } catch{
                print(error.localizedDescription)
            }
        }
        NetworkManager.shared.changeFollower(occasion: "add", universityname: (Manager.shared.choosed[0] as! University).name, facultyFullName: (Manager.shared.choosed[1] as! Faculty).fullName, departmentFullName: (Manager.shared.choosed[2] as! Department).fullName)
        print("fileURL = \(self.realm.configuration.fileURL)")
        sender.setImage(UIImage(systemName: "star.fill")?.withTintColor(.red), for: .normal)
    }
    
    func deleteFromWishlist (sender: UIButton,setImage: UIImage){
        let wishlistObject = RealmObject(university: Manager.shared.choosed[0] as! University, department: Manager.shared.choosed[2] as! Department, faculty: (Manager.shared.choosed[1] as! Faculty))
        do{
            try self.realm.write {
//              self.realm.deleteAll()
                self.realm.delete(realm.objects(RealmObject.self).filter("departmentFullName = '\(wishlistObject.departmentFullName)'"))
            }
        }
        catch{
            print(error.localizedDescription)
        }
        NetworkManager.shared.changeFollower(occasion: "remove", universityname: (Manager.shared.choosed[0] as! University).name, facultyFullName: (Manager.shared.choosed[1] as! Faculty).fullName, departmentFullName: (Manager.shared.choosed[2] as! Department).fullName)
        sender.setImage(setImage, for: .normal)
    }
    
    func departmentStatus(department: Department) -> Bool {
        if Manager.shared.realm.objects(RealmObject.self).contains(where: { (wishlistObject) -> Bool in
            return wishlistObject.departmentFullName == department.fullName
        }){
            return false
        } else{
            return true
        }
    }
    
    func loadFilterSettings() -> Filter {
        return self.filterSettings
    }
    
    func filterSettingsChanged(filter: Filter){
        if filter.country == Manager.shared.filterSettings.country && filter.campus == Manager.shared.filterSettings.campus && filter.minPoint == Manager.shared.filterSettings.minPoint && filter.campus == Manager.shared.filterSettings.campus && filter.subjects == Manager.shared.filterSettings.subjects {
            Manager.shared.flagFilterChanged = false
        } else{
            Manager.shared.flagFilterChanged = true
        }
    }
    
    func updateFilterSettings(with newFilter: Filter) {
        if Manager.shared.flagFilterChanged{
            Manager.shared.filterSettings = newFilter
        }
    }
    
    func updateController(controller: UIViewController){
        ((controller as? UITabBarController)?.selectedViewController as? UINavigationController)?.viewControllers[0].viewDidLoad()
    }
    
    func warningCheck(parameter: Int, viewController: UIViewController, warningLabel: UILabel, tableView: UITableView){
        if parameter == 0{
            Manager.shared.warningLabel(label: warningLabel, warning: "По вашему запросу \n ничего не найдено", viewController:viewController, tableView: tableView)
        }else{
            warningLabel.alpha = 0
            tableView.backgroundColor = .white
            tableView.separatorColor = .black
        }
    }
    
}
