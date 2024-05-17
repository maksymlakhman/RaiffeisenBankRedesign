//
//  OtpModifer.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 12.05.2024.
//

import SwiftUI
import Combine

struct OtpModifer: ViewModifier {

    @Binding var pin : String

    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    
    @ViewBuilder private var activeCircleNeoMorphStyle: some View {
        LinearGradient(colors: [.init(white: 0.9), .mainYellow, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask {
                Circle()
                    .stroke(lineWidth: 3)
            }
            .shadow(color: .darkGray.opacity(0.3), radius: 2, x: 2.5, y: 5)
            .clipShape(Circle())
    }
    
    @ViewBuilder private var notActiveCircleNeoMorphStyle: some View {
        LinearGradient(colors: [.init(white: 0.9), .white, .darkGray], startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask {
                Circle()
                    .stroke(lineWidth: 1)
            }
            .shadow(color: .white.opacity(0.9), radius: 5, x: 2.5, y: 5)
            .clipShape(Circle())
            .shadow(color: .darkGray.opacity(0.4), radius: 5, x: -2.5, y: -1)
            .clipShape(Circle())
    }

    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .textFieldStyle(.plain)
            .font(.system(.title3, design: .serif, weight: .medium))
            .foregroundColor(.black)
            .frame(width: 40, height: 40).padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
            .background(alignment:.leading){
                VStack(alignment: .center, spacing: 0) {
                    if pin.isEmpty{
                        activeCircleNeoMorphStyle
                            .frame(width: 50, height: 50)
                    } else {
                        notActiveCircleNeoMorphStyle
                            .frame(width: 50, height: 50)
                    }
                }
            }
    }
}


#Preview {
    ZStack {
        Color.mainYellow
        OtpFormFieldView()
    }
}
