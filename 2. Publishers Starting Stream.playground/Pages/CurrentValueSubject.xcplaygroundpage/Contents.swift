// Subject - Publisher that you can continously send new values down

// CurrentValueSubject
// used like a var with a Publisher stream attached

import Combine

struct User {
    var id: Int
    var name: String
}

let currentUser = CurrentValueSubject<User, Never>(User(id: 1, name: "Bob"))
let currentUserId = CurrentValueSubject<Int, Never>(1)
let userNames = CurrentValueSubject<[String], Never>(["Bob", "Susan", "Luise"])

// Get the value for currentUserID
print("currentUserId: \(currentUserId.value)")

// Subscribe to currentUserId Subject
let subscription = currentUserId.sink {
    print("Completion: \($0)")
} receiveValue: { newValue in
    print("Recieved value: \(newValue)")
}

// Passing down new values to currentUserId Subject
currentUserId.send(2)
currentUserId.send(3)

// Sending completion finished to currentUserId Subject
currentUserId.send(completion: .finished)
