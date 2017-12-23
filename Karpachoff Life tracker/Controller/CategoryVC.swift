//
//  ChangeActivityVC.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 21/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit
import SwipeCellKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var addCategoryTextField = UITextField()
    
    var tableViewData = [Category]()
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        let addCategory = Category(name: "Добавить категорию", type: .add)
        
        tableViewData = categories
        tableViewData.append(addCategory)
    }
    
    func showAlert(title: String, message: String, action: UIAlertAction?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { (textField) in
            self.addCategoryTextField = textField
            self.addCategoryTextField.autocapitalizationType = .sentences
            self.addCategoryTextField.placeholder = "Название"
        })
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let doneAction = UIAlertAction(title: "Ок", style: .default)
        
        alertController.addAction(cancelAction)
        
        if action != nil {
            alertController.addAction(action!)
        } else {
            alertController.addAction(doneAction)
        }
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func addCategory() {
        
        let newCategory = Category(name: self.addCategoryTextField.text!, circleColor: .purple)
        let indexPath = IndexPath(row: self.tableViewData.count - 1, section: 0)
        
        insertCategory(category: newCategory, at: indexPath)
        categories.append(newCategory)
    }
    
    func addSubCategory(to category: Category, at indexPath: IndexPath) {
        
        let newCategory = Category(name: self.addCategoryTextField.text!)
        category.add(subCategory: newCategory)
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        
        insertCategory(category: newCategory, at: indexPath)
        
        if let index = categories.index(where: { (existCategory) -> Bool in
            return existCategory.name == category.name
        }) { categories[index] = category }
    }
    
    func showHideSubCategories(at indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CategoryCell
        let category = tableViewData[indexPath.row]
        
        // show
        if !cell.isShowSubCategories {
            
            var currentIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
            for subCategory in category.subCategories {
                insertCategory(category: subCategory, at: currentIndexPath)
            }
            
            let addSubCategory = Category(name: "Добавить подкатегорию", type: .add)
            category.add(subCategory: addSubCategory)
            
            if category.subCategories.count == 0 {
                insertCategory(category: addSubCategory, at: currentIndexPath)
            } else {
                currentIndexPath = IndexPath(row: indexPath.row + category.subCategories.count, section: 0)
                insertCategory(category: addSubCategory, at: currentIndexPath)
            }
        
            cell.isShowSubCategories = true
            category.subCategories.reverse()
            
        } else { // hide
            
            for subCategory in category.subCategories {
                
                if subCategory.type == .add {
                    category.remove(category: subCategory)
                }
                
                let currentIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
                tableViewData.remove(at: currentIndexPath.row)
                tableView.deleteRows(at: [currentIndexPath], with: .automatic)
            }
            
            cell.isShowSubCategories = false
            category.subCategories.reverse()
        }
    }
    
    func insertCategory(category: Category, at indexPath: IndexPath) {
        
        tableViewData.insert(category, at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func removeCategory(at indexPath: IndexPath) {
        
        self.tableViewData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoryVC: UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.delegate = self
        
        cell.categoryNameLabel.text = tableViewData[indexPath.row].name
        cell.categoryIcon.color = tableViewData[indexPath.row].circleColor
        
        if tableViewData[indexPath.row].type == .add {
            cell.categoryTypeImageView.image = UIImage(named: "plusIcon")
        } else {
            cell.categoryTypeImageView.image = UIImage(named: "locationPinIcon")
        }
        
        if tableViewData[indexPath.row].parantCategory == nil {
            cell.categoryLeftConstraint.constant = 0
        } else {
            cell.categoryLeftConstraint.constant = 50
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .left else { return nil }
        
        var swipeActions:[SwipeAction] = []
        
        let editAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            // handle action by updating model with deletion
        }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            
            if self.tableViewData[indexPath.row].parantCategory != nil {
                
                if let index = self.categories.index(where: { (category) -> Bool in
                    return self.tableViewData[indexPath.row].parantCategory!.name == category.name
                }) { self.categories[index].remove(category: self.tableViewData[indexPath.row]) }
                
            } else {
                
                if let index = self.categories.index(where: { (category) -> Bool in
                    return self.tableViewData[indexPath.row].name == category.name
                }) { self.categories.remove(at: index) }
            }
            
            self.removeCategory(at: indexPath)
        }
        
        editAction.backgroundColor = #colorLiteral(red: 1, green: 0.3680975437, blue: 0.2529267967, alpha: 1)
        editAction.image = UIImage(named: "editIcon")
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.3680975437, blue: 0.2529267967, alpha: 1)
        deleteAction.image = UIImage(named: "deleteIcon")
        
        if self.tableViewData[indexPath.row].type != .add {
            swipeActions.append(deleteAction)
            swipeActions.append(editAction)
        }
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = tableViewData[indexPath.row]
        
        if category.type == .category {
            if category.parantCategory == nil {
                showHideSubCategories(at: indexPath)
            }
        } else {
            
            if category.name == "Добавить категорию" {
                
                let alertAction = UIAlertAction(title: "Ок", style: .default, handler: { (_) in
                    self.addCategory()
                })
                showAlert(title: "Новая категория", message: "Введите название новой категории", action: alertAction)
            
            } else {
                
                let alertAction = UIAlertAction(title: "Ок", style: .default, handler: { (_) in
                    self.addSubCategory(to: category.parantCategory!, at: indexPath)
                })
                showAlert(title: "Новая подкатегория", message: "Введите название новой подкатегории", action: alertAction)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}


