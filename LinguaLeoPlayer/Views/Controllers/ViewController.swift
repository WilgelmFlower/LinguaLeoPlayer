import UIKit

final class ViewController: UIViewController {

    private let vm = ViewModel.shared

    private let homePlayerTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = UIColor(named: "backgroundColor")
        table.separatorColor = .clear
        table.register(CollectionViewTableCell.self, forCellReuseIdentifier: CollectionViewTableCell.identifier)

        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List of Players"
        view.addSubview(homePlayerTable)
        homePlayerTable.delegate = self
        homePlayerTable.dataSource = self
        configureHeaderView()
    }

    private func configureHeaderView() {
        let headerView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homePlayerTable.tableHeaderView = headerView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homePlayerTable.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homePlayerTable.frame = view.bounds
    }
}

extension ViewController: UITableViewDataSource, CollectionViewCellDelegate {

    func collectionViewCell(_ cell: CollectionViewTableCell, didSelectItemAt indexPath: IndexPath) {
        if let section = homePlayerTable.indexPath(for: cell)?.section {
            let country = vm.countries[section]
            if let countryPlayers = vm.playersByCountry[country], countryPlayers.count > indexPath.row {
                let selectedPlayerTuple = countryPlayers[indexPath.row]

                if let selectedPlayerModel = vm.playersStorage.first(where: { $0.player.name == selectedPlayerTuple.title }) {
                    let playerDetailVC = PlayerDetailViewController()
                    playerDetailVC.playersStorage = selectedPlayerModel
                    playerDetailVC.configure(name: selectedPlayerModel.player.name,
                                             country: selectedPlayerModel.player.country,
                                             age: selectedPlayerModel.player.age,
                                             image: selectedPlayerModel.player.image,
                                             level: selectedPlayerModel.playerInfo.level,
                                             score: selectedPlayerModel.playerInfo.score)
                    navigationController?.pushViewController(playerDetailVC, animated: true)
                }
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        vm.uniqueCountries().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CollectionViewTableCell.identifier,
            for: indexPath) as? CollectionViewTableCell else { return UITableViewCell() }

        cell.delegate = self
        let country = vm.countries[indexPath.section]
        if let countryPlayers = vm.playersByCountry[country] {
            let countryData: [String: [(title: String, score: Int, image: String)]] = [country: countryPlayers]
            cell.configure(with: countryData)
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))

        let flagImageView = UIImageView(frame: CGRect(x: 15, y: 5, width: 30, height: 30))
        if let flagImage = vm.flagForCountry(vm.countries[section]) {
            flagImageView.image = flagImage
        }
        headerView.addSubview(flagImageView)

        let titleLabel = UILabel(frame: CGRect(x: 50, y: 5, width: tableView.frame.size.width - 50, height: 30))
        titleLabel.text = vm.countries[section]
        headerView.addSubview(titleLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
