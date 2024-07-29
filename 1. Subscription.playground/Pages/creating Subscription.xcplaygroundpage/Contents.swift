// How to create a subscription?
// What does a publisher without a subscription?
// What does data stream mean?

import Combine
import Foundation

var subscription: AnyCancellable? = Timer.publish(every: 0.5, on: .main, in: .common)
    .autoconnect()
    .throttle(for: .seconds(2), scheduler: DispatchQueue.main, latest: true)
    .scan(0) { count, _ in
        count + 1
    }
    .filter { $0 < 6 }
    .sink { completion in
        print("Data stream completion: \(completion)")
    } receiveValue: { timestamp in
        print("Recieved value: \(timestamp)")
    }

DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
//    subscription.cancel()
    subscription = nil
}
