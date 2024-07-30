import SwiftUI

struct TodoListView: View {
    @ObservedObject var taskViewModel: TaskListViewModel
    @State var showAddTaskView: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            titleView
            tasksListView
            addNewButton
        }
        .sheet(isPresented: $showAddTaskView) {
            AddTaskView(taskViewModel: taskViewModel)
        }
    }

    private var titleView: some View {
        Text("Tasks")
            .font(.title)
            .padding()
    }

    private var tasksListView: some View {
        List {
            ForEach(taskViewModel.tasks, id: \.self) { task in
//            ForEach(taskViewModel.tasks.value, id: \.self) { task in
                Text(task)
            }
        }
        .listStyle(.plain)
    }

    private var addNewButton: some View {
        Button {
            showAddTaskView = true
        } label: {
            Text("Add New")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
