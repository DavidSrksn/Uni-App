//
//  ViewController.swift
//  university
//
//  Created by Георгий Куликов on 11.10.2019.
//  Copyright © 2019 Георгий Куликов. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    private var presenter = FilterPresenter()
    
    private let constraints = Size()
    private let dataView = FilterViewData()
    
    private let dataSourceCountry = ["Москва", "Санкт-Петербург", "Омск", "Волгоград", "Владимир", "Екатеринбург", "Уфа", "Владивосток"]
    private let dataSourceSubject = ["Математика", "Русский", "Информатика", "Физика"]
    
    private var contentView = UIView()
    private var contentTable = UITableView()
    
    private let countryHeaderTitle: String = "Города"
    private var countryButton = UIDropDownButton()
    
    private let subjectsHeaderTitle: String = "Предметы"
    private var subjectsButton = UIDropDownButton()
    
    private var dataContentTable: [[UIDropDownButton]] = []
    private var dataHeaderTitle: [String] = []
    
    private let pointsSlider = UISlider()
    private let pointsTextField = UITextField()
    
    private let militaryLabel = UILabel()
    private let militaryButton = UISwitch()
    
    private let campusLabel = UILabel()
    private let campusButton = UISwitch()
    
    private func setupDataContentTable() {
        view.addSubview(contentTable)
        
        dataContentTable.append([])
        dataContentTable.append([])
        pushCountry()
        pushSubject()
        
        dataHeaderTitle.append(countryHeaderTitle)
        dataHeaderTitle.append(subjectsHeaderTitle)
        
        contentTable.translatesAutoresizingMaskIntoConstraints = false
        
        contentTable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: constraints.countryButtonY).isActive = true
        contentTable.widthAnchor.constraint(equalToConstant: self.view.center.x * 2 - constraints.safeAreaBorder).isActive = true
        contentTable.heightAnchor.constraint(equalToConstant: constraints.countryButtonHeight * 4).isActive = true
        
        contentTable.delegate = self
        contentTable.dataSource = self
    }
    
    private func setupContentView() {
        
    }
    
    private func setupPoints() {
        
    }
    
    private func setupMilitary() {
        
    }
    
    private func setupCampus() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = dataView.FilterViewColor
        
        setupContentView()
        
        setupPoints()
        setupMilitary()
        setupCampus()
        
        setupDataContentTable()
    }
    
    @objc
    private func pushCountry() {
        let countryButton = UIDropDownButton()
        setupCountry(country: countryButton)
        
        dataContentTable[0].append(countryButton)
    }
    
    private func popCountry() {
        dataContentTable[0].removeLast()
    }
    
    @objc
    private func pushSubject() {
        let subjectButton = UIDropDownButton()
        setupSubjects(subject: subjectButton)
        
        dataContentTable[1].append(subjectButton)
    }
    
    private func popSubject() {
        dataContentTable[1].removeLast()
    }
}
