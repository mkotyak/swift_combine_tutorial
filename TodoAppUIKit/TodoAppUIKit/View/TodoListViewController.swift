import Combine
import UIKit

class TodoListViewController: UIViewController {
    let taskViewModel: TaskListViewModel = .init()
    var subscriptions = Set<AnyCancellable>()

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        taskViewModel.tasks.sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &subscriptions)
    }

    @IBSegueAction func addNewViewIsGoingToAppear(_ coder: NSCoder) -> AddNewViewController? {
        let controller = AddNewViewController(coder: coder)
        controller?.taskViewModel = taskViewModel
        return controller
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return taskViewModel.tasks.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = taskViewModel.tasks.value[indexPath.row]

        return cell
    }
}
