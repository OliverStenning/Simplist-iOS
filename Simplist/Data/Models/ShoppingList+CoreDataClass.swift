import Foundation
import CoreData

@objc(ShoppingList)
public class ShoppingList: NSManagedObject {

    public var name: String {
        get {
            listName ?? "Unknown list"
        }
        set {
            listName = newValue
        }
    }
    
    public var id: UUID {
        get {
            listId ?? UUID()
        }
        set {
            listId = newValue
        }
    }
    
    public var dateCreated: Date {
        get {
            listDateCreated ?? Date(timeIntervalSince1970: 0)
        }
        set {
            listDateCreated = newValue
        }
    }
    
    public var itemsArray: [ShoppingItem] {
        let set = shoppingItems as? Set<ShoppingItem> ?? []
        return set.sorted {
            $0.name < $1.name
        }
    }
    
//    init(id: UUID, name: String, dateCreated: Date) {
//        super.init()
//        self.listId = id
//        self.listName = name
//        self.listDateCreated = dateCreated
//    }
    
}

extension ShoppingList {
    
//    static func mock() -> ShoppingList {
//        ShoppingList(id: UUID(), name: "Everyday Essentials", dateCreated: Date())
//    }
    
}

extension ShoppingList: Identifiable {}
