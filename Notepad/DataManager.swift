//
//  DataManager.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/13.
//

import UIKit
import SQLite

class DataManager: NSObject {
    
    // 数据库操作对象
    static var sqlHandler: Connection?
    
    // 数据库打开标识
    static var isDbOpen = false
    
    static let groupTableName = "group"
    static let groupColumnId = "id"
    static let groupColumnName = "name"
    
    // 保存分组
    static func saveGroup(_ groupName: String) {
        if !isDbOpen {
            self.openDataBase()
        }
        // 插入数据
        let groupTable = Table(groupTableName)
        let name = Expression<String?>(groupColumnName)
        let insert = groupTable.insert(name <- groupName)
        if let _ = try? sqlHandler?.run(insert) {
            print("insert success, groupName: \(groupName)")
        } else {
            print("insert falied, groupName: \(groupName)")
        }
    }
    
    // 获取分组列表
    static func getGroupList() -> [String] {
        if !isDbOpen {
            self.openDataBase()
        }
        var array = Array<String>()
        let groupTable = Table(groupTableName)
        
        // 查询数据
        for group in try! sqlHandler!.prepare(groupTable) {
            let nameExpression = Expression<String?>(groupColumnName)
            if let name = try? group.get(nameExpression) {
                array.append(name)
            }
        }
        
        // mock data
        if array.isEmpty {
            print("mock data")
            for index in 0 ... 24 {
                array.append("Group \(index)")
            }
        }
        
        return array
    }
    
    // 打开数据库
    static func openDataBase() {
        // 沙盒路径
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        // 拼接文件
        let file = path + "/DataBase.sqlite"
        // 打开数据库，不存在就创建
        sqlHandler = try? Connection(file)
        // 创建表
        let groupTable = Table(groupTableName)
        let id = Expression<Int64>(groupColumnId)
        let name = Expression<String?>(groupColumnName)
        // 建表
        // CREATE TABLE "group" ("id" INTEGER PRIMARY KEY NOT NULL, "name" TEXT)
        let _ = try? sqlHandler?.run(groupTable.create(block: { table in
            table.column(id, primaryKey: true)
            table.column(name)
        }))
        // 重置数据库打开标志
        isDbOpen = true
    }
    
}
