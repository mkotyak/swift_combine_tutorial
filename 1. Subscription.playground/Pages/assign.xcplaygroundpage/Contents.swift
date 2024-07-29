// assign(to:, on:)

// func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable
// ReferenceWritableKeyPath only avaliable for property in class

// enables you to assign the received value to a KVO-compliant property of an object
// upstream publisher's Failure must be Never.

import Combine
import Foundation
import PlaygroundSupport
import UIKit

class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("anInt was set to: \(anInt)")
        }
    }
}

var myObject = MyClass()
let myRange = (0 ... 2)
let pub = myRange.publisher
    .map { $0 * 10 }
//    .sink { value in
//        myObject.anInt = value
//    }
    .assign(to: \.anInt, on: myObject)
