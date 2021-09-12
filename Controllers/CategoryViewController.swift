//
//  CategoryViewController.swift
//  Todo
//
//  Created by Piotr Ćwiertnia on 04/09/2021.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray = [Category]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadData()
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
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "no data")
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
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
                
                let newCategory = Category()
                newCategory.name = item
                self.categoryArray.append(newCategory)
                
                self.save(category: newCategory)
                
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
    
    func save(category: Category) {
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    func loadData(with request: NSFetchRequest<ItemCategory> = ItemCategory.fetchRequest()) {
//
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        tableView.reloadData()
//    }
//
//
    

    
}
