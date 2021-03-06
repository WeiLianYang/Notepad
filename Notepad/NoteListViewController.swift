//
//  NoteListViewControllerTableViewController.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/14.
//

import UIKit

class NoteListViewController: UITableViewController {
    
    var list = Array<NoteModel>()
    
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = name
        
        /*
        for _ in 0...20 {
            let model = NoteModel()
            model.time = "2022.2.14"
            model.title = "Valentine's Day"
            model.body = "gift list"
            list.append(model)
        }
         */
//        list = DataManager.getNoteByGroupName(groupNameParam: name ?? "")
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        let delItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteGroup))
        self.navigationItem.rightBarButtonItems = [addItem, delItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        list = DataManager.getNoteByGroupName(groupNameParam: name ?? "")
        self.tableView.reloadData()
    }
    
    @objc func addNote() {
        let vc = NoteDetailViewController()
        vc.group = name!
        vc.isAddNote = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func deleteGroup() {
        let alertController = UIAlertController(title: "Warning", message: "Are you sure you want to delete this group and all notes in it?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action2 = UIAlertAction(title: "Delete", style: .destructive, handler: { (UIAlertAction) in
            DataManager.deleteGroup(name: self.name!)
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "noteItemId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        let model = list[indexPath.row]
        cell?.textLabel?.text = model.title
        cell?.detailTextLabel?.text = model.time
        cell?.accessoryType = .disclosureIndicator

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ???????????? cell ???????????????
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = NoteDetailViewController()
        detailVC.group = name!
        detailVC.isAddNote = false
        detailVC.noteModel = list[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
