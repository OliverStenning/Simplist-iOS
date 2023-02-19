import Foundation
import CoreData

@objc(ShoppingItem)
public class ShoppingItem: NSManagedObject {

    public var name: String {
        get {
            itemName ?? "Unknown item"
        }
        set {
            itemName = newValue
        }
    }
    
    public var id: UUID {
        get {
            itemId ?? UUID()
        }
        set {
            itemId = newValue
        }
    }
    
}

extension ShoppingItem: Identifiable {}
