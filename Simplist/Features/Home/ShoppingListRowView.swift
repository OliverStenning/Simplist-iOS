import SwiftUI

struct ShoppingListRowView: View {
    
    let shoppingList: ShoppingList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(shoppingList.name)
                .font(.system(size: 18))
            HStack(spacing: 6) {
                HStack(spacing: 6) {
                    Image(systemName: "cart")
                    Text("32 Items")
                }
                Text("•")
                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                    Text("3 weeks ago")
                }
            }
            .foregroundColor(.gray)
            .font(.system(size: 12))
        }
        .padding(.vertical, 4)
    }
}

struct ShoppingListRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ShoppingListRowView(shoppingList: .mock())
        }
    }
}
