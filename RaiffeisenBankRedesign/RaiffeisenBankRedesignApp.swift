//
//  RaiffeisenBankRedesignApp.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 17.05.2024.
//

import SwiftUI
import Firebase
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct RaiffeisenBankNeomorphStyleRedesignApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let container: ModelContainer
    @StateObject var сardListViewModel = CardItemViewModel()
    @StateObject var createCardViewModel = CreateCardViewModel()
    @StateObject var itemCardViewModel = ItemCardViewModel()
    @StateObject var userViewModel = UserViewModel()
    @StateObject var userAdditionTeamUserViewModel =  CreateTeamUserViewModel()
    @StateObject var receiveViewModel = ReceiveViewModel()
    @StateObject var salaryCalculatorViewModel = SalaryCalculatorViewModel()
    @StateObject var createTeamViewModel = CreateTeamViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .modelContainer(
                    container
                )
                .environmentObject(
                    userViewModel
                )
                .environmentObject(
                    userAdditionTeamUserViewModel
                )
                .environmentObject(
                    сardListViewModel
                )
                .environmentObject(
                    createCardViewModel
                )
                .environmentObject(
                    itemCardViewModel
                )
                .environmentObject(
                    receiveViewModel
                )
                .environmentObject(
                    salaryCalculatorViewModel
                )
                .environmentObject(
                    createTeamViewModel
                )
        }
    }
    
    init() {
        let schema = Schema(
            [
                Card.self,
                TeamModel.self,
                User.self,
                TransactionItemDataModel.self
            ]
        )
        let config = ModelConfiguration(
            "MyCards",
            schema: schema
        )
        do {
            container = try ModelContainer(
                for: schema,
                configurations: config
            )
        } catch {
            fatalError(
                "Could not configure the container"
            )
        }
        print(
            URL.applicationSupportDirectory.path(
                percentEncoded: false
            )
        )
    }}
