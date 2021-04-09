import Combine
import Foundation

protocol ContactRepository {
    var contactsPublisher: AnyPublisher<[ContactModel], Never> { get }
}

protocol ContactOperation {
    func update(contact: ContactModel)
}

final class ContactManager: ContactRepository, ContactOperation {
    lazy var contactsPublisher: AnyPublisher<[ContactModel], Never> = {
        return $contacts.eraseToAnyPublisher()
    }()

    @Published private var contacts: [ContactModel] = []

    func update(contact: ContactModel) {
        if let index = contacts.firstIndex(of: contact) {
            contacts[index] = contact
        } else {
            contacts.append(contact)
        }
    }
}
