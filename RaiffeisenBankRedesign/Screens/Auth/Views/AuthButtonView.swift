//
//  AuthButton.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 10.05.2024.
//

import SwiftUI

struct AuthButtonView: View {
    let title : String
    let onTap : () -> Void
    @Environment(\.isEnabled) private var isEnabled
    
    private var backgroundColor: Color {
        return isEnabled ? Color.mainYellow : Color.black.opacity(0.3)
    }
    
    private var textColor: Color {
        return isEnabled ? Color.darkGray : Color.mainYellow
    }
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack{
                Text(title)
                Image(systemName: "arrow.right")
            }
            .font(.headline)
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .shadow(color: .mainYellow.opacity(0.2), radius: 10)
            .padding(.horizontal, 32)
        }

    }
}

#Preview {
    ZStack {
        Color.white
        AuthButtonView(title: "Login"){
            
        }
    }
}
