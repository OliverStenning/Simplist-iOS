import SwiftUI

struct AddShoppingListView: View {
    
    enum FocusedField {
        case nameInput
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let shoppingList: ShoppingList?
    
    @State var shoppingListName: String = ""
    @FocusState private var focusField: FocusedField?
    @Binding var isAddShoppingListPresented: Bool
    
    init(shoppingList: ShoppingList?, isAddShoppingListPresented: Binding<Bool>) {
        self.shoppingList = shoppingList
        if let shoppingList {
            self.shoppingListName = shoppingList.name
        } else {
            self.shoppingListName = ""
        }
        self._isAddShoppingListPresented = isAddShoppingListPresented
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("List Name")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray)
                TextField("Everyday Essentials", text: $shoppingListName)
                    .focused($focusField, equals: .nameInput)
                    .padding(8)
                    .background {
                        Color(.secondarySystemBackground)
                            .cornerRadius(8)
                    }
            }
            Button {
                didTapAddShoppingList()
            } label: {
                HStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "note.text.badge.plus")
                    Text(buttonText)
                    Spacer()
                }
                .padding(.vertical, 4)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .onAppear {
            focusField = .nameInput
        }
    }
    
    private var buttonText: String {
        if shoppingList != nil {
            return "Update shopping list"
        } else {
            return "Add new shopping list"
        }
    }
    
    private func didTapAddShoppingList() {
        if let shoppingList {
            updateShoppingList(shoppingList)
        } else {
            addShoppingList()
        }
        isAddShoppingListPresented = false
    }
    
    private func updateShoppingList(_ shoppingList: ShoppingList) {
        withAnimation {
            shoppingList.name = shoppingListName
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
    
    private func addShoppingList() {
        withAnimation {
            let _ = ShoppingList.newShoppingList(context: viewContext, name: shoppingListName)
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

struct AddShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingListView(shoppingList: .mock(), isAddShoppingListPresented: .constant(false))
    }
}
