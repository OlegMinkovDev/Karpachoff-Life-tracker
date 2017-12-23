import UIKit

enum CategoryType {
    
    case category
    //case subCategory
    case add
    //case addSubCategory
}

class Category {
    
    var name: String!
    var type: CategoryType!
    var circleColor: UIColor
    var subCategories:[Category] = []
    weak var parantCategory: Category?
    
    init(name: String/*, type: CategoryType*/, circleColor: UIColor = UIColor.clear, type: CategoryType = CategoryType.category) {
        
        self.name = name
        self.type = type
        self.circleColor = circleColor
    }
    
    func add(subCategory: Category) {
        subCategories.append(subCategory)
        subCategory.parantCategory = self
    }
    
    func addFirst(subCategory: Category) {
        subCategories.insert(subCategory, at: 0)
        subCategory.parantCategory = self
    }
    
    func remove(category: Category) {
        
        if let index = self.subCategories.index(where: { (newCategory) -> Bool in
            return newCategory.name == category.name
        }) { self.subCategories.remove(at: index) }
    }
    
    func removeFirst() {
        subCategories.remove(at: 0)
    }
}
