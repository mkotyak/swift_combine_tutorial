import SwiftUI

@main
struct TodoAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView(taskViewModel: .init())
        }
    }
}
