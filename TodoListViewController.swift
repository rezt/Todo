//
//  ViewController.swift
//  Todo
//
//  Created by Piotr Ćwiertnia on 02/09/2021.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Learn swift", "???", "profit"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item
        return cell
    }

}

