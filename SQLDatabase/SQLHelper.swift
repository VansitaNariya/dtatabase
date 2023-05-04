//
//  SQLHelper.swift
//  SQLDatabase
//
//  Created by R93 on 20/09/34.
//

import UIKit
import SQLite3

struct User {
    var name : String
    var id : Int32
}

class SQLHelper {
    static var shared = SQLHelper()
    var op : OpaquePointer?
    
    var database : FMDatabase!
    
    private init() {
        createFile()
    }
    
    func createFile() {
        let pathh = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("tabledetail.sqlite")
        print(pathh.path)
        database = FMDatabase(url: pathh)
        database.open()
        createTable()
    }
    
    func createTable() {
        let createQ = "CREATE TABLE users(Id INTEGER PRIMARY KEY, Name TEXT);"
        do {
            try database.executeUpdate(createQ, values: [nil])
        } catch {
            print("error")
        }
    }
    
    func addItem(_ item : User) -> Bool {
        let x = retriveAllData()
        for i in x {
            if i.id == item.id { 
                return true
            }
        }
        return false
    }
    
    func addData(_ item : User) {
        do {
            try database.executeUpdate("Insert Into users (Id, Name) VALUES (?, ?);", values: [item.id,item.name])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retriveAllData() -> [User]{
        let retriveQ = "SELECT * FROM users;"
        var array = [User]()
        do {
            let a = try database.executeQuery(retriveQ, values: nil)
            while a.next() {
                let x = a.int(forColumnIndex: 0)
                if let y = a.string(forColumnIndex: 1) {
                    array.append(User(name: y, id: x))
                }
            }
        } catch {
            print("error")
        }
        return array
    }
    
    func deleteItem(id : Int32) -> (String,Bool) {
        
        let x = retriveAllData()
        
        for i in x {
            if i.id == id {
                return ("Success",true)
            }
        }
        return ("Some Thing Went Wrong",false)
    }
    
    func delete(id : Int32) {
        database.executeUpdate("DELETE FROM users WHERE Id = (?);", withArgumentsIn: [id])
    }
    
    func nameDelete(name : String) -> [Int32] {
        let x = retriveAllData()
        var arr = [Int32]()
        
        for i in x {
            if i.name == name{
                arr.append(i.id)
            }
        }
        return arr
    }
}
