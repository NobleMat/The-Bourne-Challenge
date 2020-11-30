import Kingfisher
import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: - Properties

    // MARK: IBOutlets

    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel! {
        didSet {
            movieTitleLabel.font = .semiBoldFont(with: 21)
            movieTitleLabel.addAccessibility(using: .title1)
        }
    }

    @IBOutlet private var movieReleaseDateLabel: UILabel! {
        didSet {
            movieReleaseDateLabel.font = .regularFont(with: 16)
            movieReleaseDateLabel.addAccessibility(using: .body)
        }
    }

    @IBOutlet private var movieRatingLabel: UILabel! {
        didSet {
            movieRatingLabel.font = .lightFont(with: 16)
            movieRatingLabel.addAccessibility(using: .body)
        }
    }

    @IBOutlet private var contentView: UIView!
    @IBOutlet private var imageContainerView: UIView!

    // MARK: Public

    var presenter: MovieDetailPresenting!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(presenter != nil, "MovieDetailPresenter should be present")

        view.backgroundColor = .viewBackground
        contentView.backgroundColor = .cellBackground

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

        presenter.displayDidLoad()
    }
}

// MARK: - Conformance

// MARK: MovieDetailDisplaying

extension MovieDetailViewController: MovieDetailDisplaying {

    func set(title: String) {
        self.title = title
    }

    func set(title: String, releaseDate: String) {
        movieTitleLabel.text = title
        movieReleaseDateLabel.isHidden = false
        movieReleaseDateLabel.text = releaseDate
    }

    func set(rating: String) {
        movieRatingLabel.isHidden = false
        movieRatingLabel.text = rating
    }

    func hideRating() {
        movieRatingLabel.isHidden = true
    }

    func set(imageUrl: URL) {
        imageContainerView.isHidden = false
        movieImageView.kf.setImage(with: imageUrl)
    }

    func hideImage() {
        imageContainerView.isHidden = true
    }

    func set(error: String) {
        movieTitleLabel.text = error
        [
            imageContainerView,
            movieRatingLabel,
            movieReleaseDateLabel,
        ].forEach {
            $0?.isHidden = true
        }
    }
}
