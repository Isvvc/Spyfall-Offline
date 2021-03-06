//
//  GameController.swift
//  Spyfall
//
//  Created by Isaac Lyons on 5/29/20.
//  Copyright © 2020 Isaac Lyons. All rights reserved.
//

import Foundation
import SwiftyJSON

class GameController: ObservableObject {
    var locations: [String] = [
        "Airplane",
        "Bank",
        "Beach",
        "Broadway Theater",
        "Casino",
        "Cathedral",
        "Circus Tent",
        "Corporate Party",
        "Crusader Army",
        "Day Spa",
        "Embassy",
        "Hospital",
        "Hotel",
        "Military Base",
        "Movie Studio",
        "Ocean Liner",
        "Passenger Train",
        "Pirate Ship",
        "Polar Station",
        "Police Station",
        "Restaurant",
        "Service Station",
        "Space Station",
        "Submarine",
        "Supermarket",
        "University"
    ]
    
    @Published var currentGame: Game?
    
    var currentLocation: String? {
        guard let currentGame = currentGame else { return nil }
        if currentGame.player == currentGame.spy {
            return "Spy"
        } else {
            return locations[currentGame.location]
        }
    }
    
    func createGame(players: Int) {
        let location = Int.random(in: 0..<locations.count)
        let spy = Int.random(in: 0..<players)
        
        let game = Game(location: location, player: 0, spy: spy)
        currentGame = game
    }
    
    func joinGame(_ string: String) {
        let json = JSON(parseJSON: string)
        currentGame = Game(json: json)
    }
}
