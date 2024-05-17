//
//  RaiffeisenBankRedesignApp.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 17.05.2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct RaiffeisenBankNeomorphStyleRedesignApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
