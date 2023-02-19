import Foundation
import CoreData

@objc(ShoppingItem)
public class ShoppingItem: NSManagedObject {

    public var name: String {
        get { itemName ?? "Unknown item" }
        set { itemName = newValue }
    }
    
    public var id: UUID {
        get { itemId ?? UUID() }
        set { itemId = newValue }
    }
    
}

extension ShoppingItem {
    
    static func newShoppingItem(context: NSManagedObjectContext, name: String) -> ShoppingItem {
        let shoppingItem = ShoppingItem(context: context)
        shoppingItem.id = UUID()
        shoppingItem.name = name
        return shoppingItem
    }
    
}

extension ShoppingItem {
    
    static func mock(id: UUID = UUID(), name: String = "Banana") -> ShoppingItem {
        let shoppingItem = ShoppingItem()
        shoppingItem.id = id
        shoppingItem.name = name
        return shoppingItem
    }
    
}

extension ShoppingItem: Identifiable {}
