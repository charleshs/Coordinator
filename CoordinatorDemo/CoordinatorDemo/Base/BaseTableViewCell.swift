import UIKit

class BaseTableViewCell: UITableViewCell {
    private static var typeName: String {
        return String(describing: Self.self)
    }

    static func registerNib(in tableView: UITableView) {
        tableView.register(UINib(nibName: typeName, bundle: nil), forCellReuseIdentifier: typeName)
    }

    static func dequeued(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: typeName, for: indexPath) as! Self
    }
}
