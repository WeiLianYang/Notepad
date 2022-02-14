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
        
        for _ in 0...20 {
            let model = NoteModel()
            model.time = "2022.2.14"
            model.title = "Valentine's Day"
            model.body = "gift list"
            list.append(model)
        }
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        let delItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(delNote))
        self.navigationItem.rightBarButtonItems = [addItem, delItem]
    }
    
    @objc func addNote() {
        
    }
    
    @objc func delNote() {
        
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
