import Combine
import Foundation

class TaskListViewModel: ObservableObject {
    @Published var tasks: [String] = ["buy milk"]
//    let tasks = CurrentValueSubject<[String], Never>(["buy milk"])
    var addNewTask = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        addNewTask
            .sink(receiveValue: { [weak self] newTask in
                guard let self else {
                    return
                }
                
                tasks.append(newTask)
//                tasks.value.append(newTask)
            })
            .store(in: &subscriptions)
        
//        tasks.sink { [weak self] values in
//            print("Tasks were updated to \(values)")
//            self?.objectWillChange.send()
//        }
//        .store(in: &subscriptions)
    }
}
