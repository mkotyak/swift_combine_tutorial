// Example for CurrentValueSubject and PassthroughSubject
// PassthroughSubject: use for starting action/process, equivalent to func

import Combine

class ViewModel {
    private let userNamesSubject = CurrentValueSubject<[String], Never>(["Bill"])

    var userNames: AnyPublisher<[String], Never>
    let newUserNameEntered = PassthroughSubject<String, Never>()

    var subscriptions = Set<AnyCancellable>()

    init() {
        userNames = userNamesSubject.eraseToAnyPublisher()

        // Subscribe to newUserNameEntered
        newUserNameEntered
            .sink {
                print("Completion: \($0)")
            } receiveValue: { [weak self] newUsername in
                self?.userNamesSubject.value.append(newUsername)
            }
            .store(in: &subscriptions)

        // Subscribe to userNamesSubject
        userNamesSubject.sink { users in
            print("userNames changed to: \(users)")
        }
        .store(in: &subscriptions)
    }
}

let viewModel = ViewModel()

// add new user name "Susan"
viewModel.newUserNameEntered.send("Susan")

// add new user name "Bob"
viewModel.newUserNameEntered.send("Bob")

// who do you protect userName from not setting it directly
print("Outside: \(viewModel.userNames)") // it is read only, I can't use value
