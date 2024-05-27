//
//  CreateTeamView.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI
import SwiftData

struct CreateTeamView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var createTeamViewModel : CreateTeamViewModel
    var card : Card
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 36, bottomTrailingRadius: 0, topTrailingRadius: 15, style: .circular)
                        .fill(card.hexColor.opacity(0.6))
                    
                    VStack(alignment: .leading, spacing: 0){
                        Section(header: Text("Назва команди")){
                            TextField("Назва команди*", text: $createTeamViewModel.teamNameTextTF)
                                .textFieldStyle(.roundedBorder)
                                .padding(.top, 10)
                                
                        }
                        
                        Section(header: Text("Email команди")){
                            TextField("Email команди*", text: $createTeamViewModel.teamEmailTextTF)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.top, 10)
                        Section(header: Text("Оберіть регіон")){
                            Picker("Оберіть регіон", selection: $createTeamViewModel.selectedRegion) {
                                HStack {
                                    Text(TeamRegionCountry.ukraine.description + TeamRegionCountry.ukraine.rawValue)
                                }
                                .tag(TeamRegionCountry.ukraine)
                                HStack {
                                    Text(TeamRegionCountry.usa.description + TeamRegionCountry.usa.rawValue)
                                }
                                .tag(TeamRegionCountry.usa)
                                HStack {
                                    Text(TeamRegionCountry.uk.description + TeamRegionCountry.uk.rawValue)
                                }
                                .tag(TeamRegionCountry.uk)
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 100)
                            
                        }
                        
                        .foregroundColor(card.hexColor)
                        .padding(.top, 10)
                        ColorPicker("Оберіть колір", selection: $createTeamViewModel.color, supportsOpacity: false)
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
                                .fill(card.hexColor.opacity(0.6))
                            Button {
                                let newteam = TeamModel(teamName: createTeamViewModel.teamNameTextTF, teamEmail: createTeamViewModel.teamEmailTextTF, region: createTeamViewModel.selectedRegion, color: createTeamViewModel.color.toHexString()!)
                                context.insert(newteam)
                                dismiss()
                            } label: {
                        
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(card.hexColor)
                                    Text("Створити команду")
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
            .padding(.bottom, 60)
            .navigationTitle("Створення команди")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
        }
    }
}
