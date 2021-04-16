import Foundation

struct ContactModel {
    static let data: [ContactModel] = [
        ContactModel(name: "Allen", email: "allen@example.com", phoneNumber: "0912333444"),
        ContactModel(name: "Bob", email: "bob@gmail.com", phoneNumber: "0977888999"),
        ContactModel(name: "Charlie", email: "charlie@yahoo.com", phoneNumber: "0987654321")
    ]

    var name: String
    var email: String
    var phoneNumber: String
    private(set) var uuid: UUID = UUID()
}

extension ContactModel: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
