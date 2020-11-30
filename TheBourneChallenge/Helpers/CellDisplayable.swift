import UIKit

/// This protocol is used to easily display a tableView cell
protocol CellDisplayable {

    var action: ButtonAction? { get }

    /// This function extracts the cell. And sets the required viewmodel to it.
    /// - Parameters:
    ///   - tableView: The tableView that the cell is used in.
    ///   - indexPath: The indexPath of the cell
    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}

extension CellDisplayable {

    var action: ButtonAction? {
        return nil
    }
}

/// This protocol is used to easily display header/footer views inside a tableView
protocol HeaderFooterDisplayable {

    /// This function extracts the view and sets the required viewmodel to it
    /// - Parameter tableView: The tableView that uses this view as a header/footer
    func extractView(from tableView: UITableView) -> UIView?
}
