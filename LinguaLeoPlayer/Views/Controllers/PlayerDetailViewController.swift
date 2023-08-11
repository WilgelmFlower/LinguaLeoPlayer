import UIKit

final class PlayerDetailViewController: UIViewController {

    private let vm = ViewModel.shared
    var playersStorage: PlayersModel?

    private let topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical

        return stack
    }()

    private let titleName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left

        return label
    }()

    private let titleCountry: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left
        
        return label
    }()

    private let titleAge: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left

        return label
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 16

        return image
    }()

    private let botStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical

        return stack
    }()

    private let titleLevel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left

        return label
    }()

    private let titleScore: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left

        return label
    }()

    private let deleteUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete User!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail info about Player"
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupLayout()
        deleteUserButton.addTarget(self, action: #selector(deleteUserButtonTapped), for: .touchUpInside)
    }

    @objc
    private func deleteUserButtonTapped() {
        if let selectedPlayer = playersStorage {
            let alert = UIAlertController(
                title: "Delete User",
                message: "Are you sure you want to delete this user?",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.vm.deletePlayer(selectedPlayer)
                self.navigationController?.popViewController(animated: true)
            })

            present(alert, animated: true, completion: nil)
        }
    }

    private func setupLayout() {
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        titleName.translatesAutoresizingMaskIntoConstraints = false
        titleCountry.translatesAutoresizingMaskIntoConstraints = false
        titleAge.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        botStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLevel.translatesAutoresizingMaskIntoConstraints = false
        titleScore.translatesAutoresizingMaskIntoConstraints = false
        deleteUserButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(topStackView)
        topStackView.addArrangedSubview(titleName)
        topStackView.addArrangedSubview(titleCountry)
        topStackView.addArrangedSubview(titleAge)
        view.addSubview(imageView)
        view.addSubview(botStackView)
        botStackView.addArrangedSubview(titleLevel)
        botStackView.addArrangedSubview(titleScore)
        view.addSubview(deleteUserButton)

        NSLayoutConstraint.activate([
            topStackView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            topStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),

            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.widthAnchor.constraint(equalToConstant: 350),

            botStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            botStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),

            deleteUserButton.topAnchor.constraint(equalTo: botStackView.bottomAnchor, constant: 50),
            deleteUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    func configure(name: String, country: String, age: Int, image: String, level: Int, score: Int) {
        self.titleName.text = "Name - \(name)"
        self.titleCountry.text = "Country - \(country)"
        self.titleAge.text = "Age - \(String(age))"
        self.imageView.image = UIImage(named: image)
        self.titleLevel.text = "Level - \(level)"
        self.titleScore.text = "Score - \(score)"
    }
}
