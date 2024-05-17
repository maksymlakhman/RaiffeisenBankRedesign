//
//  AuthTextField.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 10.05.2024.
//

import SwiftUI

struct AuthTextField: View {
    let type : InputType
    @Binding var text: String
    var body: some View {
        HStack {
            Image(systemName: type.image)
                .fontWeight(.semibold)
                .frame(width: 30)
            
            switch type {
            case .password:
                SecureField(type.placeholder, text: $text)
            default:
                TextField(type.placeholder, text: $text)
                    
            }
        }
        .foregroundStyle(.gray)
        .padding()
        .background(roundderRectangleNeoMorphStyle)
        .padding(.horizontal, 32)
    }
}

extension AuthTextField {
    enum InputType {
        case email
        case password
        case custom(_ placeholder: String, _ iconName: String)
        
        var placeholder : String {
            switch self {
            case .email:
                return "Email/ Phone number"
            case .password:
                return "Password"
            case .custom(let placeholder, _):
                return placeholder
            }
        }
        
        var image : String {
            switch self {
            case .email:
                return "envelope"
            case .password:
                return "lock"
            case .custom(_, let iconName):
                return iconName
            }
        }
        
        var keyboardType : UIKeyboardType {
            switch self {
            case .email:
                return .emailAddress
            default:
                return .default
            }
        }
    }
    
    
    @ViewBuilder private var roundderRectangleNeoMorphStyle: some View {
        LinearGradient(colors: [.init(white: 0.9), .white, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(lineWidth: 2)
            }
            .shadow(color: .darkGray.opacity(0.5), radius: 2, x: 2, y: 2.5)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}


#Preview {
    ZStack {
        Color.white
        VStack {
            AuthTextField(type: .email, text: .constant(""))
            AuthTextField(type: .password, text: .constant(""))
            AuthTextField(type: .custom("Birth Date", "birthday.cake"), text: .constant(""))
        }
    }
}
