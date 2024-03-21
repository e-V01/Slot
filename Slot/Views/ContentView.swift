//
//  ContentView.swift
//  Slot
//
//  Created by Y K on 20.03.2024.
//

import SwiftUI

struct ContentView: View {
    
let symbols = ["gfx-bell",
               "gfx-cherry",
               "gfx-coin",
               "gfx-grape",
               "gfx-seven",
               "gfx-strawberry"
]
    @State private var highScore: Int = 0
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false

    //MARK: - FUNC
    // spin reels
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }
    // check winning
    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            // player wins
            playerWins()
            // new high score
            if coins > highScore {
                newHighScore()
            }
        } else {
            // player loses
            playerLoses()
        }
    }
    
    func playerWins() {
        coins += betAmount * 10
    }
    
    func newHighScore() {
        highScore = coins
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    
    func activateBet10() {
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
    }
    
    // game over
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            // MARK: - INTERFACE
            VStack(alignment: .center, spacing: 5) {
                
                
                // MARK: - HEADER
                LogoView()
                
                Spacer()
                // MARK: - SCORE
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                }
                // MARK: - SLOTS
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - REEL #1
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        Spacer()
                        
                        // MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: - SPIN BUTTN
                    Button {
                        // reset game
                        self.spinReels()
                        // check winning
                        self.checkWinning()
                    } label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                } // SLOT MACHINE
                .layoutPriority(2)
                // MARK: - FOOTER


                Spacer()
                
                HStack {
                    // MARK: - BET 20
                    HStack(alignment: .center, spacing: 10) {
                        Button {
                            self.activateBet20()
                        } label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundStyle(isActiveBet20 ? Color("ColorYellow") : Color.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                    }
                    // MARK: - BET 10
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        Button {
                            self.activateBet10() // 10 coins
                        } label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundStyle(isActiveBet10 ? Color("ColorYellow") : Color.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                    }
                }
            }
            // MARK: - BUTTONS
            .overlay(alignment: .topLeading) {
                Button {
                    print("reset game")
                } label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                        
                }
                .modifier(ButtonModifier())
            }
            
            .overlay(alignment: .topTrailing) {
                Button {
                    self.showingInfoView = true
                } label: {
                    Image(systemName: "info.circle")
                        
                }
                .modifier(ButtonModifier())
            }
            
            .padding()
            .frame(maxWidth: 720)
            
            // MARK: - POPUP

        }
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

#Preview {
    ContentView()
}
