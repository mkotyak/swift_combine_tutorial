import SwiftUI

struct AddTaskView: View {
    @ObservedObject var taskViewModel: TaskListViewModel
    @Environment(\.presentationMode) var presentation
    @State var text: String = ""

    var body: some View {
        VStack(spacing: 20) {
            titleView
            textFieldView
           
            HStack(spacing: 50) {
                cancelButton
                doneButton
            }
        }
        .padding(30)
    }
    
    private var titleView: some View {
        Text("Add New Task")
            .font(.title)
    }
    
    private var textFieldView: some View {
        TextField("", text: $text)
            .textFieldStyle(.roundedBorder)
    }
    
    private var cancelButton: some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
        .foregroundStyle(.pink)
    }
    
    private var doneButton: some View {
        Button {
            taskViewModel.addNewTask.send(text)
            presentation.wrappedValue.dismiss()
        } label: {
            Text("Done")
        }
    }
}
