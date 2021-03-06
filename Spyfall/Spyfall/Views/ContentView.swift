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
            
            if gameController.currentGame != nil {
                GameView(gameController: gameController)
                    .padding(.top)
            }
            
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
            
            Button(action: {
                self.isShowingScanner = true
            }) {
                Text("Join game")
            }
            .padding()
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
