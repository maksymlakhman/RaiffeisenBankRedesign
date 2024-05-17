//
//  AuthCharNumberField.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 11.05.2024.
//

import SwiftUI

struct AuthCharNumberField: View {
    
    enum FocusableField: Hashable, CaseIterable {
        case firstIntCharCode, secondIntCharCode, thirdIntCharCode
    }
    
    @FocusState private var firstNameFieldIsFocused: Bool
    @FocusState private var focusedField: FocusableField?
    
    
    @Binding var firstIntCharCode : String
    @Binding var secondIntCharCode : String
    @Binding var thirdIntCharCode : String
    
    
    let type : InputAuthType
    
    
    var body: some View {
        HStack {
            TextField("", text: $firstIntCharCode)
                .textFieldStyle(.plain)
                .font(.system(.title3, design: .monospaced, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                .background(
                    Circle()
                        .fill(.white)
                )
                .multilineTextAlignment(.center)
                .keyboardType(type.keyboardType)
                .focused($focusedField, equals: .firstIntCharCode)
                .onChange(of: firstIntCharCode) { _, _ in
                    checkCharNumberField()
                }
            TextField("", text: $secondIntCharCode)
                .textFieldStyle(.plain)
                .font(.system(.title3, design: .monospaced, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 40, height: 40).padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                .background(
                    Circle()
                        .fill(.white)
                )
                .multilineTextAlignment(.center)
                .keyboardType(type.keyboardType)
                .focused($focusedField, equals: .secondIntCharCode)
                .onChange(of: secondIntCharCode) { _, _ in
                    checkCharNumberField()
                }
            TextField("", text: $thirdIntCharCode)
                .textFieldStyle(.plain)
                .font(.system(.title3, design: .monospaced, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 40, height: 40).padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                .background(
                    Circle()
                        .fill(.white)
                )
                .multilineTextAlignment(.center)
                .keyboardType(type.keyboardType)
                .focused($focusedField, equals: .thirdIntCharCode)
                .onChange(of: thirdIntCharCode) { _, _ in
                    checkCharNumberField()
                }
        }
        .onAppear(perform: focusFirstField)
        .onSubmit(focusNextField)
    }
    
    private func focusFirstField() {
        focusedField = FocusableField.allCases.first
    }
    
    private func focusNextField() {
            switch focusedField {
            case .firstIntCharCode:
                focusedField = .secondIntCharCode
            case .secondIntCharCode:
                focusedField = .thirdIntCharCode
            case .thirdIntCharCode:
                focusedField = nil
            case .none:
                break
            }
        }

//    private func checkCharNumberField() {
//        if firstIntCharCode.count > 1 {
//            focusedField = .secondIntCharCode
//        } else if secondIntCharCode.count > 1  {
//            focusedField = .thirdIntCharCode
//        } else if thirdIntCharCode.count > 1 {
//            focusedField = .firstIntCharCode
//        } else if firstIntCharCode.isEmpty {
//            focusedField = .firstIntCharCode
//        } else if secondIntCharCode.isEmpty {
//            focusedField = .secondIntCharCode
//        } else if thirdIntCharCode.isEmpty {
//            focusedField = .thirdIntCharCode
//        } else {
//            // Save...
//        }
//    }
    
    private func checkCharNumberField() {
        if firstIntCharCode.isEmpty {
            focusedField = .firstIntCharCode
        } else if secondIntCharCode.isEmpty {
            focusedField = .secondIntCharCode
        } else if thirdIntCharCode.isEmpty {
            focusedField = .thirdIntCharCode
        }
    }


}

extension AuthCharNumberField {
    enum InputAuthType {
        case number
        
        var keyboardType : UIKeyboardType {
            switch self {
            case .number:
                return .numberPad
            }
        }
    }
    
}

#Preview {
    ZStack {
        Color.mainYellow
        HStack {
            AuthCharNumberField(firstIntCharCode: .constant("1"), secondIntCharCode: .constant("2"), thirdIntCharCode: .constant("3"), type: .number)
        }
    }
}
