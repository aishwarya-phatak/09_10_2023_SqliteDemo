//
//  ViewController.swift
//  09_10_2023_SqliteDemo
//
//  Created by Vishal Jagtap on 02/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       var dbHelper = DBHelper()
        dbHelper.insertAnEmployeeRecord(empId: 11, empName: "Gajanan")
    }
}
