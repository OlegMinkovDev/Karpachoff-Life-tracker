//
//  CategoryCell.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 21/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit
import SwipeCellKit

class CategoryCell: SwipeTableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryIcon: OMCircle!
    @IBOutlet weak var categoryTypeImageView: UIImageView!
    @IBOutlet weak var categoryLeftConstraint: NSLayoutConstraint!
    
    var isShowSubCategories = false
    
    func setup(category: Category) {
        
        /*if category.type == .category {
            
            self.categoryNameLabel.text = category.name
            self.categoryIcon.isHidden = false
            self.categoryIcon.backgroundColor = category.circleColor
            self.categoryTypeImageView.image = UIImage(named: "locationPinIcon")
            self.categoryLeftConstraint.constant = 0
            
        } else if category.type == .addCategory {
            
            self.categoryNameLabel.text = "Добавить категорию"
            self.categoryIcon.isHidden = true
            self.categoryTypeImageView.image = UIImage(named: "plusIcon")
            self.categoryLeftConstraint.constant = 0
        }
        
        else if category.type == .subCategory {
    
            self.categoryNameLabel.text = category.name
            self.categoryIcon.isHidden = true
            self.categoryTypeImageView.image = UIImage(named: "locationPinIcon")
            self.categoryLeftConstraint.constant = 50
        }
        
        else if category.type == .addSubCategory {
            
            self.categoryNameLabel.text = "Добавить подкатегорию"
            self.categoryIcon.isHidden = true
            self.categoryTypeImageView.image = UIImage(named: "plusIcon")
            self.categoryLeftConstraint.constant = 50
        }*/
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
