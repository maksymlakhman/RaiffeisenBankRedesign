//
//  RootScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 13.05.2024.
//

import SwiftUI

struct RootScreen: View {
    @StateObject private var viewModel = RootScreenModel()
    var body: some View {
        switch viewModel.authState {
        case .pending:
            ProgressView()
                .controlSize(.large)
        case .loggedIn(let loggedInUser):
            RootTabBar(loggedInUser)
        case .loggedOut:
            WelcomeScreen()
        }
    }
}

#Preview {
    RootScreen()
}
