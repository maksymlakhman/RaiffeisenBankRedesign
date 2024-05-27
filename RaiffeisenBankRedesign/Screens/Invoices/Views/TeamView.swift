//
//  TeamView.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI
import SwiftData

struct TeamView: View {
    @Query(sort: \User.name) var teamUsers: [User]
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var team: TeamModel
    var card : Card
   
    
    var body: some View {
        VStack {
            ListUsers(team: team, card: card, teamUsers: teamUsers)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(team.teamName)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
//                DeleteTeamButton(team: team)
            }
        }
    }
}
