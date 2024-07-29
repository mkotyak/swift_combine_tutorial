import Combine
import Foundation

let subscription = URLSession.shared.dataTaskPublisher(
    for: URL(string: "https://jsonplaceholder.typicode.com")!
)
.map { _ in
    print(Thread.current.isMainThread)
}
.receive(on: DispatchQueue.main)
.sink(receiveCompletion: { _ in }, receiveValue: { _ in
    print(Thread.current.isMainThread)
})
