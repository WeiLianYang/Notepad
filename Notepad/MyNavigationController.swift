//
//  MyNavigationController.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/15.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initNavigationBarColor()
    }
    
    func initNavigationBarColor() {
        // 配置导航栏背景色.
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.c232323, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let image = UIColor.cyan.image
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundImage = image
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = textAttributes
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            self.navigationBar.setBackgroundImage(image, for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.titleTextAttributes = textAttributes
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
