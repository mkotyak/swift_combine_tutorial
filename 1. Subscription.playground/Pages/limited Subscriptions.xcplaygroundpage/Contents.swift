// publishers that will pass a limited number of values

import Combine
import UIKit

enum MyError: Error {
    case outOfDate
}

let foodbank: Publishers.Sequence<[String], Never> = [
    "apple",
    "bread",
    "orange",
    "milk"
].publisher

var timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()

let calendare = Calendar.current
let endDate = calendare.date(byAdding: .second, value: 3, to: Date())

let subscription = foodbank.zip(timer)
    .tryMap { foodItem, timestamp in
        try throwAtEndDate(foodItem: foodItem, date: timestamp)
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished")
        case .failure(let error):
            print("Completed with error: \(error.localizedDescription)")
        }

    } receiveValue: { result in
        print("Recieved item: \(result)")
    }

func throwAtEndDate(foodItem: String, date: Date) throws -> String {
    guard let endDate,
          date < endDate
    else {
        throw MyError.outOfDate
    }

    return "\(foodItem) at \(date)"
}
