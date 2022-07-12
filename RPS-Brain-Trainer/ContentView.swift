//
//  ContentView.swift
//  RPS-Brain-Trainer
//  Rock Paper Scissor Game Brain Trainer
//
//  Created by Andrew A. Schilt on 7/10/22.
//

import SwiftUI

struct ContentView: View {
    let moveArray = ["🪨", "📜", "✂️"]
    @State private var appsMove = Int.random(in: 0...2)
    @State private var myMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var moves = 0
    @State private var resultTitle = "Wrong!"
    @State private var showingResult = false
    @State private var showingGameOver = false
    
    var body: some View {
        VStack {
            Text("Rock Paper Scissors Training")
                .padding()
            Text("\(score)/\(moves) Score")
                .padding()
            Text("If I play:")
            Text("\(moveArray[appsMove])")
                .font(.system(size: 100))
            if shouldWin {
                Text("You should play this to Win:" )
            } else {
                Text("You should play this to Lose:")
            }
           
            HStack {
                Button {
                       Move(0)
                    } label: {
                        Text("🪨")
                }
                Button {
                       Move(1)
                    } label: {
                        Text("📜")
                }
                Button {
                       Move(2)
                    } label: {
                        Text("✂️")
                }
            }
            .font(.system(size: 75))
            .padding()
            .alert(resultTitle, isPresented: $showingResult) {
                Button() {
                    if moves >= 10 {
                        showingGameOver = true
                    }
                } label: { Text("Continue?")}
            }

        }
        .padding()
        .alert("Game Over", isPresented: $showingGameOver) {
            Button() {
                score = 0
                moves = 0
                shouldWin.toggle()
                appsMove = Int.random(in: 0...2)
            } label: {
                Text("Would you like to play again?")
            }
        }
    }
    
    func Move(_ move: Int) {
        myMove = move
        resultTitle = "Wrong!"
        if shouldWin {
            if WinningMove() {
                score += 1
                resultTitle = "Correct!"
            }
        } else {
            if !WinningMove() && (myMove != appsMove) {
                score += 1
                resultTitle = "Correct!"
            }
        }
        if resultTitle == "Wrong!" {
            score -= 1
        }
        
    
        let lastAppsMove = appsMove
        repeat {
            appsMove = Int.random(in: 0...2)
        } while appsMove == lastAppsMove
                    
        shouldWin.toggle()
        showingResult = true
        
        moves += 1
    }
    
    func WinningMove() -> Bool {
        switch appsMove {
            case 0: return myMove == 1
            case 1: return myMove == 2
            case 2: return myMove == 0
            default: return false
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
