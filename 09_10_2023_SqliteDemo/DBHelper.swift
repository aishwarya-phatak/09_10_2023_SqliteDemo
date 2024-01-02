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
//        self.createEmployeeTable()
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
    
//    func createEmployeeTable(){
//
//    }
    
}
