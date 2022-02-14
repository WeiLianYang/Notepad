//
//  ViewController.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/7.
//

import UIKit

class ViewController: UIViewController, GroupClickDelegate {
    
    var groupView: GroupListView?
    var groupArray: Array<String> = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Notepad"
        // 取消导航栏对页面布局的影响
        self.edgesForExtendedLayout = UIRectEdge()
        
        let image = UIImage()
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.cyan
            appearance.shadowColor = .blue
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = self.navigationItem.standardAppearance
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        }
                
        groupView = GroupListView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 30))
        groupView?.groupClickDelegate = self
        
        self.view.addSubview(groupView!)
        
//        groupView?.dataArray = ["生活", "工作", "逛街", "购物", "健身", "旅行", "聚会", "探亲", "访友", "学习", "比赛", "会议", "考试"]
        
        groupArray = DataManager.getGroupList()
        
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
            
        let cancelItem = UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            return
        })
        let confirmItem = UIAlertAction(title: "Confirm", style: .default, handler: { UIAlertAction in
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
            let groupName = alertController.textFields!.first!.text!
            self.groupArray.append(groupName)
            self.groupView?.dataArray = self.groupArray
            self.groupView?.updateLayout()
            
            // 保存添加的分组
            DataManager.saveGroup(groupName)
        })
        alertController.addAction(cancelItem)
        alertController.addAction(confirmItem)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func onGroupClick(title: String) {
        let controller = NoteListViewController()
        controller.name = title
        self.navigationController?.pushViewController(controller, animated: true)
    }
                                        

}
