//
//  ViewController.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/7.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Notepad"
        self.navigationController?.navigationBar.backgroundColor = UIColor.orange
    }

}
