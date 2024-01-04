//
//  ViewController.swift
//  09_10_2023_SqliteDemo
//
//  Created by Vishal Jagtap on 02/01/24.
//

import UIKit

class ViewController: UIViewController {

    var employees : [Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       var dbHelper = DBHelper()
        dbHelper.insertAnEmployeeRecord(empId: 11, empName: "Gajanan")
        dbHelper.insertAnEmployeeRecord(empId: 12, empName: "Ashutosh")
        dbHelper.insertAnEmployeeRecord(empId: 13, empName: "Rutik")
        
        print("-------------")
        
        employees = dbHelper.retriveEmployeeRecords()
        for eachEmployee in employees{
            print("\(eachEmployee.empId) --- \(eachEmployee.empName)")
        }
        
//        print("-------------")
//        
//        dbHelper.deleteAnEmployeeRecord(empId: 13)
//        
//        print("-------------")
//        
//        employees = dbHelper.retriveEmployeeRecords()
//        for eachEmployee in employees{
//            print("\(eachEmployee.empId) --- \(eachEmployee.empName)")
//        }
        
    }
}
