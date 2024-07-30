import Combine
import Foundation

class TaskListViewModel {
    // replace this with
    // @Published var tasks = ["buy milk"]
    
    let tasks = CurrentValueSubject<[String], Never>(["buy milk"])
    var addNewTask = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        addNewTask
            .sink(receiveValue: { [weak self] newTask in
                guard let self else {
                    return
                }
                
                tasks.value.append(newTask)
            })
            .store(in: &subscriptions)
    }
}
