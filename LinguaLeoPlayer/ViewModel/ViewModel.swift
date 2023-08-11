import UIKit

protocol ViewModelProtocol {
    func loadPlayers()
    func flagForCountry(_ country: String) -> UIImage?
    func uniqueCountries() -> [String]
    var playersByCountry: [String: [(title: String, score: Int, image: String)]] { get }
    func deletePlayer(_ player: PlayersModel)
}

final class ViewModel: ViewModelProtocol {
    
    static let shared = ViewModel()
    private(set) var playersStorage = [PlayersModel]()
    private(set) var countries: [String] = []
    private var countryFlags: [String: UIImage] = [:]

    func flagForCountry(_ country: String) -> UIImage? {
        return countryFlags[country]
    }

    init() {
        countryFlags["Russia"] = UIImage(named: "rus")
        countryFlags["USA"] = UIImage(named: "usa")
        countryFlags["UK"] = UIImage(named: "uk")
        loadPlayers()
    }

    func loadPlayers() {
        if playersStorage.isEmpty, let path = Bundle.main.path(forResource: "players", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                playersStorage = try decoder.decode([PlayersModel].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }

    func uniqueCountries() -> [String] {
        let countriesSet = Set(playersStorage.map { $0.player.country })
        countries = Array(countriesSet)
        return countries
    }

    var playersByCountry: [String: [(title: String, score: Int, image: String)]] {
        var dictionary: [String: [(title: String, score: Int, image: String)]] = [:]

        for player in playersStorage {
            let country = player.player.country
            let playerData = (title: player.player.name, score: player.playerInfo.score, image: player.player.image)

            if dictionary[country] == nil {
                dictionary[country] = [playerData]
            } else {
                dictionary[country]?.append(playerData)
            }
        }

        for (country, players) in dictionary {
            let sortedPlayers = players.sorted { $0.score > $1.score }
            dictionary[country] = sortedPlayers
        }

        return dictionary
    }

    func deletePlayer(_ player: PlayersModel) {
        if let index = playersStorage.firstIndex(where: { $0.player.name == player.player.name }) {
            playersStorage.remove(at: index)
            savePlayersToFile()
        }
    }

    func savePlayersToFile() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(playersStorage)

            if let path = Bundle.main.path(forResource: "players", ofType: "json") {
                let url = URL(fileURLWithPath: path)
                try data.write(to: url)
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
