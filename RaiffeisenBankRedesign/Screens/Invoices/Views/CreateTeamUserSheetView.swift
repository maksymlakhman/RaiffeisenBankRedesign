//
//  CreateTeamUserSheetView.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI

struct CreateTeamUserSheetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var createTeamUserViewModel : CreateTeamUserViewModel
    var team: TeamModel
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 36, bottomTrailingRadius: 0, topTrailingRadius: 15, style: .circular)
                    .fill(team.hexColor.opacity(0.6))
                
                VStack(alignment: .leading, spacing: 0){
                    Section(header: Text("Імʼя співробітника")){
                        TextField("Введіть Імʼя співробітника*", text: $createTeamUserViewModel.userName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.top, 10)
                            .autocorrectionDisabled()
                        
                    }
                    
                    Section(header: Text("Прізвище співробітника")){
                        TextField("Введіть Прізвище співробітника*", text: $createTeamUserViewModel.userLastName)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                    }
                    .padding(.top, 10)
                    ColorPicker("Оберіть колір індикатора", selection: $createTeamUserViewModel.color, supportsOpacity: false)
                        .padding(.vertical, 20)
                    Spacer()
                }
                .fontWeight(.semibold)
                .tint(.green)
                .padding()
                
            }
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 0) {
                    ZStack {
                        UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 36, bottomTrailingRadius: 36, topTrailingRadius: 0, style: .circular)
                            .fill(team.hexColor.opacity(0.6))
                        Button {
                            let newUser = User(name: createTeamUserViewModel.userName, userLastName : createTeamUserViewModel.userLastName, color: createTeamUserViewModel.color.toHexString()!)
                            context.insert(newUser)
                            dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(team.hexColor)
                                Text("Створити користувача")
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                            }
                            .padding(16)
                            
                        }
                    }
                }
                .frame(maxWidth: 200, maxHeight: 100)
            }
        }
        .padding()
    }
}
