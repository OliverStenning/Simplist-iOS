import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ShoppingList.listDateCreated, ascending: true)],
        animation: .default
    )
    private var shoppingLists: FetchedResults<ShoppingList>
    
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", "Everyday Essentials"), animation: .default)
//    private var newShoppingLists: FetchedResults<ShoppingList>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(shoppingLists) { shoppingList in
                    NavigationLink {
                        DetailView(shoppingList: shoppingList)
                    } label: {
                        Text(shoppingList.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add List", systemImage: "plus")
                    }
                }
            }
            Text("Select an list")
        }
    }

    private func addItem() {
        withAnimation {
            let newShoppingList = ShoppingList(context: viewContext)
            newShoppingList.name = "Everyday Essentials"
            newShoppingList.id = UUID()
            newShoppingList.dateCreated = Date()
            
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
            offsets.map { shoppingLists[$0] }.forEach(viewContext.delete)

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
