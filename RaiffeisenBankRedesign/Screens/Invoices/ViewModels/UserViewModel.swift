//
//  UserViewModel.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import Foundation
import SwiftUI


struct UserAccountModel {
    var image: String = "3dPerson"
    var userName: String

    var userHeader: String {
        get { return userName }
        set { userName = newValue }
    }

    init(image: String = "3dPerson", userName: String = "Max") {
        self.image = image
        self.userName = userName
    }
}

class UserViewModel: ObservableObject {
    @Published var user: UserAccountModel

    init(user: UserAccountModel = UserAccountModel()) {
        self.user = user
    }
}
