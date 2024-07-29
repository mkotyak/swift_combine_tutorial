// multithreading
// where and how to change threads?

import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let intSubject = PassthroughSubject<Int, Never>()

let subscription = intSubject
    .receive(on: DispatchQueue.main)
    .sink(receiveValue: { value in
        print("receive value \(value)")
        print(Thread.current)
    })

intSubject.send(1)

DispatchQueue.global().async {
    intSubject.send(2)
}
