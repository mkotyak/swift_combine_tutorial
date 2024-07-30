// SwiftUI works with ObservableObject Protocol

import Combine

class ViewModel: ObservableObject {
    @Published var userNames = ["Bill", "Susan", "Bob"]
    let userNamesSubject = CurrentValueSubject<[String], Never>(["Bill", "Susan", "Bob"])

    var subscriptions = Set<AnyCancellable>()

    init() {
        $userNames.sink { [unowned self] values in
            print("usernames - last \(self.userNames) -  value received - \(values)")
        }
        .store(in: &subscriptions)

        userNamesSubject.sink { [unowned self] values in
            self.objectWillChange.send()
            print("usernamesSubject - last \(self.userNamesSubject.value) - value received - \(values)")
        }
        .store(in: &subscriptions)
    }
}

let viewModel = ViewModel()

let subscription = viewModel.objectWillChange.sink { _ in
    print("view model will change")
}

viewModel.userNames.append("Karen") // As far as we change @Published property, viewModel.objectWillChange event is sent automatically
viewModel.userNamesSubject.value.append("Karen") // As far as we change CurrentValueSubject, viewModel.objectWillChange event won't sent automatically. To send it, we must call "self.objectWillChange.send()"
