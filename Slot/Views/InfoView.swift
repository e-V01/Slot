//
//  InfoView.swift
//  Slot
//
//  Created by Y K on 20.03.2024.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var pm
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            
            Spacer()
            
            Form {
                Section {
                    FormRowView(firstItem: "Application", 
                                secondtItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms",
                                secondtItem: "iPhone, iPad, Mac")
                    FormRowView(firstItem: "Developers",
                                secondtItem: "Yuriy K.")
                    FormRowView(firstItem: "Designer",
                                secondtItem: "R Petras")
                    FormRowView(firstItem: "Music",
                                secondtItem: "Dan Lebowitz")
                    FormRowView(firstItem: "Website",
                                secondtItem: "SwiftUIMasterclass.com")
                    FormRowView(firstItem: "Copyright",
                                secondtItem: "© 2020 All riight reserved")
                    FormRowView(firstItem: "Version",
                                secondtItem: "1.0.0")
                } header: {
                    Text("About the application")
                }

            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(alignment: .topTrailing) {
            Button {
                self.pm.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
            .padding(.top, 30)
            .padding(.trailing, 20)
            .tint(Color.secondary)
        }
        
    }
}


struct FormRowView: View {
    var firstItem: String
    var secondtItem: String

    var body: some View {
        HStack {
            Text(firstItem)
                .foregroundStyle(Color.gray)
            Spacer()
            Text(secondtItem)
        }
    }
}

#Preview {
    InfoView()
}


