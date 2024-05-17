//
//  OtpFormFieldView.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 12.05.2024.
//

import SwiftUI
import Combine

struct OtpFormFieldView: View {
    //MARK -> PROPERTIES

    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour
    }

    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
//    @State var pinFour: String = ""


    //MARK -> BODY
    var body: some View {
            VStack {
                HStack(spacing:15, content: {

                    TextField("", text: $pinOne)
                        .modifier(OtpModifer(pin:$pinOne))
                        .onChange(of:pinOne){_, newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinTwo
                            }
                        }
                        .focused($pinFocusState, equals: .pinOne)

                    TextField("", text:  $pinTwo)
                        .modifier(OtpModifer(pin:$pinTwo))
                        .onChange(of:pinTwo){_, newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinThree
                            }else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinOne
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinTwo)


                    TextField("", text:$pinThree)
                        .modifier(OtpModifer(pin:$pinThree))
                        .onChange(of:pinThree){_, newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFour
                            }else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinTwo
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinThree)


//                    TextField("", text:$pinFour)
//                        .modifier(OtpModifer(pin:$pinFour))
//                        .onChange(of:pinFour){_, newVal in
//                            if (newVal.count == 0) {
//                                pinFocusState = .pinThree
//                            }
//                        }
//                        .focused($pinFocusState, equals: .pinFour)


                })
                .padding(.vertical)
            }

    }
}


#Preview {
    ZStack {
        Color.mainYellow
        OtpFormFieldView()
    }
}
