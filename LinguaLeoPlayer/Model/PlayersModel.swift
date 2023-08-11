import Foundation

struct PlayersModel: Codable {

    let player: PlayerClass
    let playerInfo: PlayerInfo

    enum CodingKeys: String, CodingKey {
        case player
        case playerInfo = "player_info"
    }
}

extension PlayersModel {

    struct PlayerClass: Codable {
        let name, country, image: String
        let age: Int
    }

    struct PlayerInfo: Codable {
        let level, score: Int
    }
}
