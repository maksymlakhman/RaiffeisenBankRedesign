//
//  LoginScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 10.05.2024.
//

import SwiftUI

struct WelcomeScreen: View {
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                WelcomeHeaderMainView()
                WelcomeGroupLoginAndScannerButtonsNavigation()
                WelcomeBecomeAClientRegestrationButtonNavigation()
            }
            .navigationBarBackButtonHidden()
            .toolbar{
                leadingNavItem()
            }
//            .sheet(isPresented: $loginViewModel.showLoginScreenSheet) {
//                LoginScreen()
//                    .presentationDetents([.fraction(0.95)])
//                    .presentationCornerRadius(60)
//            }
        }
    }
    
    private func WelcomeGroupLoginAndScannerButtonsNavigation() -> some View {
        HStack(spacing: 0) {
            WelcomeLogInNavigationLink()
            WelcomeScannerFaceButtonNavigation()
        }
        .padding()
        .padding(.top, 40)
    }
    
    private func WelcomeLogInNavigationLink() -> some View {
        NavigationLink {
            LoginScreen()
        } label: {
            Text("Log In")
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .tint(.white)
                .bold()
                .background(Color.darkGray)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding(.trailing, 20)
        }
    }
    
    private func WelcomeScannerFaceButtonNavigation() -> some View {
        Button{
            
        } label: {
           Image(systemName: "faceid")
                .resizable()
                .padding(15)
                .frame(width: 60 ,height: 60)
                .tint(.white)
                .background(Color.darkGray)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
        }
    }
    
    private func WelcomeBecomeAClientRegestrationButtonNavigation() -> some View {
        NavigationLink {
            RegestrationScreen(authViewModel: authViewModel)
        } label: {
            Text("Become a client")
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .tint(.darkGray)
                .bold()
                .background(Color.mainYellow)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding(.horizontal, 20)
        }
    }
    
    
    
}


extension WelcomeScreen {
    
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                
            } label: {
                Image(systemName: "line.horizontal.3.decrease")
                    .foregroundStyle(.darkGray)
            }

        }
    }
}

#Preview {
    WelcomeScreen()
}
