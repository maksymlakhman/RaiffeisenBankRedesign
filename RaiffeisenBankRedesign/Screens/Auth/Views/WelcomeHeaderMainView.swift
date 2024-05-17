//
//  AuthHeaderMainView.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 10.05.2024.
//

import SwiftUI

struct WelcomeHeaderMainView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack {
                Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                    .resizable()
                    .frame(width: 60, height: 60)
                Spacer()
            }
            .padding(.bottom, 80)
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("Welcome to")
                    Text("the new")
                    Text("Raiffeisen Bank")
                }
                .font(.largeTitle)
                .foregroundStyle(Color(.systemGray))
                .fontWeight(.medium)
            }
            .padding(.bottom, 40)
            
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("New level of features")
                    Text("with new app")
                }
                .font(.headline)
                .foregroundStyle(Color(.systemGray2))
                .fontWeight(.regular)
            }
        }
        .padding(.leading, 20)
    }
}

#Preview {
    WelcomeHeaderMainView()
}
