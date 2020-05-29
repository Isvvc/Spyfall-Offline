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
        "Bank",
        "Pirate Ship",
        "Supermarket"
    ]
    
    @Published var currentGame: Game?
    
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
