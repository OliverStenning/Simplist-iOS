import Foundation
import CoreData

@objc(ShoppingList)
public class ShoppingList: NSManagedObject {

    public var name: String {
        get { listName ?? "Unknown list" }
        set { listName = newValue }
    }
    
    public var id: UUID {
        get { listId ?? UUID() }
        set { listId = newValue }
    }
    
    public var dateCreated: Date {
        get { listDateCreated ?? Date(timeIntervalSince1970: 0) }
        set { listDateCreated = newValue }
    }
    
    public var itemsArray: [ShoppingItem] {
        let set = shoppingItems as? Set<ShoppingItem> ?? []
        return set.sorted {
            $0.name < $1.name
        }
    }
    
}

extension ShoppingList {
    
    static func newShoppingList(context: NSManagedObjectContext, name: String) -> ShoppingList {
        let shoppingList = ShoppingList(context: context)
        shoppingList.id = UUID()
        shoppingList.name = name
        shoppingList.dateCreated = Date()
        return shoppingList
    }
    
}

extension ShoppingList {
    
    static func mock(id: UUID = UUID(), name: String = "Everyday Essentials", dateCreated: Date = Date()) -> ShoppingList {
        let list = ShoppingList()
        list.id = id
        list.name = name
        list.dateCreated = dateCreated
        return list
    }
    
}

extension ShoppingList: Identifiable {}
