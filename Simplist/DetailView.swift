import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let shoppingList: ShoppingList
    
    @FetchRequest var shoppingItems: FetchedResults<ShoppingItem>
    
    init(shoppingList: ShoppingList) {
        self.shoppingList = shoppingList
        _shoppingItems = FetchRequest(
            entity: ShoppingItem.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \ShoppingItem.itemName, ascending: true)],
            predicate: NSPredicate(format: "shoppingList == %@", shoppingList)
        )
    }
    
    var body: some View {
        List {
            ForEach(shoppingItems) { item in
                Text(item.name)
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newShoppingItem = ShoppingItem(context: viewContext)
            newShoppingItem.name = "Banana"
            newShoppingItem.itemId = UUID()
            newShoppingItem.shoppingList = shoppingList
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                shoppingList.removeFromShoppingItems(shoppingList.itemsArray[index])
            }
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
