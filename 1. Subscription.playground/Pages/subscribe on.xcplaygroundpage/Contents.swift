// subscribe on
// change the thread upstream to the publisher

import Combine
import Foundation

var cancellables = Set<AnyCancellable>()
let intSubject = PassthroughSubject<Int, Never>()

intSubject
    .subscribe(on: DispatchQueue.global())
    .sink(receiveValue: { value in
        print(value)
        print(Thread.current)
    })
    .store(in: &cancellables)

intSubject.send(1)
intSubject.send(2)
intSubject.send(3)
