import Combine
import PlaygroundSupport
import UIKit

class TextFieldViewController: UIViewController, UITextFieldDelegate {
    private var label: UILabel = .init()
    private var textField: UITextField!

    private var textMessage = CurrentValueSubject<String, Never>("Hello World")

    private var subsrciptions = Set<AnyCancellable>()

    override func loadView() {
        // setup UI with textField and label
        let view = UIView()
        view.backgroundColor = .white

        textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = textMessage.value
        view.addSubview(textField)

        label = UILabel()
        view.addSubview(label)

        textMessage
            .compactMap { $0 }
            .assign(to: \.text, on: label) // It is also possible to use .sink instead of .assign
            .store(in: &subsrciptions)

        self.view = view

        // set Autolayout constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
        ])

        // update label whenever textValue changes
        textField.addTarget(self, action: #selector(updateText), for: .editingChanged)
    }

    @objc func updateText() {
        textMessage.value = textField.text ?? ""
    }
}

let controller = TextFieldViewController()
// controller.textMessage.send("next big thing")

PlaygroundPage.current.liveView = controller
