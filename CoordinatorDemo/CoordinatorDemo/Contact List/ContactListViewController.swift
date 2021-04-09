import Combine
import Coordinator
import UIKit

final class ContactListViewController: BaseViewController, Storyboarded {
    @Published private(set) var didTapAddBarButton: Void?

    @IBOutlet private var listTableView: UITableView!

    private let contactRepository: ContactRepository
    private let contactOperation: ContactOperation

    private var contacts: [ContactModel] = []

    private var disposable: Set<AnyCancellable> = []

    init?(coder: NSCoder, contactRepository: ContactRepository, contactOperation: ContactOperation) {
        self.contactRepository = contactRepository
        self.contactOperation = contactOperation
        super.init(coder: coder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAddItem()
        setup()
        subscribe()
    }

    func update(contact: ContactModel) {
        contactOperation.update(contact: contact)
    }

    private func setup() {
        listTableView.delegate = self
        listTableView.dataSource = self
        ContactListTableViewCell.registerNib(in: listTableView)
    }

    private func subscribe() {
        contactRepository.contactsPublisher
            .handleEvents(receiveOutput: { [weak self] contacts in
                self?.contacts = contacts
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.listTableView.reloadData() }
            .store(in: &disposable)
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

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactListTableViewCell.dequeued(from: tableView, for: indexPath)
        cell.render(with: contacts[indexPath.row])
        return cell
    }
}
