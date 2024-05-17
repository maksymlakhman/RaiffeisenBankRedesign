//
//  RegestrationScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 12.05.2024.
//

import SwiftUI

struct RegestrationScreen: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authViewModel : AuthViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                RegestrationMainView()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(.mainYellow)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                backButton()
            }
        }
    }
    
    
    private func backButton() -> some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.darkGray)
            }
        }
    }
    
    
    private func RegestrationMainView() -> some View {
        VStack{
            Spacer()
            RegestrationHeaderMainGroupView()
            Spacer()
            AuthTextField(type: .email, text: $authViewModel.email)
            let userNameInputType = AuthTextField.InputType.custom("Username", "at")
            
            AuthTextField(type: userNameInputType, text: $authViewModel.username)
            AuthTextField(type: .password, text: $authViewModel.password)
            AuthButtonView(title: "Create an Account") {
                Task {
                    await authViewModel.handleSignUp()
                }
            }
            .disabled(authViewModel.disableLoginButton)
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.white)
        }
        .padding()
    }
    
    
    private func RegestrationHeaderMainGroupView() -> some View {
        Group {
            Text("Regestration Account")
                .font(.system(size: 26, weight: .medium, design: .rounded))
                .foregroundStyle(.darkGray)
            Text("Discover your social & Try to Regestration")
                .font(.system(size: 16, weight: .light, design: .default))
                .foregroundStyle(Color(.systemGray))
            Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.vertical, 10)
            (
                Text("Raiffeisen")
                    .foregroundStyle(.mainYellow)
                +
                Text("Bank")
                    .foregroundStyle(.darkGray)
            )
            .textCase(.uppercase)
            .font(.system(size: 32, weight: .bold, design: .monospaced))
        }
    }
}

#Preview {
    RegestrationScreen(authViewModel: AuthViewModel())
}
