//
//  RootScreenModel.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 13.05.2024.
//

import Foundation
import Combine

final class RootScreenModel : ObservableObject {
    @Published private(set) var authState = AuthState.pending
    private var cancellable : AnyCancellable?
    init(){
        cancellable = AuthManager.shared.authState.receive(on: DispatchQueue.main)
            .sink {[weak self] latestAuthState in
                self?.authState = latestAuthState
            }
        
//        AuthManager.textAccounts.forEach { email in
//            regesterTestAccount(with : email)
//        }
    }
    
//    private func regesterTestAccount(with email : String) {
//        Task {
//            let username = email.replacingOccurrences(of: "@test.com", with: "")
//            try? await AuthManager.shared.createAccount(for: username, with: email, and: "123qwe")
//        }
//    }
}
