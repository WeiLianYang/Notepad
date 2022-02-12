//
//  ViewController.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/7.
//

import UIKit

class ViewController: UIViewController {
    
    var groupView: GroupListView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Notepad"
        self.navigationController?.navigationBar.backgroundColor = UIColor.orange
        
        groupView = GroupListView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 30))
        
        self.view.addSubview(groupView!)
        
//        groupView?.dataArray = ["生活", "工作", "逛街", "购物", "健身", "旅行", "聚会", "探亲", "访友", "学习", "比赛", "会议", "考试"]
        
        var groupArray: Array<String> = []
        for index in 0 ... 24 {
            groupArray.append("Group \(index)")
        }
        groupView?.dataArray = groupArray
        groupView?.updateLayout()
    }

}
