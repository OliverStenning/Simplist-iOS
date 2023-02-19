import SwiftUI

struct ShoppingListSectionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ShoppingList.listDateCreated, ascending: true)],
        animation: .default
    )
    private var shoppingLists: FetchedResults<ShoppingList>
    
    @State var isAddShoppingListPresented: Bool = false
    @State var selectedShoppingList: ShoppingList?
    
    var body: some View {
        Section("Shopping lists") {
            ForEach(shoppingLists) { shoppingList in
                NavigationLink(value: Route.shoppingList(shoppingList)) {
                    ShoppingListRowView(shoppingList: shoppingList)
                        .swipeActions {
                            SwipeActionsView {
                                deleteShoppingList(shoppingList)
                            } editAction: {
                                self.selectedShoppingList = shoppingList
                                isAddShoppingListPresented = true
                            }
                        }
                }
            }
            AddListRowView(name: "shopping list", action: didTapAddShoppingList)
        }
        .sheet(isPresented: $isAddShoppingListPresented) {
            AddShoppingListView(shoppingList: selectedShoppingList, isAddShoppingListPresented: $isAddShoppingListPresented)
                .presentationDetents([.fraction(0.2)])
        }
    }
    
    private func didTapAddShoppingList() {
        isAddShoppingListPresented = true
    }
    
    private func deleteShoppingList(_ shoppingList: ShoppingList) {
        withAnimation {
            viewContext.delete(shoppingList)
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

    private func deleteShoppingLists(offsets: IndexSet) {
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

struct ShoppingListSectionView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ShoppingListSectionView()
        }
    }
}
