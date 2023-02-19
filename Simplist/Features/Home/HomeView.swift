import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                ShoppingListSectionView()
            }
            .navigationTitle("Simplist")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case let .shoppingList(shoppingList):
                    ShoppingListView(shoppingList: shoppingList)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
