//
//  ContentView.swift
//  Slot
//
//  Created by Y K on 20.03.2024.
//

import SwiftUI

struct ContentView: View {
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
                        
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("200")
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
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        Spacer()
                        
                        // MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: - SPIN BUTTN
                    Button {
                        // reset game
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
                    print("Info view")
                } label: {
                    Image(systemName: "info.circle")
                        
                }
                .modifier(ButtonModifier())
            }
            
            .padding()
            .frame(maxWidth: 720)
            
            // MARK: - POPUP

        }
        
        .padding()
    }
    
}

#Preview {
    ContentView()
}
