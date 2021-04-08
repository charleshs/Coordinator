import Coordinator
import UIKit

final class ContactListViewController: BaseViewController, Storyboarded {
    @Published private(set) var didTapAddBarButton: Void?

    @IBOutlet private var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAddItem()
    }

    private func setupNavigationAddItem() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddBarButton))
        navigationItem.rightBarButtonItems = [addBarButton]
    }

    @objc private func tapAddBarButton() {
        print("Pressed add bar button.")
        didTapAddBarButton = ()
    }
}
