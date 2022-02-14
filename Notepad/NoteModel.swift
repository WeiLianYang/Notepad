//
//  NoteModel.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/14.
//

import UIKit

class NoteModel: NSObject {

    var time: String?
    
    var title: String?
    
    var body: String?
    
    var group: String?
    
    var noteId: Int?
    
    func toDic() -> Dictionary<String, Any?> {
        var dic: [String:Any?] = ["time": time, "title": title, "body": body, "group": group]
        if let id = noteId {
            dic["noteId"] = id
        }
        return dic
    }
    
    
}
