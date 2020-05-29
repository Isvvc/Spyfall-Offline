//
//  Game.swift
//  Spyfall
//
//  Created by Isaac Lyons on 5/29/20.
//  Copyright © 2020 Isaac Lyons. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Game {
    var location: Int
    var player: Int
    var spy: Int
    
    var jsonRepresentation: JSON {
        JSON([
            "location": location,
            "player": player,
            "spy": spy
        ])
    }
}

// Putting the JSON init in an extension preserves the default initializer
extension Game {
    init?(json: JSON) {
        guard let location = json["location"].int,
            let player = json["player"].int,
            let spy = json["spy"].int else { return nil }
        
        self.location = location
        // The given JSON should be for the previous player's game
        self.player = player + 1
        self.spy = spy
    }
}
