//
//  ProfileScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 08.05.2024.
//

import SwiftUI

struct ServicesScreen: View {
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                
            }
            .background(.mainYellow)
            .listStyle(.grouped)
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ServicesScreen()
}
