import Combine
import Foundation

struct User {
    let name: String
    let id: Int
}

class ViewModel {
    var user = CurrentValueSubject<User, Never>(User(name: "Bob", id: 1))
    var userID: Int = 1 {
        didSet {
            print("userId changed \(userID)")
        }
    }

    var subscriptions = Set<AnyCancellable>()

    init() {
        user
            .map(\.id)
            .sink(receiveValue: { [weak self] newValue in
                self?.userID = newValue
            })
//            .assign(to: \.userID, on: self) - DO NOT USE .assign on self! It will creat a retain cycle.
            .store(in: &subscriptions)
    }

    deinit {
        print("deinit")
    }
}

var viewModel: ViewModel? = ViewModel()
viewModel?.user.send(User(name: "Billi", id: 2))
viewModel = nil
