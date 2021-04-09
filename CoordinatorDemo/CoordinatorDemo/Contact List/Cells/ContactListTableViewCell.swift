import UIKit

final class ContactListTableViewCell: BaseTableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var phoneNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func render(with contact: ContactModel) {
        nameLabel.text = contact.name
        emailLabel.text = contact.email
        phoneNumberLabel.text = contact.phoneNumber
    }
}
