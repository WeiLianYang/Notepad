//
//  ViewController.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/7.
//

import UIKit

class ViewController: UIViewController {
    
    var groupView: GroupListView?
    var groupArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Notepad"
        // 取消导航栏对页面布局的影响
        self.edgesForExtendedLayout = UIRectEdge()
        
//        self.navigationController?.navigationBar.backgroundColor = UIColor.orange
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        
        groupView = GroupListView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 30))
        
        self.view.addSubview(groupView!)
        
//        groupView?.dataArray = ["生活", "工作", "逛街", "购物", "健身", "旅行", "聚会", "探亲", "访友", "学习", "比赛", "会议", "考试"]
        
        for index in 0 ... 24 {
            groupArray.append("Group \(index)")
        }
        groupView?.dataArray = groupArray
        groupView?.updateLayout()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createGroup))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func createGroup() {
        let alertController = UIAlertController(title: "Create group", message: "The group name must be unique and non-empty", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "input group name"
        }
            
        let cancelItem = UIAlertAction(title: "cancel", style: .cancel, handler: { UIAlertAction in
            return
        })
        let confirmItem = UIAlertAction(title: "confirm", style: .default, handler: { UIAlertAction in
            var invalid = false
            self.groupArray.forEach({ element in
                if element == alertController.textFields?.first!.text || alertController.textFields?.first!.text?.count == 0 {
                    invalid = true
                }
            })
            if invalid {
                print("group name is invalid")
                return
            }
            self.groupArray.append(alertController.textFields!.first!.text!)
            self.groupView?.dataArray = self.groupArray
            self.groupView?.updateLayout()
        })
        alertController.addAction(cancelItem)
        alertController.addAction(confirmItem)
        self.present(alertController, animated: true, completion: nil)
    }
                                        

}
