import SwiftUI

struct SwipeActionsView: View {
    
    var deleteAction: () -> Void
    var editAction: () -> Void
    
    var body: some View {
        Button(role: .destructive, action: deleteAction) {
            Label("Delete", systemImage: "trash.fill")
        }
        Button(action: editAction) {
            Label("Edit", systemImage: "pencil")
        }
        .tint(.accentColor)
    }
}
