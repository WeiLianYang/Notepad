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
    
    static let groupTableName = "GroupTable"
    static let groupColumnId = "id"
    static let groupColumnName = "name"
    
    static let noteTableName = "NoteTable"
    static let noteColumnId = "id"
    static let noteColumnGroup = "group"
    static let noteColumnBody = "body"
    static let noteColumnTitle = "title"
    static let noteColumnTime = "time"
    
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
    
    // 添加记事
    static func addNote(note: NoteModel) {
        if !isDbOpen {
            self.openDataBase()
        }
        // 插入数据
        let noteTable = Table(noteTableName)
        let group = Expression<String?>(noteColumnGroup)
        let body = Expression<String?>(noteColumnBody)
        let title = Expression<String?>(noteColumnTitle)
        let time = Expression<String?>(noteColumnTime)
        
        let insert = noteTable.insert(group <- note.group, body <- note.body, title <- note.title, time <- note.time)
        
        if let rowId = try? sqlHandler?.run(insert) {
            print("insert note success, rowId: ", rowId)
        } else {
            print("insert note failed")
        }
    }
    
    // 根据分组获取记事
    class func getNoteByGroupName(groupNameParam: String) -> [NoteModel] {
        if !isDbOpen {
            self.openDataBase()
        }
        // 查询数据
        let noteTable = Table(noteTableName)
        
        var array = Array<NoteModel>()
        
        let groupName = Expression<String?>(noteColumnGroup)
        
        let sequences = try? sqlHandler?.prepare(noteTable.filter(groupName.like(groupNameParam)))
        if sequences == nil {
            return []
        }
        
        for note in sequences! {
            let noteId = Expression<Int64>(noteColumnId)
            let group = Expression<String?>(noteColumnGroup)
            let body = Expression<String?>(noteColumnBody)
            let title = Expression<String?>(noteColumnTitle)
            let time = Expression<String?>(noteColumnTime)
            
            let model = NoteModel()
            
            if let i = try? note.get(noteId) {
                model.noteId = Int(i)
            }
            if let g = try? note.get(group) {
                model.group = g
            }
            if let b = try? note.get(body) {
                model.body = b
            }
            if let t = try? note.get(title) {
                model.title = t
            }
            if let t = try? note.get(time) {
                model.time = t
            }
            
            array.append(model)
        }
        return array
    }
    
    // 更新记事
    class func updateNote(note: NoteModel) {
        if !isDbOpen {
            self.openDataBase()
        }
        
        let noteTable = Table(noteTableName)
        
        let noteId = Expression<Int64>(noteColumnId)
        let query = noteTable.filter(noteId == Int64(note.noteId!))
        
        let group = Expression<String?>(noteColumnGroup)
        let body = Expression<String?>(noteColumnBody)
        let title = Expression<String?>(noteColumnTitle)
        let time = Expression<String?>(noteColumnTime)
        
        if let rows = try? sqlHandler?.run(query.update(group <- note.group, body <- note.body, title <- note.body, time <- note.time)) {
            print("update note success, rows: ", rows)
        } else {
            print("update note failed")
        }
            
    }
    
    // 删除记事
    class func deleteNote(note: NoteModel) {
        if !isDbOpen {
            self.openDataBase()
        }
        
        let noteTable = Table(noteTableName)
        
        let noteId = Expression<Int64>(noteColumnId)
        let query = noteTable.filter(noteId == Int64(note.noteId!))
      
        if let rows = try? sqlHandler?.run(query.delete()) {
            print("delete note success, rows: ", rows)
        } else {
            print("delete note failed")
        }
    }
    
    // 删除某个分组及组中的所有记事
    class func deleteGroup(name: String) {
        if !isDbOpen {
            self.openDataBase()
        }
        // 删除分组下的所有记事
        let noteTable = Table(noteTableName)
        let group = Expression<String?>(noteColumnGroup)
        let query = noteTable.filter(group == name)
        if let rows = try? sqlHandler?.run(query.delete()) {
            print("delete note success, rows: ", rows)
        } else {
            print("delete note failed")
        }
        // 再删除组
        let groupTable = Table(groupTableName)
        let groupName = Expression<String?>(groupColumnName)
        let query2 = groupTable.filter(groupName == name)
        if let rows = try? sqlHandler?.run(query2.delete()) {
            print("delete group success, rows: ", rows)
        } else {
            print("delete group failed")
        }
    }
    
    // 打开数据库
    static func openDataBase() {
        // 沙盒路径
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        // 拼接文件
        let file = path + "/DataBase.sqlite"
        // 打开数据库，不存在就创建
        sqlHandler = try? Connection(file)
        // 创建分组表
        let groupTable = Table(groupTableName)
        let id = Expression<Int64>(groupColumnId)
        let name = Expression<String?>(groupColumnName)
        // 建表
        // CREATE TABLE "GroupTable" ("id" INTEGER PRIMARY KEY NOT NULL, "name" TEXT)
        let _ = try? sqlHandler?.run(groupTable.create(block: { table in
            table.column(id, primaryKey: true)
            table.column(name)
        }))
        
        // 创建记事表
        let noteTable = Table(noteTableName)
        let noteId = Expression<Int64>(noteColumnId)
        let group = Expression<String?>(noteColumnGroup)
        let body = Expression<String?>(noteColumnBody)
        let title = Expression<String?>(noteColumnTitle)
        let time = Expression<String?>(noteColumnTime)
        
        // 建表
        // CREATE TABLE "NoteTable" ("id" INTEGER PRIMARY KEY NOT NULL, "group" TEXT, "body" TEXT, "title" TEXT, "time" TEXT)
        let _ = try? sqlHandler?.run(noteTable.create(block: { table in
            table.column(noteId, primaryKey: true)
            table.column(group)
            table.column(body)
            table.column(title)
            table.column(time)
        }))
        
        // 重置数据库打开标志
        isDbOpen = true
    }
    
}
