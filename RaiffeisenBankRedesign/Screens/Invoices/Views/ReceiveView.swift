//
//  ReceiveView.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI

struct ReceiveView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var calculatorReceiveViewModel: ReceiveViewModel
    
    var card : Card
    var color : String = "MainRedMainColor"
    
    @FocusState var sendIsFocused: Bool
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Калькулятор зарплати")) {
                    HStack {
                        TextField("Номер рахунку", text: $calculatorReceiveViewModel.accountNumber)
                            .keyboardType(.asciiCapableNumberPad)
                            .onChange(of: calculatorReceiveViewModel.accountNumber) { oldValue, newValue in
                                let cleanedValue = newValue.replacingOccurrences(of: " ", with: "")
                                if cleanedValue.count <= 16 {
                                    let formattedValue = calculatorReceiveViewModel.formatAccountNumber(cleanedValue)
                                    
                                    calculatorReceiveViewModel.accountNumber = formattedValue
                                } else {
                                    calculatorReceiveViewModel.accountNumber = String(cleanedValue.prefix(16))
                                }
                            }
                            .focused($sendIsFocused)
                    }
                    HStack {
                        TextField("Погодинна ставка", text: $calculatorReceiveViewModel.hourlyRate)
                            .keyboardType(.numberPad)
                            .focused($sendIsFocused)
                    }

                    HStack {
                        TextField("Відпрацьовані години", text: $calculatorReceiveViewModel.hoursWorked)
                            .keyboardType(.numberPad)
                            .focused($sendIsFocused)
                    }
                    HStack {
                        TextField("Податкова ставка", text: Binding(
                            get: { calculatorReceiveViewModel.taxRate ?? "" },
                            set: { calculatorReceiveViewModel.taxRate = $0.isEmpty ? nil : $0 }
                        ))
                        .keyboardType(.numberPad)
                        .focused($sendIsFocused)
                    }

                    HStack {
                        TextField("Бонуси", text: Binding(
                            get: { calculatorReceiveViewModel.bonuses ?? "" },
                            set: { calculatorReceiveViewModel.bonuses = $0.isEmpty ? nil : $0 }
                        ))
                        .keyboardType(.numberPad)
                        .focused($sendIsFocused)
                    }
                    
                    CustomTextEditor.init(placeholder: "Почни писати свій коментар..", text: $calculatorReceiveViewModel.comments)
                        .font(.body)
                        .accentColor(.red)
                        .frame(height: 200)
                        .cornerRadius(8)
                    
                    

                }
                
            }
            .scrollIndicators(.hidden)
            .listRowSpacing(20)
            .foregroundColor(Color("MainTextAndForegroundIconColor"))

            Button {
                let item = TransactionItemDataModel(card: card, defaultImage: "t.circle.fill", operationOptionImage: .receive, currentTimeAndDate: Date(), userTransfers: Double(calculatorReceiveViewModel.finalNetSalary) ?? 0.00)
                card.transactionItemsDataModel?.append(item)
                dismiss()
                sendIsFocused = false
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("MainTextAndForegroundIconColor"))
                    HStack {
                        Text("Send ₴\(calculatorReceiveViewModel.finalNetSalary)")
                        Image(systemName: "arrowshape.bounce.forward")
                    }
                    .foregroundStyle(Color("MainBackgroundIconColor"))
                }
                .frame(maxHeight: 100)
                .padding()
            }
            .padding(.bottom, 80)
            .onChange(of: [calculatorReceiveViewModel.hourlyRate, calculatorReceiveViewModel.hoursWorked, calculatorReceiveViewModel.taxRate, calculatorReceiveViewModel.bonuses]) { oldValue, newValue in
                calculatorReceiveViewModel.pushSalary()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}



struct CustomTextEditor: View {
    let placeholder: String
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty  {
                Text(placeholder)
                    .foregroundColor(Color.primary.opacity(0.25))
                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0))
            }
            TextEditor(text: $text)
        }
        .onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}


