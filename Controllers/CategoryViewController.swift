//
//  CategoryViewController.swift
//  Todo
//
//  Created by Piotr Ćwiertnia on 04/09/2021.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [ItemCategory]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoryArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category.name
        return cell
    }
    
    
    //MARK: - Add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new task category" , message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // When button is pressed.
            if let item = alert.textFields?[0].text {
                if item == "" {
                    return
                }
                print(item)
                
                let newCategory = ItemCategory(context: self.context)
                newCategory.name = item
                self.categoryArray.append(newCategory)
                
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
    
    
    
    //MARK: - Data Manipulation Methods
    
    func saveData() {
        do{
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadData(with request: NSFetchRequest<ItemCategory> = ItemCategory.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
    
    
    //MARK: - TableView Delegate Methods
    
    
    
}
