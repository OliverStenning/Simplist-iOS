import SwiftUI

struct ShoppingListView: View {
    
    let shoppingList: ShoppingList
    
    var body: some View {
        Text(shoppingList.name)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView(shoppingList: .mock())
    }
}
