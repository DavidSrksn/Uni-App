//
//  DepartmentCell.swift
//  Uni
//
//  Created by David Sarkisyan on 13/10/2019.
//  Copyright © 2019 DavidS & that's all. All rights reserved.
//

import UIKit

final class DepartmentCell: UITableViewCell {

    @IBOutlet weak var addToWishlistButtonStatus: UIButton!
    
    @IBOutlet weak var departmentNameLabel: UILabel!
    
    @IBOutlet weak var departmentFullNameLabel: UILabel!
    
    var minPointsLabel = UILabel()
    
    var subjectsDifferenceLabel = UILabel()
    
    var followersLabel = UILabel()
    
    @IBAction func addToWishlistButton(_ sender: UIButton) {
         Manager.shared.choosed[2] = (Manager.shared.UFD[Manager.shared.choosed[0] as! University]?[Manager.shared.choosed[1] as? Faculty]!)!.first { (department) -> Bool in
            return department.fullName == self.departmentFullNameLabel.text
        }
        if Manager.shared.departmentStatus(department:  Manager.shared.choosed[2] as! Department){
            Manager.shared.addToWishlist(sender: sender)
        } else{
            Manager.shared.notificationCenter.post(name: Notification.Name(rawValue: "Department Deleted from Departments"), object: nil, userInfo: ["deletedObject" : Manager.shared.choosed[2] as! Department]) // для удаления из вишлиста
            Manager.shared.deleteFromWishlist(sender: nil, setImage: nil, departmentFullName: (Manager.shared.choosed[2] as? Department)!.fullName)
            sender.setImage(UIImage(systemName: "star")!, for: .normal)

        }
    }
    
    func setDepartmentCell(department: Department){
        self.backgroundColor = UIColor.TableView.Cell.defaultBackground
        self.contentView.backgroundColor = UIColor.TableView.Cell.defaultBackground
        setupDepartmentNameLabel(department: department)
        setupAddToWishlistButton(department: department)
        setupDepartmentFullNameLabel(department: department)
        setupMinPoints(department: department)
        setupSubjectsDifferenceLabel(department: department)
        setupFollowersLabel(department: department)
    }
    
    
    func setupSubjectsDifferenceLabel(department: Department){
        self.addSubview(subjectsDifferenceLabel)
        
        subjectsDifferenceLabel.translatesAutoresizingMaskIntoConstraints = false

        subjectsDifferenceLabel.bottomAnchor.constraint(equalTo: minPointsLabel.topAnchor, constant: -5).isActive = true
        subjectsDifferenceLabel.leftAnchor.constraint(equalTo: departmentNameLabel.leftAnchor).isActive = true
        subjectsDifferenceLabel.rightAnchor.constraint(equalTo: addToWishlistButtonStatus.leftAnchor).isActive = true
        subjectsDifferenceLabel.heightAnchor.constraint(equalToConstant: 20 ).isActive = true
        
        subjectsDifferenceLabel.fontSetup(name: .regular, thickness: .regular, size: .description)
        subjectsDifferenceLabel.attributedText = findDifferenеSubjects(department: department)
    }
    
    func findDifferenеSubjects(department: Department)-> NSAttributedString?{
        var result = NSMutableAttributedString(string: "")
        
        var keyLetters: [Int] = [0]
        var lastLetter: Int = 0
        
        let noDifference: [NSAttributedString.Key: Any] = [
            .foregroundColor:  UIColor.Text.common,
            .backgroundColor: UIColor.clear]
        
        let withDifference: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Customs.red,
            .backgroundColor: UIColor.clear]
        
        if let filterSubjects = Manager.shared.filterSettings.subjects{
            for subject in department.subjects{
                if !filterSubjects.contains(subject){
                    result = NSMutableAttributedString(string: result.string + "\(subject)  ")
                    lastLetter = -(abs(keyLetters.last!) +  subject.count + 2)
                    keyLetters.append(lastLetter)
                } else{
                    result = NSMutableAttributedString(string: result.string + "\(subject)  ")
                    lastLetter = abs(keyLetters.last!) +  subject.count + 2
                    keyLetters.append(lastLetter)
                }
            }
            
            keyLetters.forEach { (keyValue) in
                var style = noDifference
                if keyValue < 0 {
                    style = withDifference
                }
                if keyValue == 0{
                    result.addAttributes(style, range: NSRange(location: 0, length: 0))
                }else{
                    let leftBorder = abs(keyLetters[keyLetters.firstIndex(of: keyValue)! - 1])
                    let rightBorfer = abs(keyValue)
                    
                    result.addAttributes(style, range: NSRange(location: leftBorder, length: rightBorfer - leftBorder) )
                }
            }
            
        } else{
            department.subjects.forEach { (subject) in
                result = NSMutableAttributedString(string: result.string + "\(subject) " )
            }
            result.addAttributes(noDifference, range: NSRange(location: 0, length: result.string.count))
        }
        
        return result
    }
    
    func setupMinPoints(department: Department){
        self.addSubview(minPointsLabel)
        
        minPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        minPointsLabel.leftAnchor.constraint(equalTo: departmentNameLabel.leftAnchor).isActive = true
        minPointsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        minPointsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        minPointsLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        minPointsLabel.fontSetup(name: .regular, thickness: .regular, size: .description)
        minPointsLabel.textSetup(text: "Проходной балл: \(department.minPoints)", textAlignment: .left, textColor: .common)
    }
    
    func setupDepartmentNameLabel(department: Department){

        departmentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        departmentNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        departmentNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        departmentNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        departmentNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        
        departmentNameLabel.fontSetup(name: .regular, thickness: .regular, size: .regular)
        departmentNameLabel.textSetup(text: department.name, textAlignment: .center, textColor: .common)
        
    }
    
    func setupFollowersLabel(department: Department){
         
        addToWishlistButtonStatus.addSubview(followersLabel)
        
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        followersLabel.topAnchor.constraint(equalTo: addToWishlistButtonStatus.imageView!.topAnchor, constant: 5).isActive = true
        followersLabel.bottomAnchor.constraint(equalTo: addToWishlistButtonStatus.bottomAnchor).isActive = true
        followersLabel.widthAnchor.constraint(equalTo: addToWishlistButtonStatus.widthAnchor).isActive = true
        followersLabel.centerXAnchor.constraint(equalTo: addToWishlistButtonStatus.centerXAnchor).isActive = true
        
        followersLabel.fontSetup(name: .regular, thickness: .regular, size: .description)
        followersLabel.textSetup(text: "\(department.followers)", textAlignment: .center, textColor: .common)
                
        NetworkManager.shared.listenFollowers(universityName: (Manager.shared.choosed[0] as? University)!.name, facultyFullName: (Manager.shared.choosed[1] as? Faculty)!.fullName, departmentFullName: department.fullName) { (followers) in
            self.followersLabel.text = "\(followers)"
        }
    }
    
    func setupDepartmentFullNameLabel(department: Department){

        departmentFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        departmentFullNameLabel.leftAnchor.constraint(equalTo: departmentNameLabel.rightAnchor, constant: 10).isActive = true
        departmentFullNameLabel.topAnchor.constraint(equalTo: departmentNameLabel.topAnchor).isActive = true
        departmentFullNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        departmentFullNameLabel.rightAnchor.constraint(equalTo: addToWishlistButtonStatus.leftAnchor).isActive = true
        
//        departmentNameLabel.centerYAnchor.constraint(equalTo: departmentFullNameLabel.centerYAnchor).isActive = true // Ровняем  по высоте (для удобства)
        
        departmentFullNameLabel.numberOfLines = 0
        departmentFullNameLabel.fontSetup(name: .regular, thickness: .regular, size: .regular)
        departmentFullNameLabel.textSetup(text: department.fullName, textAlignment: .center, textColor: .common)
    }
    
    func setupAddToWishlistButton(department: Department) {
        
        addToWishlistButtonStatus.translatesAutoresizingMaskIntoConstraints = false
        
        addToWishlistButtonStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        addToWishlistButtonStatus.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        addToWishlistButtonStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        addToWishlistButtonStatus.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addToWishlistButtonStatus.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        addToWishlistButtonStatus.tintColor = .black
        
        if !Manager.shared.departmentStatus(department: department){
            let origImage = UIImage(systemName: "star.fill")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            addToWishlistButtonStatus.setImage(tintedImage, for: .normal)
            
        }
        else{
            let origImage = UIImage(systemName: "star")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            addToWishlistButtonStatus.setImage(tintedImage, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let selectedCellview = UIView()
        selectedCellview.backgroundColor = UIColor.TableView.Cell.choosedBackground
        self.selectedBackgroundView = selectedCellview
        departmentNameLabel.textColor = UIColor.TableView.Cell.choosedAttributes
        departmentFullNameLabel.textColor = UIColor.TableView.Cell.choosedAttributes
        followersLabel.textColor = UIColor.TableView.Cell.choosedAttributes
    }

}
