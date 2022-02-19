//
//  NoteDetailViewController.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/17.
//

import UIKit
import SnapKit

class NoteDetailViewController: UIViewController {
    
    var noteModel: NoteModel?
    
    // 标题输入框。只能单行输入
    var titleTextField: UITextField?
    
    // 内容输入框。可以多行输入
    var bodyTextView: UITextView?
    
    // 所在分组名称
    var group: String?

    // 添加记事标志位
    var isAddNote = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.backgroundColor = UIColor.white
        self.title = "Note"
        
        // 监听键盘事件
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let itemSave = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        let itemDelete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        self.navigationItem.rightBarButtonItems = [itemSave, itemDelete]
        
        initUI()
    }
    
    func initUI() {
        titleTextField = UITextField()
        titleTextField?.borderStyle = .none
        titleTextField?.placeholder = "input note title"
        self.view.addSubview(titleTextField!)
        titleTextField?.snp.makeConstraints({ maker in
            maker.top.equalTo(30)
            maker.left.equalTo(30)
            maker.right.equalTo(-30)
            maker.height.equalTo(30)
        })
        
        let line = UIView()
        line.backgroundColor = UIColor.gray
        self.view.addSubview(line)
        line.snp.makeConstraints({ maker in
            maker.top.equalTo(titleTextField!.snp.bottom).offset(8)
            maker.left.equalTo(15)
            maker.right.equalTo(-15)
            maker.height.equalTo(1)
        })
        
        bodyTextView = UITextView()
        bodyTextView?.layer.borderColor = UIColor.gray.cgColor
        bodyTextView?.layer.borderWidth = 0.5
        self.view.addSubview(bodyTextView!)
        bodyTextView?.snp.makeConstraints({ maker in
            maker.top.equalTo(line.snp.bottom).offset(10)
            maker.left.equalTo(30)
            maker.right.equalTo(-30)
            maker.bottom.equalTo(-50)
        })
    }
    
    @objc func showKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let frameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject
        // 获取键盘高度
        let height = frameInfo.cgRectValue.size.height
        // 更新布局
        bodyTextView?.snp.updateConstraints({ maker in
            maker.bottom.equalTo(-30 - height)
        })
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func hideKeyboard() {
        // 更新布局
        bodyTextView?.snp.updateConstraints({ maker in
            maker.bottom.equalTo(-30)
        })
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func saveNote() {
        // 如果是新建记事，插入数据库
        if isAddNote {
            if titleTextField?.text != nil && titleTextField!.text!.count > 0 {
                noteModel = NoteModel()
                noteModel?.title = titleTextField?.text
                noteModel?.body = bodyTextView?.text
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                noteModel?.time = formatter.string(from: Date())
                noteModel?.group = group
                DataManager.addNote(note: noteModel!)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @objc func deleteNote() {
        
    }
    
    // 当点击屏幕非文本区域时，收起键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        bodyTextView?.resignFirstResponder()
        titleTextField?.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
