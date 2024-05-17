//
//  SettingsScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 08.05.2024.
//

import SwiftUI

struct HistoryScreen: View {
    @State private var showSettings = false
    var body: some View {
        NavigationStack{
            VStack{
                Button("View Settings") {
                            showSettings = true
                        }
                        .sheet(isPresented: $showSettings) {
                            ChatScreen()
                                .presentationDetents(
                                    [.height(120), .medium, .large])
                                .presentationBackgroundInteraction(
                                    .enabled(upThrough: .height(120)))
                        }
            }
        }
    }
}

#Preview {
    HistoryScreen()
}
