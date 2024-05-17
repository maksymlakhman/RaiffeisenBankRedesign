//
//  LoginViewModel.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 10.05.2024.
//

import Foundation

@MainActor
final class AuthViewModel : ObservableObject {
    // MARK: Published Properties
//    @Published var showLoginScreenSheet = false
    @Published var isLoading : Bool = false
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var username : String = ""
    @Published var errorState : (showError : Bool, errorMessage: String) = (false, "Uh oh")
    
    @Published var firstIntCharCode : String = ""
    @Published var secondIntCharCode : String = ""
    @Published var thirdIntCharCode : String = ""
    
    
    // MARK: Computed Properties
    var disableLoginButton : Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignUpButton : Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }
    
    func handleSignUp() async {
        isLoading = true
        do {
            try await AuthManager.shared.createAccount(for: username, with: email, and: password)
        } catch {
            errorState.errorMessage = "Failed to create an account \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }
    
    func handleLoginMethod() async {
        isLoading = true
        do {
            try await AuthManager.shared.login(with: email, and: password)
        } catch {
            errorState.errorMessage = "Failed to login \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }
    
}
