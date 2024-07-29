import Combine
import UIKit

var subscription: Cancellable? = Timer.publish(every: 0.1, on: .main, in: .common)
    .autoconnect()
    .print("--- stream ---") // Just print out stream related information
    .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
    .scan(0) { count, _ in
        count + 1
    }
    .filter { $0 > 5 && $0 < 15 }
    .sink { output in
        print("Finished stream with \(output)")
    } receiveValue: { value in
        print("Recieved value: \(value)")
    }

DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
    print("--- cancel subscription ---")
    // subscription?.cancel() // - The 1st way to cancel subscription
    subscription = nil //  - The 2nd way to cancel subscription
}
