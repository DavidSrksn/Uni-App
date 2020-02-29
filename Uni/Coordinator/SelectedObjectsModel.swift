//
//  SelectedModel.swift
//  Uni
//
//  Created by David Sarkisyan on 20.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

protocol Node {
    associatedtype NodeValue
    
    var value: NodeValue {get set}
}

fileprivate class UniversityNode{
    init(value: University) {
        self.value = value
    }
    
    var value: University
    
    var faculty: FacultyNode?
    
}

fileprivate class FacultyNode{
    init(value: Faculty, university: UniversityNode) {
        self.value = value
        self.university = university
    }
    
    var value: Faculty
    
    var department: DepartmentNode?
    var university: UniversityNode
    
}

fileprivate class DepartmentNode{
    init(value: Department, faculty: FacultyNode) {
        self.value = value
        self.faculty = faculty
    }
    
    var value: Department
    
    var faculty: FacultyNode
}


public class Selected{
    private var university: UniversityNode?
    private var faculty: FacultyNode?
    private var department: DepartmentNode?
}
