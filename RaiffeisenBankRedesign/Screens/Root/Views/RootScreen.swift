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
            CustomProgressView()
                .controlSize(.large)
        case .loggedIn(let loggedInUser):
            RootTabBar(loggedInUser)
        case .loggedOut:
            if isFirstLaunch() {
                SplashView()
            } else {
                WelcomeScreen()
            }

        }
    }
    
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "hasLaunchedBefore") {
            return false
        } else {
            defaults.set(true, forKey: "hasLaunchedBefore")
            return true
        }
    }
}

#Preview {
    RootScreen()
}

