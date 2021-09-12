//
//  ViewController.swift
//  Todo
//
//  Created by Piotr Ćwiertnia on 02/09/2021.
//
// TODO: Create this app in SwiftUI
// I'm too sick to work ;/

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemArray = [Item]()
    
    var selectedCategory: Category? {
        didSet {
//            loadData()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = selectedCategory?.name
        
//        searchBar.delegate = self
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "no data")
        
//        ~~~ Delete functionality ~~~
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveData()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Tasks
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Todo task" , message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // When button is pressed.
            if let item = alert.textFields?[0].text {
                if item == "" {
                    return
                }
                print(item)
                
//                let newTask = Item(context: self.context)
//                newTask.title = item
//                newTask.done = false
//                newTask.parentCategory = self.selectedCategory
//                self.itemArray.append(newTask)
                
                self.saveData()
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { alertTextField in
            // When alert is created.
            alertTextField.placeholder = "Create new item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Method
    
    func saveData() {
        
        do{
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//        if let safePredicate = request.predicate {
//            request.predicate = NSCompoundPredicate(type: .and, subpredicates: [safePredicate, categoryPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        tableView.reloadData()
//    }
    
    
    
}

//extension TodoListViewController: UISearchBarDelegate {
//
////    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////        let request: NSFetchRequest<Item> = Item.fetchRequest()
////
////        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
////
////        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
////
////        loadData(with: request)
////    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadData()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        } else {
//            let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//            loadData(with: request)
//        }
//    }
//
//}

