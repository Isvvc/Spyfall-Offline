//
//  ContentView.swift
//  Spyfall
//
//  Created by Isaac Lyons on 5/29/20.
//  Copyright © 2020 Isaac Lyons. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    var gameController = GameController()
    
    @State private var numPlayers: Int = 4
    
    var body: some View {
        VStack {
            Text("Spyfall").font(.largeTitle)
                .padding()
            Spacer()
            HStack {
                Stepper("Number of players", value: $numPlayers, in: 1...100)
                Text("\(numPlayers)")
            }
                .padding(.leading)
                .padding(.trailing)
            Button(action: {
                self.gameController.createGame(players: self.numPlayers)
            }) {
                Text("Create Game")
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
