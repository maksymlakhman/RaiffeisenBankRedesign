//
//  LoginScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 10.05.2024.
//

import SwiftUI

struct LoginScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                LoginMainView()
//                AuthCharNumberField(
//                    firstIntCharCode: $loginViewModel.firstIntCharCode,
//                    secondIntCharCode: $loginViewModel.secondIntCharCode,
//                    thirdIntCharCode: $loginViewModel.thirdIntCharCode,
//                    type: .number
//                )
                OtpFormFieldView()
                LoginToRegestrationSignUpButtonView()
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
    
    
    
    private func LoginMainView() -> some View {
        VStack{
            Spacer()
            LoginHeaderMainGroupView()
            AuthTextField(type: .email, text: $authViewModel.email)
            AuthTextField(type: .password, text: $authViewModel.password)
            AuthButtonView(title: "Sign In") {
                Task {
                    await authViewModel.handleLoginMethod()
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
    
    
    
    private func LoginHeaderMainGroupView() -> some View {
        Group {
//            Text("Login Account")
//                .font(.system(size: 26, weight: .medium, design: .rounded))
//                .foregroundStyle(.darkGray)
//            Text("Discover your social & Try to Login")
//                .font(.system(size: 16, weight: .light, design: .default))
//                .foregroundStyle(Color(.systemGray))
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
    
    
    private func LoginToRegestrationSignUpButtonView() -> some View {
        Button {
            dismiss()
        } label: {
            HStack{
                Image(systemName: "sparkles")
                (
                    Text("Don't have an account?")
                    +
                    Text(" ")
                    +
                    Text("Sign Up here")
                        .bold()
                        .foregroundStyle(.black)
                
                )
                Image(systemName: "sparkles")
            }
            .foregroundStyle(.darkGray)
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
}



#Preview {
    LoginScreen()
}
