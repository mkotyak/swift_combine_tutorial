/*
 @Published property wrapper
 adds a Publisher to a property
 and was made specifically for swiftUI, but it doesn't mean, that we can't use it in UIKit

 use `@Published` for class propeties not structures.
 */

import Combine

class ViewModel {
    /// When the @Published property changes, publishing occurs in the property's `willSet` block, meaning subscribers receive the new value before it's actually set on the property.
    @Published var userNames: [String] = ["Bill"]
//    let userNames = CurrentValueSubject<[String], Never>(["Bill"])

    let newUserNameEntered = PassthroughSubject<String, Never>()

    var subscriptions = Set<AnyCancellable>()

    init() {
        $userNames.sink {
            print("Recieved values: \($0)")
        }.store(in: &subscriptions)

        newUserNameEntered.sink { [weak self] in
            self?.userNames.append($0)
        }.store(in: &subscriptions)
    }
}

let viewModel = ViewModel()

// get userNames
viewModel.userNames

// add new user name "Susan"
viewModel.newUserNameEntered.send("Susan")

// add new user name "Bob"
viewModel.newUserNameEntered.send("Bob")

// who do you protect userName from not setting it directly
// viewModel.$userNames.send("New user from outside") // you can't update if from outside
