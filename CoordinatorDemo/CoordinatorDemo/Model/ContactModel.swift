import Foundation

struct ContactModel {
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
