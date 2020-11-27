import UIKit

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

    func registerReusable(_ cells: [ReusableXIB.Type]) {
        cells.forEach { registerReusable($0) }
    }

    func registerReusable(_ cell: ReusableXIB.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }

    func registerReusableHeaderFooter(_ headerFooterViews: [ReusableXIB.Type]) {
        headerFooterViews.forEach { registerReusableHeaderFooter($0) }
    }

    func registerReusableHeaderFooter(_ headerFooterView: ReusableXIB.Type) {
        register(headerFooterView.nib, forHeaderFooterViewReuseIdentifier: headerFooterView.identifier)
    }
}

extension UITableView {

    func dequeReusable<T: Reusable>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    func dequeReusableHeaderFooter<T: Reusable>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
}
