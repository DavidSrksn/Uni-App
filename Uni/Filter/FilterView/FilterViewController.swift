//
//  ViewController.swift
//  university
//
//  Created by Георгий Куликов on 11.10.2019.
//  Copyright © 2019 Георгий Куликов. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    private var dataFilter = Filter()
    private var presenter = FilterPresenter()
    
    private var constraintClosure: ((CGFloat)->(Void))?
    
    private let constraints = Size()
    private let dataView = FilterViewData()
    private var barHeight: CGFloat = 0
    
    private let dataSourceCountry = ["Москва", "Санкт-Петербург", "Омск", "Волгоград", "Владимир", "Екатеринбург", "Уфа", "Владивосток"]
    private let dataSourceSubject = ["Математика", "Русский", "Информатика", "Физика"]
    
    private var contentView = UIView()
    
    private var subjectTableData = [subjectData]()
    private let subjectTableTitle = "Предметы"
    private let addSubject = UIButton()
    private var subjectTable = UITableView()
    
    private let countryButton = UIDropDownButton()
    
    private let pointsSlider = UISlider()
    private let pointsTextField = UITextField()
    
    private let militaryLabel = UILabel()
    private let militaryButton = UISwitch()
    
    private let campusLabel = UILabel()
    private let campusButton = UISwitch()
    
    private func updateContentTableConstraints(y: CGFloat) {
        
        subjectTable.topAnchor.constraint(equalTo: view.topAnchor, constant: constraints.contentTableY + y).isActive = true
    }
    
    private func updateContentViewConstraints(y: CGFloat) {
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: constraints.contentViewY + y).isActive = true
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: constraints.contentViewY).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: constraints.contentViewHeight).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setupCountry() {
        countryButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        countryButton.changeConstraints = constraintClosure
        
        view.addSubview(countryButton)
        
        countryButton.backgroundColor = dataView.FilterDropDownColor
        countryButton.setTitle("Город", for: .normal)
        countryButton.layer.cornerRadius = dataView.cornerRadius
        
        countryButton.translatesAutoresizingMaskIntoConstraints = false
        
        countryButton.topAnchor.constraint(equalTo: view.topAnchor, constant: constraints.countryButtonY + barHeight).isActive = true
        countryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countryButton.heightAnchor.constraint(equalToConstant: constraints.countryButtonHeight).isActive = true
        countryButton.widthAnchor.constraint(equalToConstant: view.center.x * 2 - constraints.safeAreaBorder).isActive = true
        
        countryButton.dropView.dropDownOptions = dataSourceCountry
    }
    
    private func setupAddSubject() {
        addSubject.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        addSubject.layer.cornerRadius = dataView.cornerRadius
        addSubject.setTitle("Добавить предмет", for: .normal)
        addSubject.backgroundColor = dataView.addSubjectColor
        
        
        addSubject.addTarget(self, action: #selector(pushSubject), for: .touchUpInside)
        
        view.addSubview(addSubject)
        
        addSubject.translatesAutoresizingMaskIntoConstraints = false
        
        addSubject.topAnchor.constraint(equalTo: view.topAnchor, constant: constraints.addSubjectButtonY + barHeight).isActive = true
        addSubject.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constraints.safeAreaBorder).isActive = true
        addSubject.heightAnchor.constraint(equalToConstant: constraints.addSubjectButtonHeight).isActive = true
        addSubject.widthAnchor.constraint(equalToConstant: constraints.addSubjectButtonWidth).isActive = true
    }
    
    private func setupDataContentTable() {
        view.addSubview(subjectTable)
        subjectTableData = []
        pushSubject()
        
        subjectTable.translatesAutoresizingMaskIntoConstraints = false

        subjectTable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        subjectTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: constraints.contentTableY + barHeight).isActive = true
        subjectTable.widthAnchor.constraint(equalToConstant: self.view.center.x * 2 - constraints.safeAreaBorder).isActive = true
        subjectTable.heightAnchor.constraint(equalToConstant: constraints.contentTableHeight).isActive = true
        
        subjectTable.delegate = self
        subjectTable.dataSource = self
    }
    
    private func setupPointsSlider() {
        pointsSlider.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        pointsSlider.tintColor = dataView.sliderColor
        
        pointsSlider.minimumValue = 0
        pointsSlider.maximumValue = Float(subjectTableData.count * 100)
        
        pointsSlider.isContinuous = true
        pointsSlider.addTarget(self, action: #selector(changePoints), for: .valueChanged)
        
        contentView.addSubview(pointsSlider)
        
        pointsSlider.translatesAutoresizingMaskIntoConstraints = false
        
        pointsSlider.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: constraints.safeAreaBorder).isActive = true
        pointsSlider.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: constraints.pointsSliderY + barHeight).isActive = true
        pointsSlider.widthAnchor.constraint(equalToConstant: self.view.center.x * 2 - constraints.safeAreaBorder * 2).isActive = true
        pointsSlider.heightAnchor.constraint(equalToConstant: constraints.pointsSliderHeight).isActive = true
    }
    
    private func setupPointsTextField() {
        pointsTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        pointsTextField.layer.cornerRadius = 10
        pointsTextField.layer.borderColor = UIColor.black.cgColor
        pointsTextField.layer.borderWidth = 1
        
        pointsTextField.placeholder = " Минимальный балл "
        pointsTextField.contentHorizontalAlignment = .left
        
        pointsTextField.delegate = self
        
        contentView.addSubview(pointsTextField)
        
        pointsTextField.translatesAutoresizingMaskIntoConstraints = false
        pointsTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: constraints.safeAreaBorder).isActive = true
        pointsTextField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: constraints.pointsTextFieldY + barHeight).isActive = true
        pointsTextField.heightAnchor.constraint(equalToConstant: constraints.pointsTextFieldHeight).isActive = true
    }
    
    private func setupPoints() {
        setupPointsSlider()
        setupPointsTextField()
    }
    
    private func setupMilitaryLabel() {
        contentView.addSubview(militaryLabel)
        
        militaryLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        militaryLabel.text = "Военная Кафедра"
        
        militaryLabel.translatesAutoresizingMaskIntoConstraints = false

        militaryLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: constraints.safeAreaBorder).isActive = true
        militaryLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: constraints.militaryLabelY + barHeight).isActive = true
        militaryLabel.heightAnchor.constraint(equalToConstant: constraints.militaryLabelHeight).isActive = true
    }
    
    private func setupMilitaryButton() {
        contentView.addSubview(militaryButton)
        
        militaryButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        militaryButton.isOn = true
        militaryButton.onTintColor = dataView.militaryButtonColor
        
        militaryButton.translatesAutoresizingMaskIntoConstraints = false
        
        militaryButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -constraints.safeAreaBorder).isActive = true
        militaryButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: constraints.militaryButtonY + barHeight).isActive = true
    }
    
    private func setupMilitary() {
        setupMilitaryLabel()
        setupMilitaryButton()
    }
    
    private func setupCampusLabel() {
        campusLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        campusLabel.text = "Общежитие"
        
        contentView.addSubview(campusLabel)
        
        campusLabel.translatesAutoresizingMaskIntoConstraints = false

        campusLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: constraints.safeAreaBorder).isActive = true
        campusLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: constraints.campusLabelY + barHeight).isActive = true
        campusLabel.heightAnchor.constraint(equalToConstant: constraints.campusLabelHeight).isActive = true
    }
    
    private func setupCampusButton() {
        contentView.addSubview(campusButton)
        
        campusButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        campusButton.isOn = true
        campusButton.onTintColor = dataView.campusButtonColor
        
        campusButton.translatesAutoresizingMaskIntoConstraints = false
        
        campusButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -constraints.safeAreaBorder).isActive = true
        campusButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: constraints.campusButtonY + barHeight).isActive = true
    }
    
    private func setupCampus() {
        setupCampusLabel()
        setupCampusButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FilterManager.controller = self
        constraintClosure = { y in
            FilterManager.controller.updateContentTableConstraints(y: y)
            FilterManager.controller.updateContentViewConstraints(y: y)
        }
        
        view.backgroundColor = dataView.FilterViewColor
        barHeight = navigationController?.navigationBar.frame.size.height ?? 0
        
        setupCountry()
        setupAddSubject()
        setupDataContentTable()
        
        setupContentView()
        setupPoints()
        setupMilitary()
        setupCampus()
    }
    
    private func fillDataFilter() {
        presenter.changeMinPoint(for: Int(pointsSlider.value))
        presenter.changeMilitary(for: militaryButton.isOn)
        presenter.changeCampus(for: campusButton.isOn)
    }
    
    @objc private func changePoints() {
        pointsTextField.text = " " + String(Int(pointsSlider.value))
    }
    
    @objc private func pushSubject() {
        subjectTableData.append(subjectData(opened: false,
                                            title: subjectTableTitle,
                                            sectionData: dataSourceSubject))
        subjectTable.reloadData()
    }
    
    private func popSubject() {
        // dataContentTable.removeLast()
    }
}

extension FilterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if var num = Int(textField.text ?? "non num") {
            num = (Float(num) - pointsSlider.maximumValue) > .ulpOfOne ? 300 : num
            num = num < 0 ? 0 : num
            pointsSlider.value = Float(num)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension FilterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subjectTableData[section].opened {
            return subjectTableData[section].sectionData.count + 1
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let dataIndex = indexPath.row - 1
        
        if indexPath.row == 0 {
            cell.textLabel?.text = subjectTableData[indexPath.section].title
        } else {
            cell.textLabel?.text = subjectTableData[indexPath.section].sectionData[dataIndex]
        }
        
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return subjectTableData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataIndex = indexPath.row - 1
        
        if indexPath.row != 0 {
            subjectTableData[indexPath.section].title = subjectTableData[indexPath.section].sectionData[dataIndex]
        }
        
        subjectTableData[indexPath.section].opened = !(subjectTableData[indexPath.section].opened)
        
        let sections = IndexSet.init(integer: indexPath.section)
        subjectTable.reloadSections(sections, with: .none)
    }
}
