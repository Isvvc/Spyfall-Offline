//
//  GameView.swift
//  Spyfall
//
//  Created by Isaac Lyons on 5/29/20.
//  Copyright © 2020 Isaac Lyons. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameController: GameController
    
    @State private var display = 1
    
    var body: some View {
        VStack {
            Text("Player: \(gameController.currentGame!.player + 1)")
            
            Picker(selection: $display, label: Text("Display")) {
                Text("Hide").tag(0)
                Text("QR Code").tag(1)
                Text("Location").tag(2)
                Text("All Locations").tag(3)
            }.pickerStyle(SegmentedPickerStyle())
            
            if display == 1 && gameController.currentGame?.qrCode != nil {
                Image(decorative: gameController.currentGame!.qrCode!, scale: 1).resizable().scaledToFit()
            } else if display == 2 && gameController.currentLocation != nil {
                Spacer()
                Text(gameController.currentLocation!)
                Spacer()
            } else if display == 3 {
                ScrollView {
                    VStack {
                        ForEach(gameController.locations, id: \.self) { location in
                            Text(location)
                        }
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let gameController = GameController()
        gameController.createGame(players: 2)
        return GameView(gameController: gameController)
    }
}
