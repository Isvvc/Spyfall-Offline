//
//  ContentView.swift
//  Spyfall
//
//  Created by Isaac Lyons on 5/29/20.
//  Copyright © 2020 Isaac Lyons. All rights reserved.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @ObservedObject private var gameController = GameController()
    
    @State private var numPlayers: Int = 4
    @State private var isShowingScanner = false
    @State private var isShowingLocation = false
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            gameController.joinGame(code)
        case .failure(_):
            print("Scanning failed")
        }
    }
    
    var body: some View {
        VStack {
            Text("Spyfall").font(.largeTitle)
                .padding()
            
            Spacer()
            
            if gameController.currentGame != nil {
                Text("Player: \(gameController.currentGame!.player + 1)")
                
                Button("\(isShowingLocation ? "Hide" : "Show") role/location") {
                    self.isShowingLocation.toggle()
                }.padding(.top)
                
                if isShowingLocation {
                    Text(gameController.currentLocation!)
                }
                
                Image(decorative: gameController.currentGame!.qrCode!, scale: 1).resizable().scaledToFit()
                Spacer()
            }
            
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
            
            Button(action: {
                self.isShowingLocation = false
                self.isShowingScanner = true
            }) {
                Text("Join game")
            }
            .padding(.top)
            
            Spacer()
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
