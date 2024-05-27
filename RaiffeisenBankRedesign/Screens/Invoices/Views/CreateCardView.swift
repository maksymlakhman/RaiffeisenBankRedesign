//
//  CreateCardView.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI

extension String {
    func insertingSeparator(every n: Int, separator: Character) -> String {
        var result: [Character] = []
        var count = 0
        
        for char in self {
            if count == n {
                result.append(separator)
                count = 0
            }
            result.append(char)
            count += 1
        }
        
        return String(result)
    }
}

struct CreateCardView: View {
    @Binding var present : Bool
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var сreateCardViewModel : CreateCardViewModel
    
    var body: some View {
        VStack {
            VStack {
                Form {
                    VStack(alignment: .center) {
                        Text("Створити віртуальний рахунок")
                            .fontWeight(.bold)
                        Picker("Оберіть логотип", selection: $сreateCardViewModel.selectedLogo) {
                            HStack {
                                Image(.mastercardLogo)
                                    .resizable()
                                    .scaledToFit()
                                Text(LogoCard.mastercard.description)
                            }
                            .tag(LogoCard.mastercard)
                            HStack {
                                Image(.visa)
                                    .resizable()
                                    .scaledToFit()
                                Text(LogoCard.visa.description)
                            }
                            .tag(LogoCard.visa)
                            HStack {
                                Image(.mono)
                                    .resizable()
                                    .scaledToFit()
                                Text(LogoCard.mono.description)
                            }
                            .tag(LogoCard.mono)
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 120)


                        TextField("Номер рахунку*", text: $сreateCardViewModel.name)
                            .keyboardType(.numberPad)
                            .onChange(of: сreateCardViewModel.name) { _, newValue in
                                let stripped = newValue.replacingOccurrences(of: " ", with: "")
                                сreateCardViewModel.name = stripped.insertingSeparator(every: 4, separator: " ")
                                сreateCardViewModel.limitTextFieldInput(to: 20, newValue: &сreateCardViewModel.name)
                                сreateCardViewModel.showEmptyFieldsWarning = false
                                сreateCardViewModel.showAYouSureWarning = false
                        }
                        if сreateCardViewModel.showAYouSureWarning {
                            withAnimation(.spring) {
                                Text("Не повний номер рахунку")
                                    .foregroundColor(.red)
                                    .padding(.top, 10)
                                    .font(.footnote)
                            }
                            
                        }
                    }
                    CoinTextField(coins: $сreateCardViewModel.coins)
                    
                    ColorPicker("Оберіть колір картки", selection: $сreateCardViewModel.color, supportsOpacity: false)
                    Button {
                        let strippedName = сreateCardViewModel.name.replacingOccurrences(of: " ", with: "")
                        if strippedName.count != 16 {
                            сreateCardViewModel.showAYouSureWarning = true
                        }
                        if strippedName.count == 16 && сreateCardViewModel.coins ?? 0 > 0 {
                            let newCard = Card(_color: сreateCardViewModel.color.toHexString()!, _name: сreateCardViewModel.name, _coins: сreateCardViewModel.coins ?? 0, _creationDate: сreateCardViewModel.creationDate, _expirationDate: сreateCardViewModel.expirationDate, _tokenCode: Int.random(in: 100...999), _logoCard: сreateCardViewModel.selectedLogo)
                            context.insert(newCard)
                            сreateCardViewModel.name = ""
                            сreateCardViewModel.coins = nil
                            dismiss()
                        } else {
                            withAnimation(.easeOut(duration: 0.4)){
                                сreateCardViewModel.showEmptyFieldsWarning = true
                            }
                        }
                    } label: {
                        if сreateCardViewModel.name.isEmpty || сreateCardViewModel.coins == 0 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray)
                                Text("Створити рахунок")
                                    .foregroundColor(.secondary)
                            }.padding(.horizontal)
                                .frame(minHeight: 50, maxHeight: 70)
                        } else {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.mainYellow)
                                Text("Створити рахунок")
                                    .foregroundColor(.secondary)
                            }.padding(.horizontal)
                                .frame(minHeight: 50, maxHeight: 70)
                        }
                        
                    }
                }
                
            }
            
            if сreateCardViewModel.showEmptyFieldsWarning {
                withAnimation(.spring) {
                    Text("Будь-ласка заповніть всі поля")
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
            }

            
        }
        .task {
            present = false
        }
        .navigationTitle("New 💳")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    сreateCardViewModel.name = ""
                    сreateCardViewModel.coins = nil
                    dismiss()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.gray)

                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16, alignment: .center)
                            .padding(14)
                            .foregroundColor(Color("MainBackgroundIconColor"))
                    }
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding(.leading, 10)
                }
                
            }
        }
    }

}


final class CreateCardViewModel: ObservableObject {
    @Published var color: Color = .blue
    @Published var name: String = ""
    @Published var coins: Double?
    @Published var showEmptyFieldsWarning: Bool = false
    @Published var showAYouSureWarning: Bool = false
    @Published var creationDate = Date.now
    @Published var expirationDate = Date.distantPast
    @Published var selectedLogo: LogoCard = .mastercard

    func validateFields() -> Bool {
        if name.isEmpty || (coins ?? 0) <= 0 {
            showEmptyFieldsWarning = true
            return false
        } else if name.count != 16 {
            showAYouSureWarning = true
            return false
        } else {
            return true
        }
    }

    func limitTextFieldInput(to limit: Int, newValue: inout String) {
      if newValue.count > limit {
        newValue = String(newValue.prefix(limit))
      }
    }
}



struct CoinTextField: View {
    @Binding var coins: Double?

    private var text: Binding<String> {
        Binding(
            get: {
                coins != nil ? String(format: "%.0f", coins!) : ""
            },
            set: { newValue in
                if newValue.isEmpty {
                    coins = nil
                } else if let value = Double(newValue) {
                    coins = value
                }
            }
        )
    }

    var body: some View {
        TextField("Зарахування*", text: text)
            .keyboardType(.numberPad)
    }
    
}

