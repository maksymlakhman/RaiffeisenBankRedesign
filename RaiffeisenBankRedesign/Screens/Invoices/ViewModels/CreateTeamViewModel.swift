//
//  CreateTeamViewModel.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI

final class CreateTeamViewModel : ObservableObject {
    @Published var teamNameTextTF : String = ""
    @Published var teamEmailTextTF : String = ""
    @Published var selectedRegion: TeamRegionCountry = .ukraine
    @Published var color : Color = Color.green
}
