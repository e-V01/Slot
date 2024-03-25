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
    let haptics = UINotificationFeedbackGenerator()
    
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    
    //MARK: - FUNC
    // spin reels
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    // check winning
    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            // player wins
            playerWins()
            // new high score
            if coins > highScore {
                newHighScore()
            } else {
                playSound(sound: "win", type: "mp3")
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
        UserDefaults.standard.set(highScore, forKey: "HighScore")
        playSound(sound: "high-score", type: "mp3")
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func activateBet10() {
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func isGameOver() {
        if coins <= 0 {
            showingModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        // override score to 0
        highScore = 0
        //reset score to 0
        coins = 100
        // reset back to 100
        activateBet10()
        // reset to 10 in case been 20
        playSound(sound: "chimeup", type: "mp3")
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
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -100)
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                            .onAppear {
                                self.animatingSymbol.toggle()
                                // will trigger animation after it appeared on screen
                                playSound(sound: "riseup", type: "mp3")
                            }
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -100)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear {
                                    self.animatingSymbol.toggle()
                                    
                                }
                        }
                        Spacer()
                        
                        // MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -100)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear {
                                    self.animatingSymbol.toggle()
                                    
                                }
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: - SPIN BUTTN
                    Button {
                        // 1. Set default state
                        withAnimation {
                            self.animatingSymbol = false
                        }
                        // 2. Spin reels with changing symbols
                        self.spinReels()
                        // 3. Trigger the animation after changing the symbols
                        withAnimation {
                            self.animatingSymbol = true
                        }
                        
                        // 4. Check winning
                        self.checkWinning()
                        
                        // 5. Game over
                        self.isGameOver()
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
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                    }
                    
                    Spacer()
                    
                    // MARK: - BET 10
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet20 ? 0 : -20)
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
                    self.resetGame()
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
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
            // MARK: - POPUP
            if $showingModal.wrappedValue {
                ZStack {
                    Color(Color("ColorTransparentBlack"))
                        .ignoresSafeArea(.all)
                    
                    //MODAL
                    VStack(spacing: 0) {
                        //title
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundStyle(Color.white)
                        
                        Spacer()
                        
                        //message
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad luck! You lost all of the coins. \nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color.gray)
                                .layoutPriority(1)
                            
                            Button {
                                self.showingModal = false
                                self.animatingModal = false
                                self.activateBet10()
                                self.coins = 100
                            } label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .tint(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .stroke(lineWidth: 2)
                                            .foregroundStyle(Color("ColorPink"))
                                        )
                            }
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                    .opacity($animatingModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6,
                                                dampingFraction: 1.0,
                                                blendDuration: 1.0))
                    .onAppear {
                        self.animatingModal = true
                    }
                }
            }
        }
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

#Preview {
    ContentView()
}
