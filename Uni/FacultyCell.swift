//
//  FacultyCellTableViewCell.swift
//  Uni
//
//  Created by David Sarkisyan on 10/10/2019.
//  Copyright © 2019 DavidS & that's all. All rights reserved.
//

import UIKit

final class FacultyCell: UITableViewCell {

    var facultyLabel = UILabel()
    var facultyFullNameLabel = UILabel()
    
    func setFacultyCell(faculty: Faculty){
        self.backgroundColor = UIColor.TableView.background
        setupFacultyLabel(faculty: faculty)
        setupFacultyFullNameLabel(faculty: faculty)
       }
       
       
    func setupFacultyLabel(faculty: Faculty) {
        facultyLabel.isShimmering = true
        
        self.addSubview(facultyLabel)
        
        facultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        facultyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        facultyLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -5).isActive = true
        facultyLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        facultyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true // Центрирование

        facultyLabel.font = UIFont(name: "AvenirNext-Bold", size: 20)!
        
        if faculty.name != ""{
            facultyLabel.textSetup(text: faculty.name, textAlignment: .center, textColor: .common)
        }else {
            facultyLabel.font = UIFont(name: "AvenirNext-Regular", size: 50)!
            facultyLabel.textSetup(text: "-", textAlignment: .center, textColor: .common)
        }
    }
    
    func setupFacultyFullNameLabel(faculty: Faculty){
        facultyFullNameLabel.isShimmering = true
        
        self.addSubview(facultyFullNameLabel)
        
        facultyFullNameLabel.numberOfLines = 0

        facultyFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        facultyFullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        facultyFullNameLabel.leftAnchor.constraint(equalTo: facultyLabel.rightAnchor, constant: 15).isActive = true
        facultyFullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        facultyFullNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
        facultyFullNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        facultyFullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width - facultyLabel.bounds.width - 15).isActive = true
                
        facultyFullNameLabel.textSetup(text: faculty.fullName, textAlignment: .center, textColor: .common)
        facultyFullNameLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)!
    }
    
    
       override func awakeFromNib() {
           super.awakeFromNib()
           
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setupSelectedState(labels: [facultyLabel,facultyFullNameLabel])
    }
    
}
