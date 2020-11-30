import UIKit

/// Protocol to automatically give an identifier to views
protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {

    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {

    typealias ReusableXIB = Reusable & XIBLodable

    /// Helper method to easily register cells using their identifier
    /// - Parameter cells: The cells to register
    func registerReusable(_ cells: [ReusableXIB.Type]) {
        cells.forEach { registerReusable($0) }
    }

    func registerReusable(_ cell: ReusableXIB.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }

    /// Helper method to easily register views using their identifier
    /// - Parameter headerFooterViews: The views to register
    func registerReusableHeaderFooter(_ headerFooterViews: [ReusableXIB.Type]) {
        headerFooterViews.forEach { registerReusableHeaderFooter($0) }
    }

    func registerReusableHeaderFooter(_ headerFooterView: ReusableXIB.Type) {
        register(headerFooterView.nib, forHeaderFooterViewReuseIdentifier: headerFooterView.identifier)
    }
}

extension UITableView {

    /// Generic method used to dequeque cells in tableView
    /// - Parameter indexPath: The indexPath of the cell
    /// - Returns: A type infered cell
    func dequeReusable<T: Reusable>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    /// Generic method to dequeue views as header/footer views in tableView
    /// - Returns: A type infered view
    func dequeReusableHeaderFooter<T: Reusable>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
}
