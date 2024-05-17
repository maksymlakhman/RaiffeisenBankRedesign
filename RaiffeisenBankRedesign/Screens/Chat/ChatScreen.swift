//
//  ChatScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 09.05.2024.
//

import SwiftUI

struct ChatScreen: View {
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                
            }
            .background(.mainYellow)
            .listStyle(.grouped)
            .navigationTitle("Chat")
        }
    }
}

#Preview {
    ChatScreen()
}
