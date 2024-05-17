//
//  BottomSheet.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 14.05.2024.
//

import SwiftUI

struct SheetPresenter<Content>: View where Content: View {
    @Binding var presentingSheet: Bool
    var content: Content
    var body: some View {
        Text("")
            .sheet(isPresented: self.$presentingSheet, content: { self.content })
            .onAppear {
                DispatchQueue.main.async {
                    self.presentingSheet = true
                }
            }
    }
}
