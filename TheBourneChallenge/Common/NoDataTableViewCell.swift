import UIKit

final class NoDataTableViewCell: UITableViewCell, Reusable {

    @IBOutlet private var noDataTextLabel: UILabel! {
        didSet {
            noDataTextLabel.font = .semiBoldFont(with: 16)
            noDataTextLabel.addAccessibility(using: .body)
        }
    }

    func configure(with item: NoDataItem) {
        contentView.backgroundColor = .cellBackground
        noDataTextLabel.text = item.text
    }
}

struct NoDataItem: CellDisplayable {

    let text: String

    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell: NoDataTableViewCell = tableView.dequeReusable(at: indexPath)
        cell.configure(with: self)
        return cell
    }
}
