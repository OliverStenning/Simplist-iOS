import SwiftUI

struct AddListRowView: View {
    
    let name: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "plus")
            Text("Add \(name)")
            Spacer()
        }
        .contentShape(Rectangle())
        .foregroundColor(.accentColor)
        .onTapGesture(perform: action)
    }
}

struct AddListRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AddListRowView(name: "shopping list", action: {})
        }
    }
}
