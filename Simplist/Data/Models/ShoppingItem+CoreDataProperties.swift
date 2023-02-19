import Foundation
import CoreData


extension ShoppingItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItem> {
        return NSFetchRequest<ShoppingItem>(entityName: "ShoppingItem")
    }

    @NSManaged public var itemName: String?
    @NSManaged public var itemId: UUID?
    @NSManaged public var isCollected: Bool
    @NSManaged public var shoppingList: ShoppingList?

}
