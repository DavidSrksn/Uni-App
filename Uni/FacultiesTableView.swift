//
//  FacultiesTableView.swift
//  Uni
//
//  Created by David Sarkisyan on 10/10/2019.
//  Copyright © 2019 DavidS & that's all. All rights reserved.
//

import UIKit

final class FacultiesTableView: UIViewController {
    
    var statusCheckMark = UIImage()
    var militaryDepartmentLabel = UILabel()
    var dormitoryLabel = UILabel()
    
    let sideAnchor: CGFloat = 10
    let cornerRadius: CGFloat = 10
    
    var mapButton = UIButton()
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var universityImage: UIImageView!
    @IBOutlet weak var universityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Manager.shared.UFD[Manager.shared.choosed[0] as! University]?.keys.count)! == 0 {
            NetworkManager.shared.loadFaculties(minPoints:Manager.shared.filterSettings.minPoint,subjects: Manager.shared.filterSettings.subjects, completion: { [weak self] in
                self?.stopShimmer()
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        setupUniversityLabel()
        setupImage()
        setupMapButton()
        setupDromitoryLabel()
        setupMilitaryDepartmentLabel()
        setupView()
        setupTable()
        self.prepareShimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startShimmer()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.View.background
    }
    
    func setupDromitoryLabel(){
        
        let attributedString = NSMutableAttributedString(string: "Общежитие  ")
        
        let image1Attachment = NSTextAttachment()
        
        var status: String
        var statusColor: UIColor
        
        if (Manager.shared.choosed[0] as! University).dormitory {
            status = "checkmark"
            statusColor = UIColor(red: 0, green: 128/256, blue: 0, alpha: 1)
        }else{
            status = "xmark"
            statusColor = UIColor(red: 255/256, green: 0, blue: 0, alpha: 1)
        }
        
        let image = UIImage(systemName: status)?.withTintColor(statusColor, renderingMode: .alwaysTemplate)
        image1Attachment.image = image

        let image1String = NSAttributedString(attachment: image1Attachment)

        attributedString.append(image1String)
        
        dormitoryLabel.isShimmering = true
        
        view.addSubview(dormitoryLabel)
        
        dormitoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dormitoryLabel.topAnchor.constraint(equalTo: universityImage.topAnchor,constant:  sideAnchor).isActive = true
        dormitoryLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -sideAnchor).isActive = true
        dormitoryLabel.leftAnchor.constraint(equalTo: mapButton.leftAnchor).isActive = true
        dormitoryLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        dormitoryLabel.layer.cornerRadius = dormitoryLabel.bounds.height
        
        dormitoryLabel.fontSetup(name: .regular, thickness: .regular, size: .description)
        dormitoryLabel.attributedTextSetup(text: attributedString, textAlignment: .left)
    }
    
    func setupMilitaryDepartmentLabel(){
        
        let attributedString = NSMutableAttributedString(string: "Военная кафедра   ")
        
       let image1Attachment = NSTextAttachment()
        
        var status: String
        var statusColor: UIColor
        
        if (Manager.shared.choosed[0] as! University).militaryDepartment {
            status = "checkmark"
            statusColor = UIColor(red: 0, green: 128/256, blue: 0, alpha: 1)
        }else{
            status = "xmark"
            statusColor = UIColor(red: 255/256, green: 0, blue: 0, alpha: 1)
        }
        
        let image = UIImage(systemName: status)?.withTintColor(statusColor, renderingMode: .alwaysTemplate)
        image1Attachment.image = image

        let image1String = NSAttributedString(attachment: image1Attachment)

        attributedString.append(image1String)
        
        militaryDepartmentLabel.isShimmering = true
        
        view.addSubview(militaryDepartmentLabel)
        
        militaryDepartmentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        militaryDepartmentLabel.topAnchor.constraint(equalTo: dormitoryLabel.bottomAnchor, constant: 20).isActive = true
        militaryDepartmentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideAnchor).isActive = true
        militaryDepartmentLabel.leftAnchor.constraint(equalTo: mapButton.leftAnchor).isActive = true
        militaryDepartmentLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        militaryDepartmentLabel.layer.cornerRadius = militaryDepartmentLabel.bounds.height
        
        militaryDepartmentLabel.fontSetup(name: .regular, thickness: .regular, size: .description)
        militaryDepartmentLabel.attributedTextSetup(text: attributedString, textAlignment: .left)
    }
    
    func setupMapButton(){
        mapButton.isShimmering = true
        
        view.addSubview(mapButton)
        
        mapButton.layer.cornerRadius = 5
        
        mapButton.setupColors(type: .map, image: nil)
        
        mapButton.textSetup(type: .map, textColor: .common)
        mapButton.titleLabel?.fontSetup(name: .regular, thickness: .regular, size: .description)
        
        mapButton.addTarget(.none, action: #selector(mapButtonAction), for: .touchUpInside)
        
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        
        mapButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        mapButton.bottomAnchor.constraint(equalTo: universityImage.bottomAnchor).isActive = true
        mapButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -sideAnchor).isActive = true
        mapButton.leftAnchor.constraint(equalTo: universityImage.rightAnchor,constant: sideAnchor).isActive = true
    }
    
    @objc func mapButtonAction(){
        Manager.shared.openMaps(university: (Manager.shared.choosed[0] as! University))
    }
    
    func setupTable(){
        self.title = "Факультеты"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Georgia", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.white]

        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: universityImage.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.TableView.separator
        tableView.separatorInset = .zero
        tableView.backgroundColor = UIColor.TableView.background
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupImage(){
        universityImage.isShimmering = true
        
        let image = UIImage(named: "\((Manager.shared.choosed[0] as! University).name).jpg")
        
        universityImage.translatesAutoresizingMaskIntoConstraints = false
        
        universityImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideAnchor).isActive = true
        universityImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        universityImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        universityImage.topAnchor.constraint(equalTo: universityLabel.bottomAnchor, constant: 5).isActive = true
        
        universityImage.image = image
        universityImage.layer.cornerRadius = cornerRadius
    }
    
    func setupUniversityLabel(){
        universityLabel.isShimmering = true
        
        universityLabel.layer.cornerRadius = cornerRadius
        
        universityLabel.textSetup(text:(Manager.shared.choosed[0] as! University).fullName, textAlignment: .center, textColor: .common)
        universityLabel.numberOfLines = 0
        
        universityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        universityLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        universityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideAnchor).isActive = true
        universityLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideAnchor).isActive = true
        universityLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
}

    extension FacultiesTableView: UITableViewDelegate, UITableViewDataSource{
       
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let backGroundview = UIView()
            
            view.addSubview(backGroundview)
            
            backGroundview.translatesAutoresizingMaskIntoConstraints = false
            
            backGroundview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            backGroundview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            backGroundview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            return backGroundview
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if (Manager.shared.UFD[Manager.shared.choosed[0] as! University]?.keys.count)! == 0{
                return FakeData.cellsNumber
            }else{
                return (Manager.shared.UFD[Manager.shared.choosed[0] as! University]?.keys.count)!
            }
        }

        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }

        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let faculty = FakeData.faculty
            // Array((Manager.shared.UFD[Manager.shared.choosed[0] as! University]?.keys))[indexPath.row] ??
            let cell = tableView.dequeueReusableCell(withIdentifier: "FacultyCell") as! FacultyCell
            cell.setFacultyCell(faculty: faculty)
            return cell
        }


        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            Manager.shared.choosed[1] = Array((Manager.shared.UFD[Manager.shared.choosed[0] as! University]?.keys)!)[indexPath.row]
            let viewController = storyboard?.instantiateViewController(identifier: "кафедра") as! DepartmentsTableView
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(viewController, animated: true)
        }
}

