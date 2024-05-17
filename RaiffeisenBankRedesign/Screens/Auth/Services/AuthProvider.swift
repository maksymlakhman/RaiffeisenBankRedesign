//
//  AuthProvider.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 13.05.2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState {
    case pending, loggedIn(UserItem), loggedOut
}

protocol AuthProvider {
    static var shared : AuthProvider { get }
    var authState : CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async throws
    func login(with email: String, and password : String) async throws
    func createAccount(for username : String, with email : String, and password : String) async throws
    func logOut() async throws
}

enum AuthError : Error {
    case accountCreationFailed(_ description : String)
    case failedToSaveUserInfo(_ description : String)
    case emailLogginFailed(_ description : String)
}

extension AuthError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        case .emailLogginFailed(let description):
            return description
        }
    }
}

final class AuthManager: AuthProvider {
    
    private init() {
        Task {
            await autoLogin()
        }
    }
    
    static let shared: any AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        } else {
            fetchCurrentUserInfo()
        }
    }
    
    func login(with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("🔐 Succesfully signed in \(authResult.user.email ?? "") ")
        } catch {
            print("🔐 failed to sign account with \(email)")
            throw AuthError.emailLogginFailed(error.localizedDescription)
        }
    }
    
    func createAccount(for username: String, with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            let newUser = UserItem(uid: uid, username: username, email: email/*, password: password*/)
            try await saveUserInfoToDataBase(user: newUser)
            self.authState.send(.loggedIn(newUser))
        } catch {
            print("🔐 faild to create an account\(error.localizedDescription)")
            throw AuthError.accountCreationFailed(error.localizedDescription)
        }
    }
    
    func logOut() async throws {
        do {
            try Auth.auth().signOut()
            authState.send(.loggedOut)
            print("🔐 successfuly logged out!")
        } catch {
            print("🔐 Failed to current user: \(error.localizedDescription)")
        }
    }
    

}

extension AuthManager {
    private func saveUserInfoToDataBase(user : UserItem) async throws {
        do {
            let userDictionaty : [String : Any] = [.uid : user.id, .username : user.username, .email : user.email]
            try await FirebaseConstans.UserRef.child(user.uid).setValue(userDictionaty)
        } catch {
            print("🔐 faild to save created user info to databse: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstans.UserRef.child(currentUid).observe(.value) { [weak self] snapShot in
            guard let userDict = snapShot.value as? [String : Any] else { return }
            let loggUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggUser))
            print("\(loggUser.username) is login")
        } withCancel: { error in
            print("failed get current user info")
        }

    }
}

extension AuthManager {
    static let textAccounts: [String] = [
        "TestAccount1@test.com",
        "TestAccount2@test.com",
        "TestAccount3@test.com",
        "TestAccount4@test.com",
        "TestAccount5@test.com",
        "TestAccount6@test.com",
        "TestAccount7@test.com",
        "TestAccount8@test.com",
        "TestAccount9@test.com",
        "TestAccount10@test.com",
        "TestAccount11@test.com",
        "TestAccount12@test.com",
        "TestAccount13@test.com",
        "TestAccount14@test.com",
        "TestAccount15@test.com",
        "TestAccount16@test.com",
        "TestAccount17@test.com",
        "TestAccount18@test.com",
        "TestAccount19@test.com",
        "TestAccount20@test.com",
        "TestAccount21@test.com",
        "TestAccount22@test.com",
        "TestAccount23@test.com",
        "TestAccount24@test.com",
        "TestAccount25@test.com",
        "TestAccount26@test.com",
        "TestAccount27@test.com",
        "TestAccount28@test.com",
        "TestAccount29@test.com",
        "TestAccount30@test.com",
        "TestAccount31@test.com",
        "TestAccount32@test.com",
    ]
}

