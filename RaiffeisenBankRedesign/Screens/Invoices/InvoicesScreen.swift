//
//  CalendarScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 08.05.2024.
//

import SwiftUI

struct InvoicesScreen: View {
    @Binding var present : Bool
    var body: some View {
        CardList(present: $present)
    }
}

#Preview {
    InvoicesScreen(present: .constant(true))
}
