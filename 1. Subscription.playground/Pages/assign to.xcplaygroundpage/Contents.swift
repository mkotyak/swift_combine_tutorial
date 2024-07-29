/*
 assign(to published: inout Published<Output>.Publisher)

  - available: iOS 14+, macOS 11+ tvOS 14+ and watchOS 7+

 Apple documentation:
 The assign(to:) operator manages the life cycle of the subscription, canceling the subscription automatically when the Published instance deinitializes. Because of this, the assign(to:) operator doesn’t return an AnyCancellable that you’re responsible for like assign(to:on:) does.

 */

import Combine
import Foundation
import PlaygroundSupport

class MyViewModel: ObservableObject {
    @Published var lastUpdated: Date = .init()

    init() {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .assign(to: &$lastUpdated)
    }
}

import SwiftUI

struct ClockView: View {
    @StateObject private var clockViewModel = MyViewModel()

    var body: some View {
        Text("\(dateFormatter.string(from: clockViewModel.lastUpdated))")
            .font(.largeTitle)
            .fixedSize()
            .padding(50)
    }

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        return dateFormatter
    }
}

PlaygroundPage.current.setLiveView(ClockView())
