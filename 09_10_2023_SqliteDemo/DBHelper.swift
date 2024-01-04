//
//  DBHelper.swift
//  09_10_2023_SqliteDemo
//
//  Created by Vishal Jagtap on 02/01/24.
//

import Foundation
import SQLite3

class DBHelper{
    var dbPath : String = "iOSDec.sqlite"
    var db : OpaquePointer?
    
    init(){
        db = self.openDatabase()
        self.createEmployeeTable()
    }
    
    func openDatabase()->OpaquePointer?{
        let fileUrl = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathExtension(dbPath)
        
        if sqlite3_open(
            fileUrl.path,
            &db) == SQLITE_FAIL{
            print("Database creation was not successful!")
        } else {
            print("File URL -- \(fileUrl.path)")
            print("Database is created successfully \(dbPath)")
            print("db -- \(String(describing: db))")
        }
        return db
    }
    
    func createEmployeeTable(){
        let createQueryString = "CREATE TABLE IF NOT EXISTS Employee(empId INTEGER,empName Text);"
        var createStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(
            db,
            createQueryString,
            -1,
            &createStatement,
            nil) == SQLITE_OK{
            
            if sqlite3_step(createStatement) == SQLITE_DONE{
                print("Employee Table created successfully")
                print(createStatement as Any)
            } else {
                print("Employee Table creation has failed")
            }
        } else {
            print("The query statement preparation has failed")
        }
        sqlite3_finalize(createStatement)
    }
    
    func insertAnEmployeeRecord(empId : Int, empName : String){
        let insertQueryString = "INSERT INTO Employee(empId,empName) VALUES(?,?);"
        var insertStatement : OpaquePointer?
        if sqlite3_prepare_v2(
            db,
            insertQueryString,
            -1,
            &insertStatement,
            nil) == SQLITE_OK{
            sqlite3_bind_int(insertStatement,1, Int32(empId))
            sqlite3_bind_text(insertStatement,
                                  2,
                                  (empName as NSString).utf8String,
                                  -1,
                                  nil)
            //to check whether row is inserted or not
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Successful execution")
            } else {
                print("Unsuccessful execution")
            }
        }else{
            print("Insert Statement Preparation has failed")
        }
        
        sqlite3_finalize(insertStatement)
    }
    
    func deleteAnEmployeeRecord(empId : Int){
        let deleteQUeryString = "DELETE FROM Employee where empId = ?;"
        var deleteStatement : OpaquePointer?
        if sqlite3_prepare_v2(
            db,
            deleteQUeryString,
            -1,
            &deleteStatement,
            nil) == SQLITE_OK{
            sqlite3_bind_int(deleteStatement, 1, Int32(empId))
        } else {
            print("Delete statement preparation failed")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func retriveEmployeeRecords()->[Employee]{
        var employees :[Employee] = []
        let retriveEmployeeQueryString = "SELECT * FROM Employee;"
        var retirveStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(
            db,
            retriveEmployeeQueryString,
            -1,
            &retirveStatement,
            nil) == SQLITE_OK{
            while sqlite3_step(retirveStatement) == SQLITE_ROW{
               let retrivedEmpId =  (sqlite3_column_int(retirveStatement, 0))
            
               let retrivedEmpName =
                String(describing: String(cString:sqlite3_column_text(retirveStatement, 1)))
                print(retrivedEmpName)
            
               let retrivedEmployee =
                Employee(
                    empId: Int(retrivedEmpId),
                    empName: retrivedEmpName)
                employees.append(retrivedEmployee)
            }
        } else {
            print("Statement Preparation failed")
        }
        return employees
    }
}
