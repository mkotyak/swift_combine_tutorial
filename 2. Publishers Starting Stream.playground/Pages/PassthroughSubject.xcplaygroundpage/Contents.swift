// Subject - Publisher that you can continously send new values down

// PassthroughSubject
// use for starting action/process, equivalent to func

import Combine

let newUserNameEntered = PassthroughSubject<String, Never>()

// get the value for newUserNameEntered
// newUserNameEntered.value // Does not have a value

// subscribe to Subject
let subscription = newUserNameEntered.sink {
    print("Completion: \($0)")
} receiveValue: { newValue in
    print("Recieved value: \(newValue)")
}

// passing down new values with Subject
newUserNameEntered.send("Bob")
newUserNameEntered.send("Max")

// sending completion finished with Subject
newUserNameEntered.send(completion: .finished)
