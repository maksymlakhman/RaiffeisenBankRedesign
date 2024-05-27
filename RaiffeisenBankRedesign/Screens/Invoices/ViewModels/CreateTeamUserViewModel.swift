//
//  CreateTeamUserViewModel.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI

final class CreateTeamUserViewModel : ObservableObject {
    @Published var userName : String = ""
    @Published var userLastName : String = ""
    @Published var color = Color.green
}
