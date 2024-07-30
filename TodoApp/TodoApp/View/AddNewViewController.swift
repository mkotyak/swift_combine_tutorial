import Combine
import UIKit

class AddNewViewController: UIViewController {
    var taskViewModel: TaskListViewModel?
    
    var text: String = ""
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.addTarget(
            self,
            action: #selector(updateText),
            for: .editingChanged
        )
    }
    
    @objc func updateText() {
        text = textField.text ?? ""
    }
    
    // MARK: - outlets
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        taskViewModel?.addNewTask.send(text)
        dismiss()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss()
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
