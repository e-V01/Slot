//
//  Extensions.swift
//  Slot
//
//  Created by Y K on 20.03.2024.
//

import SwiftUI

extension Text {
    func scoreLabelStyle() -> Text {
        self
            .foregroundStyle(Color.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    func scoreNumberStyle() -> Text {
        self
            .foregroundStyle(Color.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}

struct ScoreNumberModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
            .layoutPriority(1)
    }
}
