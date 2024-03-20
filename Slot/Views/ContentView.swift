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
