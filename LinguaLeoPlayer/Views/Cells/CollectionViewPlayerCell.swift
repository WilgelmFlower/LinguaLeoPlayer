import UIKit

final class CollectionViewPlayerCell: UICollectionViewCell {

    static let identifier = String(describing: CollectionViewPlayerCell.self)

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 16

        return image
    }()

    private var titleName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left

        return label
    }()

    private var scoreTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with name: String, score: Int, image: String) {
        titleName.text = "Name - \(name)"
        scoreTitle.text = "Score - \(String(score))"
        imageView.image = UIImage(named: image)
    }

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleName.translatesAutoresizingMaskIntoConstraints = false
        scoreTitle.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)
        contentView.addSubview(titleName)
        contentView.addSubview(scoreTitle)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),

            titleName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            titleName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            scoreTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            scoreTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scoreTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scoreTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
