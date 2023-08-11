import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func collectionViewCell(_ cell: CollectionViewTableCell, didSelectItemAt indexPath: IndexPath)
}

final class CollectionViewTableCell: UITableViewCell {

    static let identifier = String(describing: CollectionViewTableCell.self)
    private var countriesData: [String: [(title: String, score: Int, image: String)]] = [:]
    weak var delegate: CollectionViewCellDelegate?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 200)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        collectionView.register(CollectionViewPlayerCell.self
                                , forCellWithReuseIdentifier: CollectionViewPlayerCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with data: [String: [(title: String, score: Int, image: String)]]) {
        countriesData = data
        collectionView.reloadData()
    }
}

extension CollectionViewTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewPlayerCell.identifier,
            for: indexPath) as? CollectionViewPlayerCell else { return UICollectionViewCell() }

        let country = Array(countriesData.keys)[indexPath.section]
        if let countryPlayers = countriesData[country] {
            let playerData = countryPlayers[indexPath.item]
            cell.configure(with: playerData.title, score: playerData.score, image: playerData.image)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let country = Array(countriesData.keys)[section]
        return countriesData[country]?.count ?? 0
    }
}

extension CollectionViewTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewCell(self, didSelectItemAt: indexPath)
    }
}
