//
//  RealView.swift
//  Slot
//
//  Created by Y K on 20.03.2024.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

#Preview {
    ReelView()
}
