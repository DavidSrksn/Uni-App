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
        self.addSubview(facultyLabel)
        
        facultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        facultyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        facultyLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -5).isActive = true
        facultyLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        facultyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true // Центрирование

        facultyLabel.textAlignment = .center
        facultyLabel.font = UIFont(name: "AvenirNext-Bold", size: 20)!
        
        facultyLabel.textColor = UIColor.Text.common
        if faculty.name != ""{
        self.facultyLabel.text = faculty.name
        }else {
            facultyLabel.font = UIFont(name: "AvenirNext-Regular", size: 50)!
            self.facultyLabel.text = "–"
        }
    }
    
    func setupFacultyFullNameLabel(faculty: Faculty){
        self.addSubview(facultyFullNameLabel)
        
        facultyFullNameLabel.numberOfLines = 0

        facultyFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        facultyFullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        facultyFullNameLabel.leftAnchor.constraint(equalTo: facultyLabel.rightAnchor, constant: 15).isActive = true
        facultyFullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        facultyFullNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
        facultyFullNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        facultyFullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width - facultyLabel.bounds.width - 15).isActive = true
                
        facultyFullNameLabel.textColor = UIColor.Text.common
        facultyFullNameLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.facultyFullNameLabel.text = faculty.fullName
    }
    
    
       override func awakeFromNib() {
           super.awakeFromNib()
           
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let selectedCellview = UIView()
        selectedCellview.backgroundColor = UIColor.TableView.Cell.choosedBackground
        self.selectedBackgroundView = selectedCellview
        facultyLabel.textColor = UIColor.TableView.Cell.choosedAttributes
        facultyFullNameLabel.textColor = UIColor.TableView.Cell.choosedAttributes
    }
    
}
