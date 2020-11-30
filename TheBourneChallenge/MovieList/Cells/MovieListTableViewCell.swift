import Kingfisher
import UIKit

final class MovieListTableViewCell: UITableViewCell, Reusable {

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .regularFont(with: 16)
            titleLabel.addAccessibility(using: .body)
        }
    }

    @IBOutlet private var movieImageView: UIImageView!

    func configure(with item: MovieListItem) {
        contentView.backgroundColor = .viewBackground
        titleLabel.text = item.name

        accessoryType = .disclosureIndicator

        guard let imageUrl = item.imageUrl, let url = URL(string: imageUrl) else { return }
        movieImageView.kf.setImage(with: url)
    }
}

struct MovieListItem: CellDisplayable {

    let name: String
    let imageUrl: String?
    let action: ButtonAction?

    init(movie: Movie, action: ButtonAction? = nil) {
        name = movie.title
        imageUrl = movie.imageHref
        self.action = action
    }

    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListTableViewCell = tableView.dequeReusable(at: indexPath)
        cell.configure(with: self)
        return cell
    }
}
